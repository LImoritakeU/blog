title: （備份）英中繁簡編程術語對照
tags:
  - 翻譯
categories: []
author: LImoritakeU
date: 2017-11-20 17:47:00
---
最近，發現侯捷的[備份站點](http://jjhou.boolan.com/) 已經失效了，十分可惜，在號稱數據瀚海的年代，或許其實與過往沒有太大差別，我們能保留的，不過是過去的斷編殘簡。

因為工作時常需要翻譯英文文件的關係，需要查詢科技術語相關翻譯，侯捷這篇對照翻譯，目前看來依舊極具價值，暗自慶幸先前有備份起來，否則隨著作者網站消失，可能就再也找不到也說不定。


> 以下是侯捷個人陸續收集整理的有關於我所涉獵的領域的術語對照（英中繁簡）。
> 歡迎所有朋友給我意見（任何意見）。謝謝。
>
> 新書寫作，或發表文章時，我會以此表為參考。
>
> 本表所列，並不表示我在寫譯書籍時一定會採用表內的中文術語。
> 我也可能（並且常常）採用英文術語。
>
>
> 一群性質相近同的「東西」，如果譯名一貫，閱讀的感覺就很好。
> 一貫性的術語，擴充性高，延伸性高，系統性高。
> ● 我喜歡「式」：
> constructor 建構式
> declaration 宣告式
> definition  定義式
> destructor  解構式
> expression  算式（運算式、表達式）
> function    函式
> pattern     範式、樣式、模式
> program     程式
> signature   標記式（簽名式/署名式）
>
> ● 我喜歡「件」：（這是個彈性非常大的可組合字）
> assembly （裝）配件
> component 組件
> construct 構件
> control   控件
> event     事件
> hardware  硬件
> object    物件
> part      零件、部件
> singleton 單件
> software  軟件
> work      工件、機件
>
> ● 我喜歡「器」：
> adapter   配接器
> allocator 配置器
> compiler  編譯器
> container 容器
> interpreter 直譯器/解釋器（大陸用語）
> iterator  迭代器
> linker    連結器
> listener  監聽器
> pointer   指位器
> reference 址參器
> translator  轉譯器/翻譯器（大陸用語）
>
> ● 我喜歡「別」：
> class 類別
> type  型別
>
> ● 我喜歡「化」：
> generalized  泛化
> specialized  特化
> overloaded   多載化（重載）
>
> ● 我喜歡「型」：
> polymorphism  多型
> genericity    泛型
>
> ● 我喜歡「程」：
> process     行程/進程（大陸用語）
> thread      緒程/線程（大陸用語）
> programming 編程

```
●英中繁簡編程術語對照
英文                    繁體譯詞
                      （有些是侯捷個人喜好，普及與否難說）      大陸慣用術語
---
#define                 定義                                    預定義
abstract                抽象的                                  抽象的
abstraction             抽象體、抽象物、抽象性、抽象件          抽象體、抽象物、抽象性
access                  存取、取用                              訪問
access level            存取級別				訪問級別
access function         存取函式                                訪問函數
activate                活化                                    激活
active                  作用中的
adapter                 配接器                                  適配器
address                 位址                                    地址
address space           位址空間，定址空間
address-of operator     取址運算子, &                           取地址操作符
aggregation             聚合
algorithm               演算法                                  算法
allocate                配置                                    分配
allocator               配置器                                  分配器
application             應用程式                                應用、應用程序
application framework   應用程式框架、應用框架                  應用程序框架、應用框架
architecture            架構、系統架構                          體系結構
argument                引數（傳給函式的值）。參見 parameter    參數、實質參數、實參、自變量
array                   陣列                                    數組
arrow operator          arrow（箭頭）運算子, ->                 箭頭操作符
assembly                裝配件
assembly language       組合語言                                匯編語言
assert(ion)                                                     斷言
assign                  指派、指定、設值、賦值                  賦值
assignment              指派、指定                              賦值、分配
assignment operator     指派（賦值）運算子, =                   賦值操作符
associated              相應的、相關的                          相關的、關聯、相應的
associative container   關聯式容器（對比 sequential container） 關聯式容器
atomic                  不可分割的                              原子的
attribute               屬性                                    屬性、特性
audio                   音訊                                    音頻
A.I.                    人工智慧                                人工智能
background              背景                                    背景（用於圖形著色）
                                                                後台（用於process）
backward compatible     回溯相容                                向下兼容                                                                  
bandwidth               頻寬                                    帶寬
base class              基礎類別                                基類
base type               基礎型別
batch                   批次（i.e.整批作業）                    批量處理
benefit                 利益					收益
best viable function    最佳可行函式                            最佳可行函式
binary search           二分搜尋法                              二分查找
binary tree             二元樹                                  二叉樹
binary function         二元函式				雙參函數
binary operator         二元運算子                              二元操作符
binding                 繫結、綁定                              綁定
bit                     位元                                    位
bit field               位元欄 ?                                位域
bitmap                  位元圖 ?                                位圖
bitwise                 以 bit 為單元逐一…                     ?
bitwise copy            以 bit 為單元逐一複製；位元逐一複製     位拷貝
block                   區塊,區段                               塊、區塊、語句塊
boolean                 布林值（真假值，true 或 false）         布爾值
border                  邊框、框線                              邊框
boxing                  封箱
brace(curly brace)      大括弧、大括號                          花括弧、花括號
bracket(square brakcet) 中括弧、中括號                          方括弧、方括號
breakpoint              中斷點                                  斷點
bug                     臭蟲
build                   建造、構築、建置（MS 用語）
build-in                內建                                    內置
bus                     匯流排                                  總線
business                商務、業務                              業務
buttons                 按鈕                                    按鈕
byte                    位元組（由 8 bits 組成）                字節
cache                   快取                                    高速緩存
call                    呼叫、叫用                              調用
callback                回呼                                    回調
call operator           call（函式呼叫）運算子, ()              調用操作符
                      （同 function call operator）
candidate function      候選函式                                候選函數
chain                   串鏈（例 chain of function calls）      鏈
character               字元                                    字符
check box               核取方塊 (i.e. check button)            複選框
checked exception       可控式異常(Java)
check button            方鈕 (i.e. check box)                   複選按鈕
child class             子類別（或稱為derived class, subtype）  子類
class                   類別                                    類
class body              類別本體                                類體 ?
class declaration       類別宣告、類別宣告式                    類聲明
class definition        類別定義、類別定義式                    類定義
class derivation list   類別衍化列                              類繼承列表
class head              類別表頭                                類頭 ?
class hierarchy         類別繼承體系, 類別階層                  類層次體系
class library           類別程式庫、類別庫                      類庫
class template          類別模板、類別範本                      類模板
class template partial specializations
                        類別模板偏特化                          類模板部分特化
class template specializations
                        類別模板特化                            類模板特化
cleanup                 清理、善後                              清理、清除
client                  客端、客戶端、客戶                      客戶
client-server           主從架構                                客戶/服務器
clipboard               剪貼簿                                  剪貼板
clone                   複製                                    克隆
                       (易與 copy 混淆）
                        "克隆" 是個可接受的譯詞，
                        反正有 "拷貝" 為先例）
                        如果做為動詞譯為 "克隆"
                        做為名詞時最好譯為 "克隆件"
                          相映於 copy 之 "複件" 
                        
collection              群集                                    集合 ?
combo box               複合方塊、複合框                        組合框
command line            命令列                                  命令行
                       (系統文字模式下的整行執行命令)
communication           通訊                                    通訊
compatible              相容                                    兼容
compile time            編譯期                                  編譯期、編譯時
compiler                編譯器                                  編譯器
component               組件                                    組件
composition             複合、合成、組合                        組合
computer                電腦、計算機                            計算機、電腦
concept                 概念                                    概念
concrete                具象的                                  實在的
concurrent              並行                                    並發
configuration           組態                                    配置
connection              連接，連線（網絡,資料庫）               連接
constraint              約束（條件）
construct               構件					構件
container               容器                                    容器
                      （存放資料的某種結構如 list, vector...）
containment             內含                                    包容                      
context                 背景關係、週遭環境、上下脈絡、語境      環境、上下文
control                 控制元件、控件                          控件
console                 主控台                                  控制台
const                   常數（constant 的縮寫，C++ 關鍵字）
constant                常數（相對於 variable）                 常量
constructor（ctor）     建構式                                  構造函數
copy (v)                複製、拷貝                              拷貝
copy (n)                複件, 副本
cover                   涵蓋                                    覆蓋
create                  創建、建立、產生、生成                  創建
creation                產生、生成                              創建   
cursor                  游標                                    光標
custom                  訂製、自定                              定制
data                    資料                                    數據
database                資料庫                                  數據庫
database schema                                                 數據庫結構綱目
data member             資料成員、成員變數                      數據成員、成員變量
data structure          資料結構                                數據結構
datagram                資料元                                  數據報文
dead lock               死結                                    死鎖
debug                   除錯                                    調試
debugger                除錯器                                  調試器
declaration             宣告、宣告式                            聲明
deduction               推導（例：template argument deduction） 推導、推斷
default                 預設                                    缺省、默認
defer                   延緩                                    推遲
definition              定義、定義區、定義式                    定義
delegate                委派、委託、委任			委託
delegation              （同上）
demarshal               反編列                                  散集
dependent name          從屬名稱（表示template內的名稱相依於某個template參數）
dereference             提領（取出指標所指物體的內容）          解參考
dereference operator    dereference（提領）運算子 *             解參考操作符
derived class           衍生類別                                派生類
design by contract      契約式設計
design pattern          設計範式、設計樣式                      設計模式
                        ※ 最近我比較喜歡「設計範式」一詞
destroy                 摧毀、銷毀
destructor（dtor）      解構式                                  析構函數
device                  裝置、設備                              設備
dialog                  對話窗、對話盒                          對話框
directive               指令（例：using directive）            (編譯)指示符
directory               目錄                                    目錄
disk                    碟                                      盤
dispatch                分派                                    分派
distributed computing   分佈式計算 (分佈式電算)                 分佈式計算
                        分散式計算 (分散式電算)
document                文件                                    文檔
dot operator            dot（句點）運算子 .                     (圓)點操作符
driver                  驅動程式                                驅動（程序）
dynamic binding         動態繫結                                動態綁定
efficiency              效率                                    效率
efficient               高效                                    高效
ellipse (...)           簡略號
end user                終端用戶
entity                  物體                                    實體、物體
encapsulation           封裝                                    封裝
enclosing class         外圍類別（與巢狀類別 nested class 有關）外圍類
enum (enumeration)      列舉（一種 C++ 資料型別）               枚舉
enumerators             列舉元（enum 型別中的成員）             枚舉成員、枚舉器
equal                   相等                                    相等
equality                相等性                                  相等性
equality operator       equality（等號）運算子, ==              等號操作符
equivalence             等價性、等同性、對等性                  等價性 
equivalent              等價、等同、對等                        等價
error message           錯誤訊息                                錯誤信息
escape code             轉義碼                                  轉義碼
evaluate                評估、求值、核定                        評估
event                   事件                                    事件
event driven            事件驅動的                              事件驅動的
exception               異常情況                                異常
exception declaration   異常宣告（ref. C++ Primer 3/e, 11.3）   異常聲明
exception handling      異常處理、異常處理機制                  異常處理、異常處理機制
exception specification 異常規格（ref. C++ Primer 3/e, 11.4）   異常規範
exit                    退離（指離開函式時的那一個執行點）      退出
explicit                明白的、明顯的、顯式                    顯式
export                  匯出                                    引出、導出
expression              運算式、算式、表達式、表示式            表達式
facility                設施、設備                              設施、設備
feature                 特性
field                   欄位,資料欄（Java）                     字段, 值域（Java）
file                    檔案                                    文件
firmware                韌體                                    固件
flag                    旗標                                    標記
flash memory            快閃記憶體                              閃存
flexibility             彈性                                    靈活性                
flush                   清理、掃清                              刷新
font                    字型、字體                              字體
form                    表單（programming 用語）                窗體
formal parameter        形式參數                                形式參數
forward declaration     前置宣告                                前置聲明
forwarding              轉呼叫,轉發                             轉發
forwarding function     轉呼叫函式,轉發函式                     轉發函數
fractal                 碎形                                    分形
framework               框架                                    框架
full specialization     全特化（ref. partial specialization）   ?
function                函式、函數                              函數
functional language     函數式語言                              函數式語言
function call operator  同 call operator
function object         函式物件（ref. C++ Primer 3/e, 12.3）   函數對象
function overloaded resolution
                        函式多載決議程序                        函數重載解決（方案）
functionality           功能、機能                              功能                        
function template       函式模板、函式範本                      函數模板
functor                 仿函式                                  仿函式、函子
game                    遊戲                                    游戲
generate                生成、產生                              生成
Generative Programming  殖生式編程                              生產式編程
generic                 泛型、一般化的                          一般化的、通用的、泛化
generic algorithm       泛型演算法                              泛型算法、通用算法
Generic Programming     泛型編程                                泛型編程
getter (相對於 setter)  取值函式
global                  全域的（對應於 local）                  全局的
global object           全域物件                                全局對象
global scope resolution operator
                        全域生存空間（範圍決議）運算子 ::       全局範圍解析操作符
group                   群組                                    ?
group box               群組方塊                                分組框
guard clause            衛述句 (Refactoring, p250)              衛語句
GUI                     圖形介面                                圖形界面
hand shaking            握手協商
handle                  識別碼、識別號、號碼牌、權柄            句柄
handler                 處理常式                                處理函數
hard-coded              編死的                                  硬編碼的
hard-copy               硬拷圖                                  屏幕截圖
hard disk               硬碟                                    硬盤
hardware                硬體                                    硬件
hash table              雜湊表                                  哈希表、散列表
header file             表頭檔、標頭檔                          頭文件
heap                    堆積                                    堆
hierarchy               階層體系                                層次結構（體系）
hook                    掛鉤                                    鉤子
hyperlink               超鏈結                                  超鏈接
icon                    圖示、圖標                              圖標
IDE                     整合開發環境                            集成開發環境
identical               完全一致                                一致
identifier              識別字、識別符號                        標識符
if and only if          若且唯若                                當且僅當
Illinois                伊利諾                                  伊利諾斯
image                   影像                                    圖象
immediate base          直接的（緊臨的）上層 base class。       直接上層基類
immediate derived       直接的（緊臨的）下層 derived class。    直接下層派生類
immutability            不變性
immutable               不可變（的）
implement               實作、實現                              實現
implementation          實作品、實作體、實作碼、實件    	實現
implicit                隱喻的、暗自的、隱式                    隱式
import                  匯入                                    導入
increment operator      累加運算子 ++                           增加操作符
in fact                 事實上				 	實際上
infinite loop           無窮迴圈                                無限循環
infinite recursive      無窮遞迴                                無限遞歸
information             資訊                                    信息
infrastructure          公共基礎建設
inheritance             繼承、繼承機制                          繼承、繼承機制
inline                  行內                                    內聯
inline expansion        行內展開                                內聯展開
initialization          初始化（動作）                          初始化
initialization list     初值列                                  初始值列表
initialize              初始化                                  初始化
inner class             內隱類別				內嵌類
instance                實體                                    實例
                      （根據某種表述而實際產生的「東西」）
instantiated            具現化、實體化（常應用於 template）     實例化
instantiation           具現體、具現化實體（常應用於 template） 實例
integer (integral)      整數型                                  整型
integrate               整合                                    集成
interacts               交談、互動                              交互
interface               介面                                    接口
  for GUI               介面                                    界面
Internet             	網際網路                                互聯網/因特網
interpreter             直譯器                                  解釋器
invariants              恆常性,約束條件			        約束條件
invoke                  喚起                                    調用
iterate                 迭代（迴圈一個輪迴一個輪迴地進行）      迭代
iterative               反覆的，迭代的
iterator                迭代器（一種泛型指標）                  迭代器
iteration               迭代（迴圈每次輪迴稱為一個 iteration）  迭代
item                    項目、條款                              項、條款、項目
label                   標籤
laser                   雷射                                    激光
level                   階                                      層(級)?
  例 high level         高階                                    高層
library                 程式庫、函式庫                          庫、函數庫
lifetime                生命期、壽命                            生命期、壽命
link                    聯結、連結                              連接,鏈接
linker                  聯結器、連結器                          連接器
literal constant        字面常數（例 3.14 或 "hi" 這等常數值）  字面常數
list                    串列（linked-list）                     列表、表、鏈表
list box                列表方塊、列表框                        列表框
listener             	傾聽器
load                    載入                                    裝載
loader                  載入器                                  裝載器、載入器
local                   區域的（對應於 global）                 局部的
local object            區域物件                                局部對象
lock                    機鎖
loop                    迴圈                                    循環
lvalue                  左值                                    左值
macro                   巨集                                    宏
magic number            魔術數字                                魔法數
maintain                維護                                    維護
mailing list            電郵名錄, 郵件列表                      郵件列表
manipulator             操縱器（iostream 預先定義的一種東西）   操縱器
marshal                 編列                                    列集
  參考 demarshal
mechanism               機制                                    機制
member                  成員                                    成員
member access operator  成員取用運算子（有 dot 和 arrow 兩種）  成員存取操作符
member function         成員函式                                成員函數
member initialization list
                        成員初值列                              成員初始值列表
memberwise              以 member 為單元…、members 逐一…      以成員為單位
memberwise copy         以 members 為單元逐一複製
memory                  記憶體                                  內存
menu                    表單、選單                              菜單
message                 訊息                                    消息
message based           以訊息為基礎的                          基於消息的
message loop            訊息迴圈                                消息環
method (java)           方法、行為、函式			方法
meta-                   超-					元-
  例 meta-programming   超編程                                  元編程
micro                   微                                      微
middleware              中介層                                  中間件
modeling                模塑
modeling language       塑模語言，建模語言
modem                   數據機                                  調制解調器
module                  模組                                    模塊
modifier                飾詞      				修飾符
most derived class      最末層衍生類別                          最底層的派生類
mouse                   滑鼠                                    鼠標
multi-tasking           多工                                    多任務
mutable                 可變的                                  可變的
mutex                   互斥器
namespace               命名空間                                名字空間、命名空間
native                  原生的                                  本地的、固有的
nested class            巢狀類別                                嵌套類
network                 網路                                    網絡
network card            網路卡                                  網卡
object                  物件                                    對象
object based            以物件為基礎的                          基於對象的
object code             目的碼
object file             目的檔                                  目標文件
object model            物件模型                                對象模型
object oriented         物件導向的                              面向對象的
online                  線上                                    在線
opaque                  不透明的
operand                 運算元                                  操作數
operating system (OS)   作業系統                                操作系統
operation               操作、操作行為                          操作
operator                運算子                                  操作符、運算符
option                  選項，可選方案                          選項
ordinary                常規的                                  常規的
overflow                上限溢位（相對於 underflow）            溢出（underflow:下溢）
overhead                額外負擔、額外開銷                      額外開銷
overload                多載化、多載化、重載                    重載
overloaded function     多載化函式                              重載的函數
overloaded operator     多載化運算子                            被重載的操作符
overloaded set          多載集合                                重載集合
override                改寫、覆寫                              重載、改寫、重新定義
                      （在 derived class 中重新定義虛擬函式
package                 套件                                    包
pair                    對組
palette                 調色盤、組件盤、工具箱
pane                    窗格                                    窗格
                      （有時為嵌板之意，例 Java Content Pane）
parallel                平行                                    並行
parameter               參數（函式參數列上的變數）              參數、形式參數、形參
parameter list          參數列                                  參數列表
parent class            父類別（或稱 base class）               父類
parentheses             小括弧、小括號                          圓括弧、圓括號
parse                   解析                                    解析
part                    零件					部件(?)
partial specialization  偏特化（ref. C++ Primer 3/e, 16.10）    局部特化
                        （ref. full specialization）
pass by address         傳址（函式引數的傳遞方式）（非正式用語）傳地址
pass by reference       傳址（函式引數的一種傳遞方式）          傳地址, 按引用傳遞
pass by value           傳值（函式引數的一種傳遞方式）          按值傳遞
pattern                 範式、樣式                              模式
                        ※ 最近我比較喜歡「範式」一詞
performance             效率、效能                              性能
persistence             永續性                                  持久性
physical                實體的、實際的                          物理的
pixel                   圖素、像素                              像素
placement delete        ref. C++ Primer 3/e, 15.8.2
placement new           ref. C++ Primer 3/e, 15.8.2
platform                平台                                    平台
pointer                 指標                                    指針
                        址位器（和址參器 reference 形成對映，滿好）
poll                    輪詢                                    輪詢
polymorphism            多型                                    多態
pop up                  冒起式、彈出式                          彈出式
port                    埠                                      端口
postfix                 後置式、後序式                          後置式
precedence              優先序（通常用於運算子的優先執行次序）
prefix                  前置式、前序式                          前置式
preprocessor            前處理器                                預處理器
prime                   質數                                    素數
primitive type          基本型別 (不同於 base class,基礎類別)
print                   列印                                    打印
printer                 印表機                                  打印機
priority                優先權 (通常用於執行緒獲得 CPU 時間的優先次序）
procedure               程序                                    過程
procedural              程序性的、程序式的                      過程式的、過程化的
process                 行程                                    進程
profile                 評測                                    評測
profiler                效能（效率）評測器                      效能（性能）評測器
programmer              程式員                                  程序員
programming             編程、程式設計、程式化                  編程
progress bar            進度指示器/進度條                       進度指示器
project                 專案                                    項目、工程
property                ???                                     屬性
protocol                協定                                    協議
pseudo code             假碼、虛擬碼、偽碼                      偽碼
qualified               經過資格修飾（例如加上 scope 運算子）   限定 ?
qualifier               資格修飾詞、飾詞                        限定修飾詞 ?
quality                 品質                                    質量
queue                   佇列                                    隊列
radian                  徑度                                    弧度
radio button            圓鈕                                    單選按鈕
raise                   引發（常用來表示發出一個 exception）    引起、引發
random number           隨機數、亂數                            隨機數
range                   範圍、區間（用於 STL 時）               範圍、區間
rank                    等級、分等（ref. C++Primer 3/e 9,15章） 等級
raw                     生鮮的、未經處理的                      未經處理的
record                  記錄                                    記錄
recordset               記錄集                                  記錄集
recursive               遞迴                                    遞歸
re-direction            重導向                                  重定向
refactoring             重構、重整                              重構
refer                   取用                                    參考
refer to                指向、指涉、指代                        
reference             （C++ 中類似指標的東西，相當於 "化身"）   引用、參考
                        址參器, see pointer
refine                  精化（精鍊、強化）                      精化
register                暫存器                                  寄存器
reflection              反射                                    反射、映像
relational database     關聯式資料庫                            關係數據庫
represent               表述，表現                              表述，表現
resolve                 決議（為算式中的符號名稱尋找            解析
                              對應之宣告式的過程）
resolution              決議程序、決議過程                      解析過程
resolution              解析度                                  分辨率
restriction             侷限
return                  傳回、回返                              返回
return type             回返型別                                返回類型
return value            回返值                                  返回值
robust                  強固、穩健                              健壯
robustness              強固性、穩健性                          健壯性
routine                 常式                                    例程
runtime                 執行期                                  運行期、運行時
   common language runtime (CLR) 譯為「通用語言執行層」
rvalue                  右值                                    右值
save                    儲存                                    存儲
scalar type             純量                                    標量
schedule                排程                                    調度
scheduler               排程器                                  調度程序
scheme                  結構綱目、組織綱目
scroll bar              捲軸                                    滾動條
scope                   生存空間、生存範圍、範疇、作用域        生存空間
scope operator          生存空間（範圍決議）運算子  ::          生存空間操作符
scope resolution operator
                        生存空間決議運算子                      生存空間解析操作符
                      （與scope operator同）
screen                  螢幕                                    屏幕
search                  搜尋                                    查找
semantics               語意                                    語義
seminar                 研討會				        研習會
sequential container    序列式容器                              順序式容器
                      （對應於 associative container）
server                  伺服器、伺服端                          服務器、服務端
serial                                                          串行
serialization           序列化,次第讀寫                         序列化
  (serialize)
setter (相對於 getter)  設值函式  
signal                  信號                              
signature               標記式、簽名式、署名式                  簽名
slider                  滾軸                                    滑塊
slot                    條孔、槽                                槽
smart pointer           靈巧指標、精靈指標                      智能指針
snapshot                螢幕快照（圖）                          屏幕截圖
specialization          特殊化、特殊化定義、特殊化宣告          特化
specification           規格                                    規範
splitter                分裂視窗                                切分窗口
software                軟體                                    軟件
solution                解法,解決方案                           方案
source                  原始碼                                  源碼、源代碼
stack                   堆疊                                    棧
stack unwinding         堆疊輾轉開解（此詞用於 exception 主題） 棧輾轉開解 *
standard library        標準程式庫
standard template library 標準模板程式庫
statement               述句                                    語句、聲明
status bar              狀態列、狀態欄、狀態條                  狀態條
STL                     見 standard template library
stream                  資料流、串流                            流
string                  字串                                    字符串
subroutine              次常式/副程式
subscript operator      下標運算子, []                          下標操作符
subtype                 子型別                                  子類型
support                 支援                                    支持
suspend                 虛懸                                    掛起
symbol                  符號                                    記號
syntax                  語法                                    語法
table                   表格                                    表
tag                     頁籤                                    標記
target                  標的（例 target pointer：標的指標）     目標
task switch             工作切換                                任務切換
template                模板、範本                              模板
template argument deduction
                        模板引數推導                            模板參數推導
template explicit specialization
                        模板顯式特化（版本）                    模板顯式特化 ?
template parameter      模板參數                                模板參數
temporary object        暫時物件                                臨時對象
text                    文字                                    文本
text file               程式本文檔（放置程式原始碼的檔案）      文本文件
thread                  執行緒/緒程                             線程
thread safe             多緒安全                                多線程安全
throw                   丟擲（常指發出一個 exception）          丟擲、引發
token                   語彙單元                                符號、標記
transaction             交易                                    事務
transparent(ly)         透通的(地)
traverse                巡訪（來回走動）                        遍歷
trigger                 觸發                                    觸發
type                    型別                                    類型
UML unified modeling language  統一建模語言
unary function          一元函式				單參函數
unary operator          一元運算子                              一元操作符
unboxing                開箱
underflow               下限溢位（相對於 overflow）             下溢
unchecked exception     不可控異常(Java)
unqualified             未經資格修飾（而直接取用）              ?
unwinding               ref. stack unwinding                    ?
user                    使用者、用戶                            用戶
user interface          使用者介面、用戶介面、人機介面          用戶界面
variable                變數（相對於常數 const）                變量
vector                  向量（一種容器，有點類似 array）        向量、矢量(?)
viable                  可實行的、可行的                        可行的
viable function         可行函式                                可行函數
                      （從 candidate functions 中挑出者）
video                   視訊                                    視頻
view (1)                                                        視圖
  (document/view)                                               文檔/視圖
view (2)                映件  
virtual function        虛擬函式                                虛函數
virtual machine         虛擬機器                                虛擬機
virtual memory          虛擬記憶體                              虛內存, 虛存
volatile                易揮發的、易變的                        ?
vowel                   母音                                    元音字母
warning message         警告訊息                                警告信息
wildcard                萬用字元、萬用符號                      通配符
window                  視窗                                    窗口
window function         視窗函式                                窗口函數
window procedure        視窗函式                                窗口過程
word                    字                                      單詞
word processor          文書處理器                              字處理器
wrapper                 外覆、外包				包裝
WWW                     萬維網


xxx based               以 xxx 為基礎的、植基於 xxx 的          基於 xxx 的
xxx box                 xxx 盒、xxx 方塊、框                    xxx 框
  例如 dialog box         對話盒、對話方塊、對話框                對話框
xxx oriented            xxx 導向                                面向 xxx

                        寬頻                                    寬帶
                        透過,經由,藉由                          通過
                        感冒                                    不感興趣,不欣賞,有意見
                        感興趣                                  感冒
                        很紅                                    很火
                        頗為                                    比較
                        符號                                    符
                        大括弧 { }                              花括弧
                        中括弧 [ ]                              方括弧
                        小括弧 ( )                              圓括弧
                        角括弧 <>                              尖括弧
-self                   本身                                    自身
                        呈現					體現   
cover                   涵蓋                                    覆蓋  
                        合作					協作 
                        這麼做                                  這樣做                         
for example             例如					比如
                        食譜                                    菜譜
replace, instead        取代					替換
                        亦即                                    即
                        逐一                                    逐個
                        話題                                    談資
level                   階					級
low level               低階					低級
indicate                顯示                                    表明
level                   層次,層級                               級別
                        事實上                                  實際上
                        這麼	                                這樣
                        薪資,薪水                               工資 
                        加總                                    加合 
                        一般（中性詞）                          普通（中性詞） 
                          例：他是個一般程式員                    例：他是個普通程序員
                        普通（略帶貶意）                        一般（略帶貶意） 
                          例：他是個很普通的程式員                例：他是個很一般的程序員
                        發生什麼事                              發生什麼
advanced?               進階					高端
                                                                不少書籍把「成本」和「開銷」混為一談（並把cost譯為開銷）
                                                                  我想它們的意義並不相同。
                        需要、必須                              "需" 後接名詞，"須" 後接動詞.
                        作法                                    做法
                        覆審                                    復審

                         
no best, just better    沒有 "最" 好，只有 "比較" 好            沒有 "最" 好，只有 "更" 好


●Microsoft Word 英中繁簡用語對照

英文版用語            繁體版用語         簡體版用語
----------------------------------------------------------------------------------------
以下是各個 "menu item"
File                  檔案               文件
New                   開新檔案           新建
Open                  開啟舊檔           打開
Close                 關閉               關閉
Save                  儲存檔案           保存
Save As               另存新檔           另存為
Save As Web page      另存成Web畫面      另存為Web頁
Search             
Versions              版本               版本
Web Page Preview      Web畫面預覽        Web頁預覽
Page Setup            版面設定           頁面設置
Print Preview         列印預覽           打印預覽
Print                 列印               打印
Send To               傳送到             發送
Properties                               屬性
Exit                  結束               退出


Edit                  編輯               編輯
Undo Typing           復原鍵入           撤消鍵入
Repeat Typing         重複鍵入           重複鍵入
Cut                   剪下               剪切
Copy                  複製               複製
Office Clipboard      
Paste                 貼上               黏貼
Paste Special         選擇性貼上         選擇性黏貼
Paste as???           貼上超連結         黏貼為超級鏈接
Clear                 清除               清除
Select All            全選               全選
Find                  尋找               查找
Replace               取代               替換
Go To                 到                 定位
Update IME Dictionary 重新組字           漢字重組
Reconvert
Links                 連結               鏈接
Object...             物件               對象


View                  檢視               視圖
Normal                標準模式           普通
Web Layout            Web版面配置        Web版式
Print Layout          整頁模式           頁面
Outline               大綱模式           大綱
Task Pane             
ToolBars              工具列             工具欄
Ruler                 尺規               標尺
Show Paragraph Marks  顯示段落標記       顯示段落標記
Gridlines             格線               網格線
Document Map          文件引導模式       文檔結構圖
Header and Footer     頁首/頁尾          頁眉和頁腳
Footnotes             註腳               腳注
Markup                註解               批注
Full Screem           全螢幕             全屏顯示
Zoom                  顯示比例           顯示比例


Insert                插入               插入
Break                 分隔設定           分隔符
Page Numbers          頁碼               頁碼
Date and Time         日期及時間         日期和時間
AutoText              自動圖文集         自動圖文集
Field                 功能變數           域
Symbol                符號               符號         
                      特殊符號           特殊符號
Comment               註解               批注
Number                數字               數字
Reference             
  Footnote            註腳               腳注
  Endnote             章節附註           尾注
  Caption             標號               題注
  Cross reference     交互參照           交互引用
  Index and Table     索引及目錄         索引及目錄
Web Component                                  
Picture               圖片               圖片
Diagram               
Text Box              文字方塊           文本框
File                  檔案               文件
Object                物件               對象
Bookmark              書籤               書籤
Hyperlink             超連結             超級鏈接


Format                格式               格式
Font                  字型               字體
Paragraph             段落               段落
Bullets and Numbering 項目符號及編號     項目符號和編號
Borders and Shading   框線及網底         邊框和底紋
Columns               欄                 分欄
Tabs                  定位點             制表位
Drop Cap              首字放大           首字下沉
Text Direction        直書/橫書          文字方向
Change Case           大小寫轉換         更改大小寫
...                   最適文字大小       調整寬度
Align Layout          亞洲方式配置       中文版式
Background            背景               背景
Theme                 主題               主題
Frames                框架               框架
AutoFormat            自動格式設定       自動套用格式
Styles and Formatting 樣式               樣式
Reveal Formatting     快取圖案/圖片格式
Object                物件               對象


Tool                  工具               工具
Spelling and Grammar  拼字及文法檢查     拼寫和語法
Language              語言               語言
Fix Broken Text
Word Count            字數統計           字數統計
AutoSummarize         自動摘要           自動編寫摘要    
                      自動校正           自動更正
Speech             
Track Changes         追蹤修訂           修訂
Compare and Merge Documents 合併文件     合併文檔
Protect Document      保護文件           保護文檔
Online Collaboration  線上共同作業       聯機協作
                      合併列印           郵件合併
Letters and Mailings  信封及標籤         信封和標籤
                      信件精靈           中文信封嚮導
                                         英文信函嚮導
Tools on the Web
Macro                 巨集               宏
Templates and Add-Ins 範本與增益集       模板和加載項
AutoCorrect Options   
Customize             自訂               自定義
Options               選項               選項


Table                 表格               表格
Draw Table            手繪表格           繪製表格
Insert                插入表格           插入
Delete                刪除儲存格         刪除
Select                選取               選定
Merge Cells           合併儲存格         合併單元格
Split Cells           分割儲存格         拆分單元格
Split Table           分割表格
Table AutoFormat      表格自動設定       表格自動套用格式
AutoFit               最適列高           自動調整
Heading Rows Repeat   跨頁標題重複       標題行重複
                      插入多對角線儲存格 繪製斜線表頭
Convert 文字轉換為表格 轉換              轉換
                       -->文字轉表格, 表格轉文字  -->文字轉換成表格, 表格轉換成文字
Sort                  排序               排序
Formula               公式               公式
Hide Gridlines        隱藏格線           隱藏虛框
Table Properties      表格內容           表格屬性

Window                視窗               窗口
New Window            開新視窗           新建窗口
Arrange All           並排顯示           全部重排
Split                 移除分割           拆分

Help                  說明               幫助
Microsoft Word Help   Microsoft Word說明 Microsoft Word幫助
Show the Office Assistant 顯示/隱藏Office小幫手   顯示/隱藏Office助手
What's this           這是什麼           這是什麼
Office on the Web     Office on the Web  網上Office
Activate Product
WordPerfect Help
Detect and Repair     偵測及修護功能     檢測與修復
About Microsoft Word  關於Microsoft Word 關於Microsoft Word 



----------------------------------------------------------------------------------------
```