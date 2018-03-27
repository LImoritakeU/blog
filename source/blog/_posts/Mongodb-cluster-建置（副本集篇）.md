title: Mongodb cluster 建置（副本集篇）
author: LImoritakeU
tags:
  - mongodb
  - NoSQL
categories: []
date: 2017-11-24 17:56:00
---
前言：

為什麼會有這一篇呢？

有時候我們只是希望在 mongodb 的資料有隨時同步的能力而已，單台的 mongodb 其實已經符合需求了，這時僅需要為 mongodb 建立副本集即可。當然，副本集不僅僅只提供備份功能，在許多情況，副本集也可以提升許多資料庫效能，在這邊就不討論了。


## 建立目錄

mongo0, 1, 2

```shell
mkdir -p /data/<shard0-replset>/logs /data/shard0-replset/data
```

## 建立 key

mongo0, 1, 2

```shell
echo "my super awesome secret key" > /data/shard0-replset/key
chmod 600 /data/shard0-replset/key
```

**注意權限與擁有者**

儘量將db與所屬資料夾擁有者都設為 mongod，另外如果有同時運行多個 mongod 的需求，可以考慮建立一個一般使用者的 mongod 帳號，否則全部交給 systemd 管理

## 初始化副本集

修改 `/etc/mongod.conf`，副本集不應放在同一台 host 上，儘量讓同一副本集的組態除了IP以外完全一致，方便維護。

mongo0

```yaml
systemLog:
  destination: file
  logAppend: true
  path: /data/shard0-replset/logs/shard.log  # 是一個檔案，不是目錄

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
  replSetName: shard0-replset # 副本集的名字，屬於同個副本集名字要一樣，這裡沒有牽涉到 sharding，只是為了擴充方便
```

mongo1

除了IP，其他項目都跟 mongo0 相同。

```yaml
...

net:
  port: 28000
  bindIp: 192.168.33.11
...
```

mongo2

除了IP，其他項目都跟 mongo0 相同。

```yaml
...

net:
  port: 28000
  bindIp: 192.168.33.12
...
```

接著啟動 mongod，使用 `mongo mongo0:28000` 客戶端連線預計成為PRIMARY節點的 mongodb，並輸入初始化命令`rs.initiate()`：

成功會顯示

```
{
	"info2" : "no configuration specified. Using a default configuration for the set",
	"me" : "mongo0:28000",
	"ok" : 1
}
```

可以藉由 `rs.conf()` 觀看副本集組態，並且可以發現此時客戶端輸入位置變成`replset1:PRIMARY> `。

目前副本集只有一個節點，繼續在當前客戶端增加副本集

```javascript
rs.add("mongo1:28000")
{ "ok" : 1 }
rs.add("mongo2:28000")
{ "ok" : 1 }
```



