title: streamparse 文檔翻譯-快速上手
author: LImoritakeU
toc: true
tags:
  - python
  - storm
  - streamparse
categories:
  - Python on Storm
date: 2017-07-02 13:45:00
---
![streamparse](http://i.imgur.com/913vCRl.png)

# 前言
streamparse 是一個協助使用者幾乎純使用 Python 語言來操作 apache storm 的工具，本翻譯基於 [3.x](http://streamparse.readthedocs.io/en/v3.5.0/) 版本。如果有翻譯不盡詳確的地方，歡迎向筆者提出修改。

**翻譯術語**
| 英文                            | 中文             |
| ----------------------------- | -------------- |
| Topology                      | 拓樸             |
| component                     | 元件             |
| Spout                         | 噴口             |
| bolt                          | 螺栓             |
| Tuple                         | 元組             |
| Worker                        | 工作進程、進程        |
| Executor                      | 執行器            |
| Task                          | 任務             |
| Stream                        | 串流             |
| Grouping                      | 分組模式、分組        |
| configure(v)、configuration(n) | 設置、配置(動)，組態(名) |

術語翻譯一向是英語非母語的軟體工程師難處之一，關於 storm 相關的特定術語，參考 [從零開始學Storm](http://www.books.com.tw/products/CN11161026) 。





# 快速上手



## 需求

要運行本地端和遠端計算叢集，streamparse 依賴構建於 JVM 的 Apache Storm，與這項技術的集成是輕量級的，並且在大多數情況下，您不需要考慮它。

然而，要讓 streamparse 可以運行，你需要以下：

1. **JDK 7+**
2. **lein**
3. Apache Storm 開發環境，你可以從 [Storm project page](http://storm.apache.org/releases/current/Setting-up-development-environment.html) 頁面安裝。streamparse 要求 **Apache Storm version 0.10.0** 以後的版本。

## 安裝

```
# 安裝 lein
wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
sudo mv lein /usr/bin/
sudo chmod a+x /usr/bin/lein
lein version

# 類似：
# Leiningen 2.3.4 on Java 1.7.0_55 Java HotSpot(TM) 64-Bit Server VM
```

測試：

```
storm version

# 類似：
# Running: java -client -Ddaemon.name= -Dstorm.options= -Dstorm.home=/opt/apache-storm-1.0.1 -Dstorm.log.dir=/opt/apache-storm-1.0.1/logs -Djava.library.path=/usr/local/lib:/opt/local/lib:/usr/lib -Dstorm.conf.file= -cp /opt/apache-storm-1.0.1/lib/reflectasm-1.10.1.jar:/opt/apache-storm-1.0.1/lib/kryo-3.0.3.jar:/opt/apache-storm-1.0.1/lib/log4j-over-slf4j-1.6.6.jar:/opt/apache-storm-1.0.1/lib/clojure-1.7.0.jar:/opt/apache-storm-1.0.1/lib/log4j-slf4j-impl-2.1.jar:/opt/apache-storm-1.0.1/lib/servlet-api-2.5.jar:/opt/apache-storm-1.0.1/lib/disruptor-3.3.2.jar:/opt/apache-storm-1.0.1/lib/objenesis-2.1.jar:/opt/apache-storm-1.0.1/lib/storm-core-1.0.1.jar:/opt/apache-storm-1.0.1/lib/slf4j-api-1.7.7.jar:/opt/apache-storm-1.0.1/lib/storm-rename-hack-1.0.1.jar:/opt/apache-storm-1.0.1/lib/log4j-api-2.1.jar:/opt/apache-storm-1.0.1/lib/log4j-core-2.1.jar:/opt/apache-storm-1.0.1/lib/minlog-1.3.0.jar:/opt/apache-storm-1.0.1/lib/asm-5.0.3.jar:/opt/apache-storm-1.0.1/conf org.apache.storm.utils.VersionInfoIf you already know what you’d like to add to streamparse then by all means, feel free to submit a pull request and we’ll review it.


Storm 1.0.1
URL https://git-wip-us.apache.org/repos/asf/storm.git -r b5c16f919ad4099e6fb25f1095c9af8b64ac9f91
Branch (no branch)
Compiled by tgoetz on 2016-04-29T20:44Z
From source with checksum 1aea9df01b9181773125826339b9587e
```

接著再使用 pip 安裝 streamparse ( 建議使用 virtualenv )

```
pip install -U setuptools
sudo yum -y install gcc libffi-devel python-devel openssl-devel
pip install cryptography
pip install streamparse
```



## 第一個 Storm 項目

streamparse 提供一鍵建立 wordcount 範例資料夾的選項。

```shell
sparse quickstart wordcount
```

```shell
Creating your wordcount streamparse project...
    create    wordcount
    create    wordcount/.gitignore
    create    wordcount/config.json
    create    wordcount/fabfile.py
    create    wordcount/project.clj
    create    wordcount/README.md
    create    wordcount/src
    create    wordcount/src/bolts/
    create    wordcount/src/bolts/__init__.py
    create    wordcount/src/bolts/wordcount.py
    create    wordcount/src/spouts/
    create    wordcount/src/spouts/__init__.py
    create    wordcount/src/spouts/words.py
    create    wordcount/topologies
    create    wordcount/topologies/wordcount.py
    create    wordcount/virtualenvs
    create    wordcount/virtualenvs/wordcount.txt
Done.
```

接著只要前往 wordcount 資料夾，並 `sparse run` 啟用本地拓樸即可。

```shell
cd wordcount
sparse run
```

你可以藉由帶入 `-h` 參數來看其他命令。

```
sparse -h
```





## 項目結構

一個 streamparse 項目應該會有下列的路徑布局：

| 檔案 / 資料夾                        | 敘述                                       |
| ------------------------------- | ---------------------------------------- |
| config.json                     | 拓樸的配置訊息                                  |
| fabfile.py                      | （選用）在拓樸任務啟用前與任務結束後可自訂的 fabric 任務         |
| project.clj                     | cojure 的 leiningen 項目檔案，可以拿來增加額外的 JVM 依賴 |
| src/                            | PYTHON 拓樸原始碼                             |
| tasks.py                        | （選用）可自訂的 Invoke 任務                       |
| topologies/                     | 包含使用 Topology DSL 來定義的拓樸                 |
| virtualenvs/<topology_name>.txt | 在<topology_name>.txt 裡面寫入需要pip 安裝的依賴函式庫，提交 topology 時會自動安裝 |



## 定義拓樸

Storm 服務是建立在 Thrift 結構上，可以藉由 Thrift 來讓純 python 代碼定義，詳細可見拓樸章節。

接著來看由 `sparse quickstart` 創建出來的拓樸定義檔。

```python
"""
Word count topology
"""

from streamparse import Grouping, Topology

from bolts.wordcount import WordCountBolt
from spouts.words import WordSpout


class WordCount(Topology):
    word_spout = WordSpout.spec()
    count_bolt = WordCountBolt.spec(inputs={word_spout: Grouping.fields('word')},par=2)
```



在 `count_bolt` bolt, 我們告知 Storm 該串流會由名為 `word` 的欄位 (field) 名稱來進行分組 (grouping)，Storm 為各種需求提供多樣的分組選擇，然而，最常使用的是 **隨機 shuffle **與 **fileds** 分組。

- 隨機分組：

  元組會隨機分配到各個螺栓 (bolt) 任務中，保證各個螺栓的數量幾乎相同，如果沒有指定其他分組，這會是預設值。

- 欄位分組：

  串流根據指定欄位的值進行分配，舉例，如果某一個串流使用 "user-id"欄位分組，相同 user-id 的值會分配給相同的螺栓任務，然而不同的 user-id 可能會分配給不同的螺栓任務。

Spout 與螺栓還有其他的配置選項，你可以藉由拓樸頁面或  [Storm’s Concepts](http://storm.apache.org/documentation/Concepts.html) 來更了解它。

## Spouts 與 Bolts

使用 streamparse 創建新的噴口 (spout) 與螺栓，只需要將 `spout.py`, `bolt.py` 放到 `src/` 路徑底下的資料夾即可。

接著來創建一個 spout 實例：

```python
import itertools

from streamparse.spout import Spout


class SentenceSpout(Spout):
    outputs = ['sentence']

    def initialize(self, stormconf, context):
        self.sentences = [
            "She advised him to take a long holiday, so he immediately quit work and took a trip around the world",
            "I was very glad to get a present from her",
            "He will be here in half an hour",
            "She saw him eating a sandwich",
        ]
        self.sentences = itertools.cycle(self.sentences)

    def next_tuple(self):
        sentence = next(self.sentences)
        self.emit([sentence])

    def ack(self, tup_id):
        pass  # if a tuple is processed properly, do nothing

    def fail(self, tup_id):
        pass  # if a tuple fails to process, do nothing
```

有兩個既定的方法 `initialize()`, `next_tuple()` 。一旦進入主要的運作迴圈內， streamparse 會呼叫噴口的 `initialize()` 方法進行初始化，當初始化完成後，接著會呼叫 `next_tuple()` 方法來發射你在拓樸定義相匹配的元組。



接著來創建一個螺栓實例，用來獲取噴口傳出來的句子，並切割成單字：

```python
import re

from streamparse.bolt import Bolt

class SentenceSplitterBolt(Bolt):
    outputs = ['word']

    def process(self, tup):
        sentence = tup.values[0]  # extract the sentence
        sentence = re.sub(r"[,.;!\?]", "", sentence)  # get rid of punctuation
        words = [[word.strip()] for word in sentence.split(" ") if word.strip()]
        if not words:
            # no words to process in the sentence, fail the tuple
            self.fail(tup)
            return

        for word in words:
            self.emit([word])
        # tuple acknowledgement is handled automatically
```

螺栓實例的實現更為單純，我們只需要置換預設的 `process()` 方法，這個方法會在元組被傳送到這個螺栓時被呼叫，你可以在這個方法內任意地處理傳入的元組，也可以選擇是否再度發送到下一個目的地。

當 `process()` 方法完成，且沒有出現例外(Exception)，streamparse will automatically ensure any emits you have are anchored to the current tuple being processed and acknowledged after `process()` completes.

當出現例外情況，streamparse 會優先讓該元組失敗，而不是直接殺掉 python 進程。

### 失敗的元組

在上面的例子，我們提供當傳入的元組沒有提供任何字串時，讓元祖失敗的能力。這時後會發生什麼事？Storm 會發送一個失敗 (fail)訊息回到原本發送的 spout，並觸發噴口的 fail() 方法。依照你實做的 fail() 方法來決定做什麼。一個噴口可以重新嘗試傳送失敗的元組、傳送錯誤訊息、或關閉拓樸...，詳見錯誤處理章節。

### Bolt 配置選項

你可以藉由 `auto_ack`,`auto_anchor`, `auto_fail` 關閉自動確認、自動錨定或自動讓元組失敗，這三個配置項在 `streamparse.bolt.Bolt` 文件可見。

範例：

```python
from streamparse.bolt import Bolt

class MyBolt(Bolt):

    auto_ack = False
    auto_fail = False

    def process(self, tup):
        # do stuff...
        if error:
          self.fail(tup)  # perform failure manually
        self.ack(tup)  # perform acknowledgement manually
```



### Handling Tick Tuples

Ticks tuples are built into Storm to provide some simple forms of cron-like behaviour without actually having to use cron. You can receive and react to tick tuples as timer events with your python bolts using streamparse too.

The first step is to override `process_tick()` in your custom Bolt class. Once this is overridden, you can set the storm option`topology.tick.tuple.freq.secs=` to cause a tick tuple to be emitted every `` seconds.

You can see the full docs for `process_tick()` in `streamparse.bolt.Bolt`.

**Example**:

```
from streamparse.bolt import Bolt

class MyBolt(Bolt):

    def process_tick(self, freq):
        # An action we want to perform at some regular interval...
        self.flush_old_state()
```

Then, for example, to cause `process_tick()` to be called every 2 seconds on all of your bolts that override it, you can launch your topology under `sparse run` by setting the appropriate -o option and value as in the following example:

```
$ sparse run -o "topology.tick.tuple.freq.secs=2" ...
```



## 遠端佈署

### 設定一個 storm 叢集

見 [Setting up a Storm Cluster](https://storm.apache.org/documentation/Setting-up-a-Storm-cluster.html).



### 提交拓樸

使用下列命令將拓樸提交到實際的 storm 叢集。

```
sparse submit [--environment <env>] [--name <topology>] [-dv]
```

在提交以前，你應該在 `config.json` 檔案至少設置一個以上的環境。現在，先創造範例的`prod` 環境

```JSON
{
    "serializer": "json",
    "topology_specs": "topologies/",
    "virtualenv_specs": "virtualenvs/",
    "envs": {
        "prod": {
            "user": "storm",
            "nimbus": "storm1.my-cluster.com",
            "workers": [
                "storm1.my-cluster.com",
                "storm2.my-cluster.com",
                "storm3.my-cluster.com"
            ],
            "log": {
                "path": "/var/log/storm/streamparse",
                "file": "pystorm_{topology_name}_{component_name}_{task_id}_{pid}.log",
                "max_bytes": 100000,
                "backup_count": 10,
                "level": "info"
            },
            "use_ssh_for_nimbus": true,
            "virtualenv_root": "/data/virtualenvs/"
        }
    }
}
```

我們現在已經定義一個使用者名稱為 `storm` 的 `prod` 環境，在提交這個拓樸以前，streamparse 會自動安裝該拓樸所需要的依賴函式庫，它是使用 ssh 連接到環境配置的 `workers` 變數下的所有節點，並根據 `virtualenvs/<topology_name>.txt` 裡面的內容建立一個虛擬環境。因此，需要先手動進行兩項作業：

1. streamparse 需要能夠使用 ssh 連接到所有的 storm 叢集節點。
2. streamparse 需要擁有所有 storm 叢集節點 `virtualenv_root` 路徑寫入的權限

設定完後，即可進行提交

```
sparse submit
```

由於目前 config.json 只有一個環境，因此不需要明確指名，此時，streamparse 會進行以下步驟來提交：

1. 將 python 原始碼打包成為 jar
2. 在所有 storm worker 創建虛擬環境 (virtualenv) (並行處理)
3. 提交拓樸給 nimbus

## 禁用與配置創建虛擬環境

如果你沒有 ssh 連接到所有 storm 叢集伺服器，但確定這些伺服器上都已經安裝全部你所需要的 python 依賴函式庫，可以在 config.json 檔案內設置 `use_virtualenv: false` 。

如果已經有現成的 python 虛擬環境，也不希望 streaparse 修改或管理它，你可以設置 `install_virtualenv: false`。

如果你想要傳遞命令行參數給虛擬環境，你可以設置`virtualenv_flags`，舉例：

```
"virtualenv_flags": "-p /path/to/python"
```

注意！ 這項設置只有在創建虛擬環境時生效，使用現成的虛擬環境時無效。



### 使用非官方版本的 storm

如果你希望使用 streamparse 到非官方版本的 storm （例如 HDP Storm），你應該將`project.clj` 中的 `:repositories` 設置指向要使用 JAR 的 Maven repository，並將`dependencies` 的版本指派為想要的 Storm 版本。

舉例，要使用 HDP Storm，你要設置 `:repositories` 到：

`:repositories {"HDP Releases" "http://repo.hortonworks.com/content/repositories/releases"}`



### 單機叢集 (docker or VM)

streamparse 預設叢集不在本地端的主機，如果是使用像是 docker, vm，將`use_ssh_for_nimbus`設為 false。



### 在 config.json 設定提交選項

如果你經常在項目中使用相同的 `sparse submit` 參數，你可以設置 `options` 映射鍵到你的環境設定。舉例：

```json
{
    "topology_specs": "topologies/",
    "virtualenv_specs": "virtualenvs/",
    "envs": {
        "vagrant": {
            "user": "vagrant",
            "nimbus": "streamparse-box",
            "workers": [
                "streamparse-box"
            ],
            "virtualenv_root": "/data/virtualenvs",
            "options": {
                "topology.environment": {
                    "LD_LIBRARY_PATH": "/usr/local/lib/"
                }
            }
        }
    }
}
```

你也可以設置 `--worker`, `--acker` 參數到 config.json 通過 `worker_count` 與 `acker_count` 映射鍵到你的環境設定。



### 紀錄

Storm 的 supervisor 需要可以訪問 log.path 權限來紀錄日誌（以上面範例為例，`/var/log/storm/streamparse` ）。如果你有設置 `log.path` 選項， streamparse 會在使用每一個 storm 進程使用這個路徑，並以 `log.file` 指定的規則命名日誌。日誌檔名可以自行定制，預設檔名為：

```
pystorm_{topology_name}_{component_name}_{task_id}_{pid}.log
```

說明：

- topology_name：在 storm 設置的 `topology.name` 變數。
- component_name：在拓樸定義文件(.clj 檔案)內，定義的當前執行元件 (component) 名稱。
- task_id：特定任務 id ，運行在拓樸內的元件中。
- pid：python 進程的 pid。

streamparse 使用 python 的 `logging.handlers.RotatingFileHandler`，預設只會保存 10 個 1 MB 的日誌檔案 （總共 10 MB）但可以使用 `log.max_bytes` 和 `log.backup_count` 變數調整。



預設日誌等級是 `INFO`，但你可以使用 `log.level` 設定調整。一共有 `critical`, `error`, `warning`, `info`, `debug` 選項可以調整。**注意！** 如果你使用`--deubg` 參數在 `sparse run`, `sparse submit` 時，會覆寫 config.json 的設置。



當使用 `sparse run` 本地開發時，日誌檔案會自動導向 `/path/to/your/streamparse/project/logs` 

