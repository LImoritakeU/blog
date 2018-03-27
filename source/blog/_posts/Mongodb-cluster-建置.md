title: Mongodb cluster 建置（事前準備篇）
author: LImoritakeU
tags:
  - mongodb
  - NoSQL
categories: []
date: 2017-11-24 17:27:00
---
前言：

要純手工架起一個 mongodb 叢集，還是有點費工的...基本叢集就要 15 個 daemon...當然，安裝沒什麼，麻煩通常都會出現在前置網段或組態沒調整好，然後就在安裝過程中各種爆炸，不過，實際環境通常會請系統工程師大哥協助處理，如果懶得看系統權限相關的部份，重點其實放在叢集命名規則部份。



環境：
- vm: centos7 minimal * 3
- mongo3.4

使用 root 作為使用者安裝，不是很安全，實際環境別這麼做。


## YUM Install

使用 yum 或 apt 安裝的好處是，它們會幫你處理掉一些有的沒的問題，例如單例的 systemd、系統使用者甚至部份權限問題，如果使用 tarball 就要自己處理了。

`vi /etc/yum.repos.d/mongodb-org-3.4.repo`

```
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
```
`yum install -y mongodb-org`

在沒有網路的環境，可以事先下載 rpm檔，然後拿來直接用。

```
sudo yumdownloader mongodb-org
> mongodb-org-3.4.10-1.el7.x86_64.rpm
```





使用這種安裝方式，會建立 mongod 的使用者與群組以及`/lib/systemd/system/mongod.service`

## selinux 

把 selinux 預設的 enforcing 修改成 permissive

`vi /etc/selinux/config`

```
SELINUX=permissive
```

`setenforce Permissive`

## 防火牆

偷懶直接把防火牆都關掉，線上環境記得別這麼搞。

```
systemctl stop firewalld
```

## 權限

建立 mongod 使用者並給予必要的權限，如果使用YUM 安裝，可以省略建立使用者的步驟

`useradd -r mongod`

### 調整權限

將所有 mongo 需要的目錄所有權轉移給系統帳號 mongod，這裡把所有mongodb 相關的都放在 /data 資料夾。

`chown mongod -R /data`

## 叢集命名原則

作為可以橫向擴充的NoSQL，在很多情境下需要考慮叢集擴充性，其中最容易被忽略的就是組態命名問題，以 Mongodb 為例：使用分片+副本集共三台主機的最基本叢集，要運行的 mongod + configsvr + mongos daemons 就高達 15 個程序，這還僅只是最基本的配置，不難想像當業務與可用性需求逐漸增加時，資料庫叢集更加複雜，組態命名問題可以分為兩個部份：

1. 主機名稱與端口
2. 資料庫檔案目錄。

### 目錄

然而，不論是網路上或是技術書籍卻少有點出命名重要性的問題，就拿建立副本集為例，經常在建立資料儲存目錄時，看到這樣的命名：

```
mkdir -p /data/db/master /data/db/slaver
```

命名應該揭示副本集本身特性。理論上 mongodb 的所有副本集都有可能成為 master，如果依詢這種方式建立目錄，當 master 轉移時，維護人員可能就需要到某個 "slaver" 目錄下找尋 "master" 的運行日誌。

因此，除非有特殊目的（使用 master-slaver 部署、純備份副本集...），隸屬於同一副本集的目錄命名應該要一致，以下列出幾項命名原則：

1. 慎用數字，如 s1, s2, s3。

   數字命名會賦予強烈意義，也有很高的強制力，以s1, s2, s3 為例，人們會期待下一個就應該是 s4，甚至當只出現 s5 的檔名時，人們還會懷疑到底 s4 到底去哪了。

2. 一致性

3. 不要使用 "server" 命名

   server 命名容易使人困惑，因為它應該是屬於 hostname 的範疇，很多時候其實這種命名指的是mongodb 的分片，那麼就應該取名為  shard0, shard1，不但方便擴充，更重要的，這種命名明確指出即使沒有額外分片，所有 shard 其實就是在一個 shard 的本質。

### IP與端口(host:port)

mongo 部份指令（像是增加 sharding）無法自動偵測 IP <-> hostname 對應，擁有明確的 host 命名規則可以免去很多麻煩，也建議在為 mongodb 新增副本集與分片時，統一使用IP或 hostname。

mongodb 叢集分為3個部份

- 實際存放、處理、備份資料的 shard_servers，獨立命名 host

  - 副本集

    同一個副本集的 mongod，應該做到端口、目錄命名儘可能完全一致，這麼一來只需要修改IP，其餘組態即可使用，也可以保證同樣副本集的 mongod 不會被誤啟動在同一個主機。

  - 分片

    分片定義上就保含不同部份的資料子集，因此端口不重複也就理所當然，每個分片應該有其獨自使用的端口。

- 存放 meta data 的 config_servers，獨立命名 host

- 處理叢集路由的 mongos servers，獨立命名 host

### 建議命名

#### IP與端口

在 `/etc/hosts`設定：

```
# shard_servers
192.168.1.100 mongo0
192.168.1.101 mongo1
192.168.1.102 mongo2

# config_servers
192.168.1.100 mongo-cfg0
192.168.1.101 mongo-cfg1
192.168.1.102 mongo-cfg2

# mongos_servers
192.168.1.100 mongos0
192.168.1.101 mongos1
192.168.1.102 mongos2
```

|          | shard0       | shard1       | shard2       |
| -------- | ------------ | ------------ | ------------ |
| REPLICA0 | mongo0:28000 | mongo0:28001 | mongo0:28002 |
| REPLICA1 | mongo1:28000 | mongo1:28001 | mongo1:28002 |
| REPLICA2 | mongo2:28000 | mongo2:28001 | mongo2:28002 |

---

|          | configsvr        | mongos(沒有副本集概念) |
| -------- | ---------------- | --------------- |
| REPLICA0 | mongo-cfg0:40000 | mongos0:60000   |
| REPLICA1 | mongo-cfg1:40000 | mongos1:60000   |
| REPLICA2 | mongo-cfg2:40000 | mongos2:60000   |

---

#### 目錄

| 組態                                       | 目錄與檔案                                    |
| ---------------------------------------- | ---------------------------------------- |
| shard_server systemLog.path              | /data/mongodb/<replication.replSetName>/logs/shard.log |
| shard_server storage.dbPath              | /data/mongodb/<replication.replSetName>/data |
| Auth Key                                 | /data/mongodb/<replication.replSetName>/key |
| config_server storage.dbPath             | /data/mongodb/shard/configdb             |
| config_server systemLog.path             | /data/mongodb/shard/logs/config.log      |
| mongos_server systemLog.path             | /data/mongodb/shard/logs/mongos.log      |
| shard_server processManagement.pidFilePath | /var/run/mongodb/mongod.pid              |
| config_server processManagement.pidFilePath | /var/run/mongodb/mongod-cfg.pid          |
| mongos_server processManagement.pidFilePath | /var/run/mongodb/mongos.pid              |