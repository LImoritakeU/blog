title: Jupyter Notebook簡報
author: LImoritakeU
tags:
  - Jupyter
  - Slides
categories: []
date: 2018-01-22 11:45:00
---
## 製作網頁簡報

點選jupyter notebook的`View -> Cell Toolbar -> Slideshow`

![](https://i.imgur.com/fzE8yp6.png)

此時，每一個cell都會左上方都會出現選擇簡報元素類型的下拉式選單，如下圖：

![](https://i.imgur.com/Ixpq2i1.png)

藉由選擇簡報元素類型，單一cell的內容被視為一個最基礎的簡報元素，以下是元素類型：

- Slide：單一頁面，頁面間使用左右鍵切換。
- Sub-slide：子頁面，隸屬於單一頁面底下，子頁面間使用上下鍵切換。
- fragment：段落；在單一頁面或子頁面內如果包含多個段落，則會依次出現，使用左、上方向鍵會回到上一個段落，使用右、下方向鍵會接續下一個段落。
- Skip：忽略，即不顯示該cell。
- Notes：被視為筆記，預設隱藏，可以藉由簡報時按`s`鍵出現

### 將Jupyter轉換為web簡報（html）

```
jupyter-nbconvert --to slides <input_file.ipynb> --reveal-prefix '//cdn.bootcss.com/reveal.js/3.6.0' --output <output_file.html>
```

### 檢視網頁簡報

實際上nbconvert會將ipynb轉換成html格式，預設使用reveal.js來驅動網頁簡報，也因此直接使用瀏覽器開啟是不行的（除非有在本地端下載reveal.js），此時瀏覽器只會顯示html與css。

![](https://i.imgur.com/PfkjGhy.png)

如果在nbconvert命令加上`--post serve`旗標，會自動啟動一個web server指向方才製作的網頁簡報，另一方面，也可以使用python內建的http.server啟動，並且開啟瀏覽器觀看：

```python
# python2
python -m SimpleHTTPServer 8000

# python3
python -m http.server 8000
```

![](https://i.imgur.com/3twCYhT.png)

此時，只要點選由jupyter-nbconvert轉檔出來的html即可正確呈現出簡報效果。

![](https://i.imgur.com/d3dfe0o.png)

## 將網頁簡報轉檔成PDF

### Reveal.js內建方法

Reveal.js製作的網頁簡報無法直接轉換成ppt格式，然而可以先藉由chromium的列印功能轉換成pdf，再做後續處理。

- 使用chrome、chromium或衍生瀏覽器
- 在網頁後面加入`?print-pdf`；有些時候瀏覽器會跑版，但是實際列印是正常的。

```
http://127.0.0.1:8000/basic_data_handling_with_python.slides.html?print-pdf#/
```

- 按右鍵列印該頁面成pdf

### 使用decktape(推薦)

decktape是一個將HTML簡報轉換成PDF的框架，支援目前幾乎所有主流的HTML簡報，它建構在[Puppeteer](https://github.com/GoogleChrome/puppeteer)上，實際上，它就是一個Non-GUI的Chrome瀏覽器，因此本質上它跟Reveal內建作法沒有什麼不同，但它讓自動化變成可能。

**使用npm安裝**

```shell
npm install -g decktape
decktape
```

decktape提供命令列介面方便使用，這是一個最簡單的範例：

```
decktape reveal http://127.0.0.1:8000/slides.html#/ output_slide.pdf
```

然而在jupyter生成的簡報中，遇過兩個問題：

1. 螢幕解析度差異
2. jupyter cell輸出

**螢幕解析度差異**

這並不難解決，decktape本身有支援頁面大小調整，只需要加入`-s`的旗標即可。

```
decktape -s 1920x1080 reveal http://127.0.0.1:8000/slides.html#/ output_slide.pdf
```

jupyter cell輸出

以下方截圖為例，jupyter輸出量可能非常大，當然在pdf上看會直接截斷，這是可預期也正常的作法，然而轉檔過程可能會因為這些大量輸出，導致轉檔非常久（個人有52頁簡報轉檔1小時的經驗），當出現非預期異常時，還可能造成整個轉檔作業失敗。

![](https://i.imgur.com/eqddTwj.png)

decktape支援指定特定頁面轉檔，也因此我們可以將一個很多頁的簡報分拆成多次轉檔，提高效率。

```
decktape -s 1920x1080 reveal http://127.0.0.1:8000/slides.html#/ output_slide.pdf --slides 1-10
```

## Trouble shooting

小心Nbextensions的Limit Output外掛，一般來說，它可以阻止jupyter無止盡輸出（在輸出量過大的情況，可能導致整個瀏覽器崩潰），但是在轉檔過程中，發現它可能會導致一些格式出錯，見下圖，原本第17個cell應該是在下一個簡報頁面，結果被視為第16個輸出的內容，並且導致後續頁面全部消失。

![](https://i.imgur.com/UeEbyrn.png)

取消Limit Output外掛，開啟jupyter並重新執行所有cell後，一切正常。

![](https://i.imgur.com/pAXisEH.png)