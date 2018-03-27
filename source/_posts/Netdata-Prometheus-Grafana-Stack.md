title: Netdata-Prometheus-Grafana Stack
author: LImoritakeU
tags:
  - Monitoring
  - netdata
  - prometheus
  - grafana
categories: []
date: 2018-01-16 11:21:00
---
# 輕量級即時監控方案研究

監控主要包含四個面向：

1. 指標(metric)收集
2. 指標儲存
3. 指標展示
4. 告警機制

## 前言

首先，Nagios還是很棒，幾乎你想像得到的問題，社區都有一卡車的方案，即使找不到，也可以輕易地寫一個外掛處理。即使介面稍嫌陽春（事實上，用久了會發現Nagios這種單純的方式非常符合Unix思想。），但依舊是目前最主流的監控工具。

那為什麼我們會尋求其他方案呢？

- ~~nagios太醜，我們太懶得自己改~~

**即時性的需求**。nagios預設設計來監控長期穩定運行的服務，從告警的組態就可以看出，它不是設計來作為「即時」監控的工具，即使社區可能有發展出對應的擴充機制(沒有深入研究，如果有對此深入研究的朋友，希望能告訴我)，但反過來說，nagios過去累積的大量生態體系還是環繞在nagios原有設計基礎上。

這讓我們尋求與nagios類似（可擴充能力強大、輕量級），卻又更直接的方案。

# Netdata-Prometheus-Grafana Stack

這張圖源自於netdata wiki，我們的後端(Back-End)選用Prometheus。

![](https://cloud.githubusercontent.com/assets/2662304/20649711/29f182ba-b4ce-11e6-97c8-ab2c0ab59833.png)

Netdata 就像是一個NRPE(Nagios Agent)的加強版，它可以在單機上直接滿足監控四個面向的需求，然而在現實世界更加複雜，多台實體機、虛擬主機、叢集、容器...，讓監控更為複雜，為了因應複雜需求，我們需要能聚合多個監控實體數據，並且將每個監控實體視做單一指標，達成多層次的監控目的，在這邊選用 netdata-prometheus-grafana 作為多層次監控的技術棧。

2018.1.12更新：vimeo在工程blog也討論這個技術棧，見[此處](ttps://medium.com/vimeo-engineering-blog/graphing-systems-metrics-with-netdata-prometheus-and-grafana-29ba9ec6bc98)

### Netdata

netdata 是一款秒級監控告警的開源專案，從2013年開始託管在 GITHUB 上，到今天(2017.11)已經累積了25000以上的 star，同時也是 GitHub's state of the Octoverse 2016 最受矚目專案之一。

截至目前(2018.1)，netdata 專注於即時單機監控，作為一個單機監控系統，它已經符合監控主要要達成的四個面向，可以讓許多時間序列資料庫作為後端聚合數據。

netdata 有以下特點：

- 主要核心由 C 寫成，效能非常好，也支援 IOT 設備
- 開箱即用
- 資料視覺化優秀，web 介面的可互動式儀表板
- 支援告警輸出，並且已經有許多現成輸出組態
- 文件簡明詳細
- restful api
- 自帶 statsd, web server 
- 可自製 node, python, bash 外掛

### Prometheus

Prometheus 作為給雲端原生運算基金會（Cloud Native Computing Foundation，*CNCF*）納入的主力監控工具，是一個專門為監控設計的時間序列資料庫，近來越來越受到矚目，CoreOS稱它為「容器監控的支柱[^ 1]」 在Netdata-Prometheus-Grafana-Stack中，它用來定時收集並提供更長時間儲存netdata指標的功能，除此之外，Prometheus也提供告警功能alertmanager。

雖然Prometheus有提供資料視覺化的介面，但較為陽春，官方建議使用Grafana作為資料視覺化的工具。

### Grafana

Grafana是一個儀表板工具，官方支援目前主流的時間序列資料庫[Graphite](http://docs.grafana.org/features/datasources/graphite/), [InfluxDB](http://docs.grafana.org/features/datasources/influxdb/), [OpenTSDB](http://docs.grafana.org/features/datasources/opentsdb/), [Prometheus](http://docs.grafana.org/features/datasources/prometheus/), [Elasticsearch](http://docs.grafana.org/features/datasources/elasticsearch/), [CloudWatch](http://docs.grafana.org/features/datasources/cloudwatch/)... 以及開源關係型資料庫 MySQL, PostgreSQL作為資料來源。它也是prometheus資料庫目前最主要的資料視覺化工具。

[^1]: https://coreos.com/blog/prometheus-2.0-released