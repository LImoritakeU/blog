title: streamparse 文檔翻譯-拓樸
author: LImoritakeU
toc: true
tags:
- python
- streamparse
- storm

date: 2017-07-02 14:05:00
---
![](http://storm.apache.org/releases/1.1.0/images/topology.png)

# 拓樸

Storm 的拓樸被敘述為一個由 storm 元件（即噴口與螺栓）組成的「有向無環圖」(DAG)。

## 特定領域語言拓樸

為了簡化開發 Storm 拓樸，streamparse 提供 python 的特定領域語言。它可以讓你以簡明、高可讀性的 python 來開發複雜的拓樸，如同以 java, clojure 開發一樣。

拓樸檔案會放置你的 streamparse 項目路徑下的 `topologies` 資料夾，在這個資料夾底下，可以有任意數量的拓樸檔案。

- `topologies/my_topology.py`
- `topologies/my_other_topology.py`
- `topologies/my_third_topology.py`
- ...

一個有效的拓樸可能僅由噴口與螺栓組成。



### 簡單的 Python 範例

組成拓樸的第一步，是創建噴口(s)與螺栓(s)，所以假設我們有以下的噴口與螺栓：

```python
from collections import Counter
from redis import StrictRedis
from streamparse import Bolt

class WordCountBolt(Bolt):
    outputs = ['word', 'count']

    def initialize(self, conf, ctx):
        self.counter = Counter()
        self.total = 0

    def _increment(self, word, inc_by):
        self.counter[word] += inc_by
        self.total += inc_by

    def process(self, tup):
        word = tup.values[0]
        self._increment(word, 10 if word == "dog" else 1)
        if self.total % 1000 == 0:
            self.logger.info("counted %i words", self.total)
        self.emit([word, self.counter[word]])

```

```python
from itertools import cycle

from streamparse import Spout


class WordSpout(Spout):
    outputs = ['word']

    def initialize(self, stormconf, context):
        self.words = cycle(['dog', 'cat', 'zebra', 'elephant'])

    def next_tuple(self):
        word = next(self.words)
        self.emit([word])
```

這裡有個重點：我們為了這些類增加一個 `outputs` 屬性，用來指定元件產生的 `default` 串流的欄位，如果想要指定多個串流，我們可以指定一組 `Stream` 物件的串列 (list)。



現在，讓我們來連接讀取自噴口的螺栓：

```python
"""
Word count topology (in memory)
"""

from streamparse import Grouping, Topology

from bolts import WordCountBolt
from spouts import WordSpout


class WordCount(Topology):
    word_spout = WordSpout.spec()
    count_bolt = WordCountBolt.spec(inputs={word_spout: Grouping.fields('word')},
                                    par=2)
```

> Note 筆記
>
> 在拓樸導入之前，你的項目`src` 目錄會被添加到 sys.path，所以你應該基於 src 來使用絕對導入。 



如你所見，`streamparse.Bolt.spec()` 和 `streamparse.Spout.spec()` 方法允許我們指定有關拓撲中元件的訊息，以及它們如何相互連接。 它們各自文檔有列出所有可能使用的方式。

### Java 元件

streamparse 的特定領域語言拓樸通過 `JavaBolt`, `JavaSpout` 完全支援基於 JVM 的噴口與螺栓元件。

這裡是一個基於 Java 的  [Storm Kafka Spout](http://storm.apache.org/releases/current/storm-kafka.html) 範例：

```python
"""
Pixel count topology
"""

from streamparse import Grouping, JavaSpout, Topology

from bolts.pixel_count import PixelCounterBolt
from bolts.pixel_deserializer import PixelDeserializerBolt


class PixelCount(Topology):
    pixel_spout = JavaSpout.spec(name="pixel-spout",
                                 full_class_name="pixelcount.spouts.PixelSpout",
                                 args_list=[],
                                 outputs=["pixel"])
    pixel_deserializer = PixelDeserializerBolt.spec(name='pixel-deserializer-bolt',
                                                    inputs=[pixel_spout])
    pixel_counter = PixelCounterBolt.spec(name='pixel-count-bolt',
                                          inputs={pixel_deserializer:
                                                  Grouping.fields('url')},
                                          config={"topology.tick.tuple.freq.secs": 1})
```

使用 Thrift 介面將拓樸傳送給 Storm 的其一限制是 Java 元件的建構式只能傳輸 python 的基本資料型態：布林值、位元組、浮點數、整數與字串。

### 其他語言的元件

除了 JAVA 與 Python，你也可以使用其他的語言撰寫元件，想像你正在使用多語言的函式庫：P

你只需要使用 [`streamparse.ShellBolt.spec()`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.ShellBolt.spec) 與 [`streamparse.ShellSpout.spec()`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.ShellSpout.spec) 方法，它們接受 `command` , `script` 參數指定二進制來驅動與字串分隔的參數。

### 複數串流

在一個元件中指定複數的輸出串流，你需要指定一個由 [`Stream`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Stream) 物件組成的串列，範例如下：

```python
class FancySpout(Spout):
    outputs = [Stream(fields=['good_data'], name='default'),
               Stream(fields=['bad_data'], name='errors')]
```

指定某個串流作為下游螺栓的輸入串流，只需要使用 `[<Stream.name>]` 來指定你想要的串流；沒有指定串流名稱時，預設會使用 `default` 串流。

```python
class ExampleTopology(Topology):
    fancy_spout = FancySpout.spec()
    error_bolt = ErrorBolt.spec(inputs=[fancy_spout['errors']])
    process_bolt = ProcessBolt.spec(inputs=[fancy_spout])
```

### 分組模式

預設 Storm 使用 `SHUFFLE` 分組模式來提供元組（Tuple）路由給給定元件的特定執行器，但使用者也可以藉由適當的 [`Grouping`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Grouping)  屬性，指定其他的分組模式。最常見的分組或許是 [`fields()`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Grouping.fields) 分組模式，依照特定欄位內值進行區分，並將所有具有相同值的元組傳送給同一個執行器，這種模式可見於以下計算字數的拓樸：

```python
"""
Word count topology (in memory)
"""

from streamparse import Grouping, Topology

from bolts import WordCountBolt
from spouts import WordSpout


class WordCount(Topology):
    word_spout = WordSpout.spec()
    count_bolt = WordCountBolt.spec(inputs={word_spout: Grouping.fields('word')},
                                    par=2)
```

### 拓樸等級組態

如果你希望在拓樸內設置一個所有元件皆適用的組態，像是 `topology.environment`，你可以在 [`Topology`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Topology) 類增加一個 `config` 的屬性：這是一個 dict — 名稱與值的鍵值對，範例：

```python
class WordCount(Topology):
    config = {'topology.environment': {'LD_LIBRARY_PATH': '/usr/local/lib/'}}
    ...
```

## 運行拓樸

### Streamparse 協助我們做了哪些事情？

當使用者在本地或是提交拓樸到叢集，streamparse 會做以下處理

1. 將原始碼打包成 JAR 檔。
2. 建立一個出自使用者 Python 拓樸定義的 Thrift 拓樸結構。
3. 通過 Thrift 拓樸結構傳送到使用者 Storm 叢集的 Nimbus。

如果調用的是 `sparse run`，會直接在`src/` 資料夾運行你的編碼。

如果你使用 `sparse submit` 提交到 Storm 叢集，streamparse 使用 `lein` 來編譯 `src` 資料夾成為一個 Jar 檔，用來運行在叢集。Lein 使用項目根目錄的 `project.clj` 檔案，這個檔案是一個標準的 `lein` 項目檔，並且可以根據需求定制。

### 錯誤處理

當檢測到錯誤(error)，螺栓編碼會調用它的 [`fail()`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Bolt.fail) 方法來讓 Storm 調用所屬的噴口 [`fail()`](http://streamparse.readthedocs.io/en/stable/api.html#streamparse.Spout.fail) 方法。已知的錯誤/失敗情況導致使用此方法對噴口進行顯式回調（ explicit callbacks）。

沒有被捕獲的異常(exception) 會導致元件崩潰。在 `sparse run` 本地模式中，整個拓樸會直接停止運行；在運行中的叢集中，Storm 會自動重啟崩潰的元件，同時噴口會接收到一個 `fail()`呼叫。

如果噴口失敗處理的邏輯是阻止(hold back) 元組，並且不重新發送，則拓樸會繼續執行；如果處理邏輯是重新發送元組，則或許該元件會再一次崩潰。拓樸是否容忍失敗取決於你在噴口如何實現失敗處理。

常見的處理方式：

- 將錯誤的元組添加到某種錯誤日誌或佇列中，以便稍後進行手動檢查，否則將繼續處理。
- 如果錯誤可能是暫時性問題，在考慮元組失敗之前嘗試1或2次重試。
- 如果適用於該應用程序，考慮忽略失敗的元組。

## 並行化與工作進程



**一般來說，每個元件使用`par`：並行度參數，並在噴口與螺栓配置中控制每個組件的 Python 進程數量。**

參見: [Understanding the Parallelism of a Storm Topology](https://storm.apache.org/documentation/Understanding-the-parallelism-of-a-Storm-topology.html)



Storm 並行處理：

- 工作進程(worker process)是JVM，即 Java 進程。
- 執行器(executor) 是由工作進程產生的線程(Thread)。
- 任務(task) 執行實際的數據處理。 （可以將任務視為Python callable。)

噴口和螺栓使用`par` 關鍵字參數，Storm 根據 par 數值指派執行器的數量給噴口與螺栓；例如，`par = 2` 是使用兩個執行器。因為 streamparse 作為獨立的 Python 進程實現了噴口和螺栓，所以設置 par=N 會為給定的噴口／螺栓創建 N 個 Python 進程。

許多應用程序只需要設置`par` 參數來調整生成的 Python 進程的數量。對於底層拓樸工作進程，streamparse 組態默認值為 2 個工作進程，這是獨立於 Storm 的 JVM 進程。這允許拓樸在一個工作進程崩潰時繼續運行。

`sparse submit` 和 `sparse run` 都接受 `-p N` 命令行旗標(flag)，用來修改拓撲工作進程數量；為了方便起見，此旗標會同時將Storm的底層消息傳遞可靠性 ([Storm’s underlying messaging reliability](https://storm.apache.org/documentation/Guaranteeing-message-processing.html)) 數量設置為相同的 N 值。如果需要手動調整（你也了解Storm ackers），分別使用 `-a` 和 `-w` 命令行旗標而不是 `-p` 來控制 `acker 螺栓` 和工作進程數量。 `sparse` **不**支援 Storm 的重新平衡功能（rebalancing）；使用 `sparse submit -f -p N` 來終止運行的拓撲，並以 N 個 workers重新部署。



請注意，底層Storm線程實現：LMAX Disruptor是以高性能線程間消息傳遞為目標設計的。調整拓撲效能時，先排除 Python 級別的問題，舉例：

- 噴口和螺栓進程數量不平衡的瓶頸


- 額外的資料序列化/反序列化開銷
- 在程式碼內的緩慢例程/可調用
