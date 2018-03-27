title: （還不要）用CSS處理印刷排版
author: LImoritakeU
tags:
  - CSS
  - 出版
categories: []
date: 2018-01-07 02:32:00
---
這一篇其實有點虎頭蛇尾，主因是研究CSS排版比預期花超過太多時間，考慮一些排版細節，最後還是決定回到主流排版工具的懷抱，所以暫停相關的研究與實現，所以比起文章，更像自己的筆記。

## 目標
在全開源工具下，實現由XHTML+CSS達成出版品排版，以及可自動化的工作流程。

為什麼要XHTML+CSS ? 這其實是關於電子出版品規格標準的大主題，簡單來說，我認為XHTML+CSS組合，會成為統一電子出版製作規格的未來（對，是未來而不是現在）。

- O'Relly 新一代標準HTMLBOOK基於XHTML5
- EPUB3 基於XHTML5+CSS

[出版システムのワンソースマルチ](https://docs.google.com/viewer?url=http%3A%2F%2Fwww.y-adagio.com%2Fpublic%2Fcommittees%2Fvhis%2Fann_confs%2Fmcc2016%2FT1-4.pdf&pdf=true)

## 困難

1. CJK文字排版更為複雜，雖然W3C有中文排版需求標準，但是相關中文資源缺乏，日文部份相對成熟許多
2. CSS印刷排版支援度低，有些甚至沒有瀏覽器支援，目前僅chrome、opera系列瀏覽器支援度「堪用」。
3. 工具缺乏，並且成熟度都還需加強。

綜合以上3點，我們可以總結為：「CSS排版難，用CSS中文排版更難，找到完整工具，特別難。」如果對於熟悉Indesign、Scribus，甚至Word排版的人，相信CSS排版會讓你有回到石器時代，不如歸去的念頭；但如果你還是堅持像我一樣想不開，就繼續看下去吧！

## 工具與資源

- 工具

  - pandoc：如果經常有需要文件轉檔的人，應該都聽過鼎鼎大名的pandoc，如果不考慮CSS，它會是非常好的萬用工具，可惜我們正是踏在考慮CSS的不歸路上。

  - [weasyprint](http://weasyprint.org/) - 由python寫成的渲染引擎，將html與css渲染成pdf，個人感覺在CJK上，比商業的prince支援度還好（個人觀感），不幸的是，它並不像princeXML是一個完整的解決方案，也有很多css屬性不支援，例如生成Table of Content(TOC)的target-counter https://github.com/Kozea/WeasyPrint/issues/23，就不支援，即使如此，目前它跟wkhtmltopdf是最成熟的開源方案。

  - [vivliostyle.js](https://github.com/vivliostyle/vivliostyle.js) -由vivliostyle公司開源的工具，可以在網頁上以電子書的像是即時預覽，還可以依據出版頁面尺寸調整，非常方便的工具，但是小心它還沒有完全支援w3c paged media 所有模組（大部分支援），並且會修改預設的css，因此還是以weasyprint輸出為主比較好，然而即時預覽非常便利。vivliostyle有出商業的vivliosyle formatter，可在非營利出版品免費使用。

  - [wkhtmltopdf](https://github.com/wkhtmltopdf/wkhtmltopdf/releases)：也是另外一個強大、歷史悠久的函式庫，但不支援css @page的功能，使用自己實現的方法，由於不支援css的page，筆者裝完沒多久就放棄，沒有實際使用過，另外安裝流程有點複雜，筆者使用fedora，安裝流程如下：

    ```shell
    sudo dnf install wkhtmltopdf-0.12.4-1.fc27.x86_64
    wget https://downloads.wkhtmltopdf.org/0.12/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
    tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz
    sudo mv wkhtmltox/bin/wkhtmlto* /usr/bin/
    sudo wkhtmltopdf  --disable-smart-shrinking  --lowquality --enable-external-links --enable-internal-links test.html test.pdf
    ```


- princeXML - 商業出版工具，也是目前網路資源最多的，非營利出版品可以免費使用，單論歐美語系出版，應該是最好的選擇，然而CJK語系在使用過程中，還是有些錯誤發生，例如頁眉的中文無法顯示，但是在weasyprint可以正確顯示的情形，筆者有嘗試使用`@font-face`試圖替代預設serif、monospace字型，但還是失敗，錯誤log與截圖如下：

```
prince: page 52: warning: no font for CJK character U+4FE1, fallback to '?'
prince: page 52: warning: no font for CJK character U+4EFB, fallback to '?'
prince: page 52: warning: no font for Halfwidth and Fullwidth Forms character U+FF1F, fallback to '?'
```

![](https://i.imgur.com/Mz3r9pz.png)

- 書籍、網頁資源
  - [W3C ＠PAGE規範](https://www.w3.org/TR/css-gcpm-3/)：必看
  - [CSS-Page-Tutorial](https://www.antennahouse.com/CSSInfo/CSS-Page-Tutorial-en.pdf) - 類似 cookbook 書。
  - [用HTML+CSS进行图书出版](http://gitbook.cn/books/595074f5b4d2717e5559d671/index.html)：少數中文CJK印刷品排版，使用princeXML。
  - [CSSではじめる同人誌制作](https://pentapod.github.io/c92/)：同樣也是CJK印刷品排版的指導手冊，可以在網路上購買（日文），即使不會日文，也可以看漢字與原始碼範例。
- CJK CSS排版相關：CJK CSS WEB排版其實早就是另外一個巨坑，更別提出版品了，簡直崩潰。
  - [W3C中文排版需求](https://www.w3.org/TR/clreq/)
  - [中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines)
  - [利用 CSS 分別設定中文字、英數、注音、假名的字體：使用 CSS3 @font-face](https://blog.yorkxin.org/2012/06/17/assign-fonts-for-specific-characters)
- 其他列舉：由於CSS出版的相關工具真的太少，因此下列列舉沒用過，但是可能有用的工具：
  - [css-polyfills](http://philschatz.com/css-polyfills.js/#id-added-via-x-ensure-id-0)：CSS PAGE有很多功能根本沒有被支援，有時就需要polyfill協助。
  - [刪除額外元素工具](https://github.com/CSS-Tricks/The-Printliminator)
  - [印刷框架Gutenberg](https://github.com/BafS/Gutenberg)
  - [另外一個印刷框架Hartija---CSS-Print-Framework](https://github.com/vladocar/Hartija---CSS-Print-Framework)
  - [董福興 medium](https://medium.com/@bobtung)：董福興是長期關注台灣電子出版品、參與W3C中文排版制定的專家。

## CSS出版品排版規則

- 使用 chrome或opera預覽，並且打開Emulate CSS media的print，或是乾脆直接使用vivliostyle.js預覽
- 使用絕對單位
- 調整由整體至局部

### @page

```
@page {
  size: B5;
  marks: crop cross;
  bleed: 25mm;
}
```

### 標號

#### 標題標號

**vivliostyle.js沒有支援 string-set 與 string(`var`) 的功能，無法預覽**

```css
    h2 {
        string-set: header content(text);
    }
    @page:right{
        @top-right {
            content: counter(page) " | " string(header);
        }
    }
```

#### 頁數標號

```css
	/*左頁頁數標號*/
    @page:right{
        @top-right {
            content: counter(page);
        }
    }
    /*右頁頁數標號*/
    @page:left{
        @top-left {
            content: "Page " counter(page) " of " counter(pages);
        }
    }
```

#### 章節標號

```css
    body {
        counter-reset: ChapterNo;
    }
    h1 {
        counter-increment: ChapterNo;
        counter-reset: SectionNo;
    }
    h2 {
        counter-increment: SectionNo;
        counter-reset: SubsectionNo;
    }
    h3 {
        counter-increment: SubsectionNo;
    }
	h1::before {  content: counter(ChapterNo) '. ';  }
    h2::before {  content: counter(ChapterNo) '-' counter(SectionNo) '. ';  }
    h3::before {  
      content: counter(ChapterNo) '-' counter(SectionNo) '-' counter(SubsectionNo) '. ';  
	}
```

### TOC

```css
#TOC a::after { 
    content: leader('.') target-counter(attr(href url), page, decimal) 
}

```

![](https://i.imgur.com/Xm9XTFg.png)

pandoc轉換成html時，其實本身就可以根據標題自動生成TOC了，然而平面出版的TOC，比起網頁TOC多了頁數與版型對齊的需求。目前，我使用的工具裡面，僅僅Prince可以完美支援，weasyprint目前還不支援其中的關鍵功能：target-counter。

由於我還是希望以weasyprint為主(prince有其他問題)，所以只好用lxml+weasyprint硬幹一個不怎麼漂亮的TOC。簡單來說，weasyprint本身就可以藉由生成pdf文件的bookmark來獲取標題所在頁數，再根據lxml解析、直接修改原本的網頁版TOC。

結果會長這樣：

![](https://i.imgur.com/rEAabsm.png)

可以發現這個硬幹版本還很陽春，雖然頁數對了，排版卻歪七扭八，困難點在於

1. 無法針對版型做調整（寫死在內文）
2. 中英文字大小不一，我還沒有試過等寬字型，可能也沒時間做了

```python
# toc.py

from lxml import etree, html
from weasyprint import HTML, CSS


def fetch_page(input_html, input_css):
    stylesheet = CSS(filename=input_css)
    document = HTML(filename=input_html).render(stylesheets=[stylesheet])
    b_tree = document.make_bookmark_tree()
    kv = {}

    def extract(ele):
        nonlocal kv
        label, page, children = ele[0], ele[1][0], ele[2]
        kv[label] = page

        if children:
            list(map(extract, children))

    for ele in b_tree:
        extract(ele)

    return kv


def generate_toc(page_info, input_html):
    root = html.parse(input_html).getroot()
    elements = [ele for children in root for ele in children]
    nav = list(filter((lambda x: (x.tag == 'nav')), elements))[0]

    def chinese(data):
        count = 0
        for s in data:
            if ord(s) > 127:
                count += 1
        return count

    toc_list = nav.findall(".//a")
    for ele in toc_list:
        number = chinese(ele.text)
        newstr = ele.text.ljust(70-number, '.')

        ele.text = '{label} page {page}'.format(
            label=newstr,
            page=page_info.get(ele.text))

    return etree.ElementTree(root)


if __name__ == '__main__':
    input_html = './pandoc.html'
    input_css = './statics/printing.css'

    page_info = fetch_page(input_html, input_css)
    et = generate_toc(page_info, input_html)

    et.write('back.html', pretty_print=True)

```

最後我改成這樣，較為單純。

![](https://i.imgur.com/0uzPZsd.png)

```python
def generate_toc(page_info, input_html):
    root = html.parse(input_html).getroot()
    elements = [ele for children in root for ele in children]
    nav = list(filter((lambda x: (x.tag == 'nav')), elements))[0]

    new_str = '''
<div class="title" style="display: inline">
<span class="label">{label}</span>
<span class="page">P. {page}</span>
</div>
    '''

    toc_list = nav.findall(".//a")
    for ele in toc_list:
        text = copy.deepcopy(ele.text)
        ele.text = ""
        ele.insert(0, html.fragment_fromstring(
            new_str.format(label=text, page=page_info.get(text))))

    return etree.ElementTree(root)
```

### 分頁

建議一律使用 `page-break-after|before|inside` ，而不要使用`break-after|before|inside`，即使功能近似，但是語意更明確。 

```css
/* 在該標籤以後分頁，簡稱前分頁 */
page-break-after  : auto | always | avoid | left | right

/* 在該標籤以前分頁，簡稱後分頁 */
page-break-before : auto | always | avoid | left | right

/* 在該標籤中間分頁，簡稱內分頁 */
page-break-inside : auto | avoid
```

值得一提的是，當標籤內的內容過多時，斷頁幾乎無可避免，即使有特別設置內分頁也不能完全避免，這時需要`orphans/ windows`，分別處理內容在一頁範圍底端的最少數量行，與內容在一頁範圍頂端的最少數量行。

常見分頁與否規則

- h1使用前分頁
- h2、h3避免後分頁
- 表格、程式碼避免內分頁

```css
h1 {
  page-break-before: right; /*如果當前頁不是右側，在前面插入空白頁*/
  page-break-after: right; /*如果下一頁不是右側，在前面插入空白頁*/
}
h2, h3 {
  page-break-after: avoid
}
table, pre {
  page-break-inside: avoid
}
p {
  orphans: 3;
  widows: 3;
}
```

### 段落

#### 文字換行

雖然中文字不會像英文字發生過長需要斷行的情形，但是在中英文夾雜的文本內，還是要考慮換行問題，常見的作法是強迫換行，以及依單字換行兩種。

```
文字強迫換行 word-break: break-all;
依單字換行 word-wrap:break-word;
```

### 字體字型

匯入思源黑體

```
@import url(https://fonts.googleapis.com/earlyaccess/notosanstc.css);

body {
	font-family: ‘Noto Sans TC’, sans-serif;
	font-weight: 400;
}
```

中文書籍字號與行距

根據董福興2014年在知乎的說法(https://www.zhihu.com/question/19621096/answer/30280453)，中文書籍內文使用10.5pt，行距使用1.7em。

由於書籍的字體變化相對較少，在html全局加入font-size，之後就可以統一使用rem相對單位來調整大小。

```css
html {
  font-size: 10.5pt;
}

/* others */
a_tag {
  font-size: 1.2rem;
}
```

### 中英文字

#### 空格與非空格的兩難

- https://www.zhihu.com/question/19587406
- https://github.com/vinta/pangu.js
- [中英文之間為什麼要有空格？我問。](https://github.com/hotoo/pangu.vim/wiki/中英文之間為什麼要有空格？我問。)
- [python自動加入空白的腳本](https://github.com/hjiang/scripts/blob/master/add-space-between-latin-and-cjk)

手動加空格，並且設置`text-align: justify;` 的慘劇：

![](https://i.imgur.com/l86Qnok.png)

進階技巧：

[利用 CSS 分別設定中文字、英數、注音、假名的字體：使用 CSS3 @font-face](https://blog.yorkxin.org/2012/06/17/assign-fonts-for-specific-characters)