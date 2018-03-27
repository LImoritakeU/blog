title: Mongodb cluster 建置（分片副本集篇）
author: LImoritakeU
tags:
  - mongodb
  - NoSQL
categories: []
date: 2017-11-24 18:05:00
---

分片是 mongodb 用來水平擴充(horizonatal scaling) 的方法，我們先考慮以下兩個情境：

1. 一開始就規劃分片建立大規模 Mongo Cluster。
2. 一開始沒有分片需求，直到業務量持續增加到單機無法應付。

不論是哪一個，通常都需要需要結合副本集一起實作，避免資料遺失，那麼是否可以純分片而不處理副本集呢？當然可以，但是這種情境的實際案例較為缺乏，因此不做討論。

比起純副本集建置，分片副本集顯然要複雜許多，除了每一個分片都需要有各自3個副本集，還需要存放 Metadata 的 config servers 副本集，與處理 mongodb 叢集路由的 mongos


## 準備

```
mkdir -p /data/shard0-replset/logs /data/shard0-replset/data
mkdir -p /data/shard1-replset/logs /data/shard1-replset/data
mkdir -p /data/shard2-replset/logs /data/shard2-replset/data
mkdir -p /data/shard/configdb /data/shard/logs
```

原則：

- 同一個副本集，同一個 port

  副本集應該呈現是一致的組態，使用端口也相同

- 每個分片有自己專屬的 port 與目錄，分片間不應混用

mongod-shard0.conf

```yaml
systemLog:
  destination: file
  logAppend: true
  path: /data/shard0-replset/logs/shard.log

storage:
  dbPath: /data/shard0-replset/data
  journal:
    enabled: true

processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod.pid

net:
  port: 28000
  bindIp: 192.168.33.10

replication:
  replSetName: shard0-replset

sharding:
  clusterRole: shardsvr
```

mongod-shard1.conf

```yaml
systemLog:
  destination: file
  logAppend: true
  path: /data/shard1-replset/logs/shard.log

storage:
  dbPath: /data/shard1-replset/data
  journal:
    enabled: true

processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod.pid

net:
  port: 28001
  bindIp: 192.168.33.10

replication:
  replSetName: shard1-replset

sharding:
  clusterRole: shardsvr
```

mongod-shard2.conf

```yaml
systemLog:
  destination: file
  logAppend: true
  path: /data/shard2-replset/logs/shard.log

storage:
  dbPath: /data/shard2-replset/data
  journal:
    enabled: true

processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod.pid

net:
  port: 28002
  bindIp: 192.168.33.10

replication:
  replSetName: shard2-replset

sharding:
  clusterRole: shardsvr

```

由於部署的數量為三台，因此將這3個組態檔分別複製出去，然後修改 `net.bindIp`即可，並依據組態檔開啟共 9 個 mongod。

```
/usr/bin/mongod -f /etc/mongod-shard0.conf
/usr/bin/mongod -f /etc/mongod-shard1.conf
/usr/bin/mongod -f /etc/mongod-shard2.conf
```

成功會出現

```
about to fork child process, waiting until server is ready for connections.
forked process: 4433
child process started successfully, parent exiting
```

也可以使用 `ps aux| grep mongo` 查看目前進程

```
root      7232  1.9  5.1 1475772 97468 ?       Sl   08:54   1:36 /usr/bin/mongod -f /etc/mongod-shard0.conf
root      7589  1.1  2.1 1016848 40816 ?       Sl   10:12   0:04 /usr/bin/mongod -f /etc/mongod-shard1.conf
root      7676  2.0  2.4 1016848 46292 ?       Sl   10:18   0:00 /usr/bin/mongod -f /etc/mongod-shard2.conf
```

## 建立副本集並初始化

首先進入 mongo0 的 mongo 客戶端`mongo mongo0:28000`

```
rs.initiate()
rs.add("mongo1:28000")
rs.add("mongo2:28000")
```

接著進入 mongo1 的 mongo 客戶端`mongo mongo1:28001`

```
rs.initiate()
rs.add("mongo0:28001")
rs.add("mongo2:28001")
```

最後進入 mongo2 的 mongo 客戶端`mongo mongo2:28002`

```
rs.initiate()
rs.add("mongo0:28002")
rs.add("mongo1:28002")
```

## 建立 config server

嚴格來說，直到上一個步驟，我們所做的都只是分別處理三個毫無關係的副本集而已，接下來步驟才是真正進入分片的階段。

mongo 0, 1, 2 `/etc/mongod-cfg.conf`

```yaml
systemLog:
  destination: file
  logAppend: true
  path: /data/shard/logs/config.log

storage:
  dbPath: /data/shard/configdb
  journal:
    enabled: true

processManagement:
  fork: true
  pidFilePath: /var/run/mongodb/mongod-cfg.pid

net:
  port: 40000
  bindIp: 192.168.33.10 # 注意 IP 要調整

replication:
  replSetName: configReplSet

sharding:
  clusterRole: configsvr
```

在三台執行 `mongod -f /etc/mongod-cfg.conf`

從 3.4 開始， mongodb config servers 需要使用副本集，因此進入任一 mongo config server cli `mongo mongo0:40000`，輸入：

```
rs.initiate()
rs.add("mongo1:40000")
rs.add("mongo2:40000")
```

## 開啟 mongos

```
systemLog:
  destination: file
  logAppend: true
  path: /data/shard/logs/mongos.log

# sharding 的 chunkSize, autoSplit 組態移除
sharding:
  # 3.4 組態有修改
  configDB: configReplSet/192.168.33.10:40000,192.168.33.11:40000,192.168.33.12:40000 

net:
  port: 60000
  bindIp: 0.0.0.0

processManagement:
  fork: true
  pidFilePath: /var/run/mongos.pid

```

`mongos -f /etc/mongos.conf`

## 設置分片

`mongo --port 60000`

```
use admin
db.runCommand({addshard:"shard0-replset/192.168.33.10:28000,mongo2:28000,mongo3:28000"})
db.runCommand({addshard:"shard1-replset/192.168.33.10:28001,192.168.33.11:28001,192.168.33.12:28001"})
db.runCommand({addshard:"shard2-replset/192.168.33.10:28002,192.168.33.11:28002,192.168.33.12:28002"})
```

設置分片結束後，部署分片副本集叢集就已經告一段落，然而要真正使分片機制得以運作，還需要增加 shard key。



