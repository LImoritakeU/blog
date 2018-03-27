title: Django Tutorial筆記
author: LImoritakeU
tags:
  - django
  - python
  - web
  - note
categories:
  - python web
date: 2018-03-26 14:22:00
---
# Django Tutorial筆記

對於毫無網頁開發概念的初學者：

在django官方t的part4，有這麼一句話：

> You should know basic math before you start using a calculator.

從flask轉來使用django的我，建議完全沒有web開發經驗的人，先以flask上手，django很不錯，但是他從一開始的"startproject"就預設了許多「最佳實踐」，個人認為在完全沒有網頁開發概念時就學習最佳實踐，就好像叫一個完全不會水中換氣的旱鴨子學習最少時間水中換氣一樣，沒有太大的意義，反而有害學習，反之，如果對web開發的ORM、routing、render template、auth...等有一些概念，甚至有動手拼裝一個CRUD、LOGIN網站經驗的人，學習django框架可以幫助他學習在這款業界久經驗證的的企業級框架，如何快速組織與開發專案。

我非常推薦先實作完《flask web開發》，接著摸摸Django框架。

# 開啓新專案

安裝django後，即可以使用`django-admin`命令，開啟全新專案。

```shell
$ django-admin startproject mysite
$ python manage.py runserver
$ python manage.py startapp polls
```

- django的專案是由許多個Application，與專案控制模組組成，在這裏是`/project/mysite`。
- application類似flask的blueprint，在這裏新增一個app，位於`/project/polls`
- django的app使用分區式(divisional)架構



# 路由

個別Application的路由存在app路徑底下的`urls.py`

`urls.py`主要由urlpatterns list組成，url接收兩個必要參數與兩個可選參數。

```python
from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^$', views.index, name='index')
]
```

必要參數：

1. 路由路徑的模式（以正規表示法進行匹配），範例上的`r''`
2. 接收函數，範例上的`views.index`

可選參數：

1. kwargs
2. name，將url的pattern命名爲name，可用於模板系統。

### 動態路由與正規表達法

django的動態路由深度結合python的正規表達法模組(re module)

一個接收動態路由的視圖函數與路由規則搭配範例：

```python
# polls/views.py
def results(request, question_id):
    response = "You're looking at the results of question %s."
    return HttpResponse(response % question_id)

# polls/urls.py
urlpatterns = [
	url(r'^(?P<question_id>[0-9]+)/results/$', views.results, name='results'),
	...
]
```

對於`r'^(?P<question_id>[0-9]+)...'`這段，就是把符合`[0-9]+`的字段賦值給`question_id`變數。

# 視圖函數

## 單純的視圖函數

一個最基本的視圖函數會攜帶request參數，一般來說，會回傳HttpResponse物件。

```python
def hello(request):
	return HttpResponse("Hello, World!")
```

## 攜帶額外參數的視圖函數

攜帶額外參數的視圖函數，額外參數通常是由動態路由決定的，見動態路由。

## 通用視圖（generic views）

一個常見的情境是：藉由URL傳遞的參數，從資料庫取得部分資料，並且使用模板渲染回傳HTML頁面，由於這種情境太常見了，django幫我們把這些稱為常見的情境命名爲通用視圖系統，目的是達成更好的視圖複用，我們大多只需要指定需要傳遞的模板名稱，以及Model即可。

額外google了一下，django的通用視圖是一種建構視圖函數的強大方法，用的好與壞主要基於兩點：

- 物件導向程式設計，尤其是多重繼承與Mixin
- Django框架的熟悉程度

看起來，對於通用視圖的使用也是評斷工程師是否對django有足夠理解的指標之一。

# 資料庫

所有的全局組態都位於控制模組的`settings.py`

資料庫相關組態則是於`DATABASES`字典指定，預設使用sqlite

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
        'USER': None,
        'PASSWORD': None,
        'HOST': None,
    }
}
```

衆所皆知，Django與它的ORM深度結合。

Model採用宣告式的語法，在這裏設置的`question_text`、`pub_date`不僅僅是屬性名稱，也是在table建立時，命名的欄位名稱。

`polls/models.py`

```python
from django.db import models


class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField('date published')


class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
```

方才雖然設定好polls app的url，也可以拿來訪問，但是如果要做到動態網頁，還是需要資料庫的配合，為此，需要把這個app加載到控制模組`mysite/settings.py`的`INSTALLED_APPS`。

```python
INSTALLED_APPS = [
    'polls.apps.PollsConfig',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
]
```

## 資料遷移

內建的migration在開發階段能夠幫助我們，在修改model後避免一直要刪除並重啟database。

步驟1

```shell
$ python manage.py makemigrations polls
---
Migrations for 'polls':
  polls/migrations/0001_initial.py
    - Create model Choice
    - Create model Question
    - Add field question to choice
```

其實說白了，這就是django幫助我們手動重建database table的工具而已，如果想要確認django實際上作了什麼命令，可以使用`sqlmigrate`查看，這行命令不會真的運行sql，它主要是拿來debug用。

````sql
$ python manage.py sqlmigrate polls 0001
---

BEGIN;
--
-- Create model Choice
--
CREATE TABLE "polls_choice" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "choice_text" varchar(200) NOT NULL, "votes" integer NOT NULL);
--
-- Create model Question
--
CREATE TABLE "polls_question" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "question_text" varchar(200) NOT NULL, "pub_date" datetime NOT NULL);
...
````

步驟2

```shell
$ python manage.py migrate
Operations to perform:
  Apply all migrations: admin, auth, contenttypes, polls, sessions
Running migrations:
  Rendering model states... DONE
  Applying polls.0001_initial... OK
```

其實如果是比較嚴謹的專案，這個功能也未必會用到，因為Model的組建通常會先確定，才會開始編碼。

## 使用CLI API

```SHELL
$ python manage.py shell
```

Django提供runtime的python shell，可以拿來偵錯或測試使用，最常拿來用的應該就是測ORM吧，另一種啟動方式是在python shell輸入：

```python
import django
django.setup()
```

也可以達成相同效果。

然而，原生的python shell實在不怎麼親民，安裝一個外掛來用ipython shell。

```
$ pip install django-extensions ipython
```

在settings.py加載：

```python
# 個人比較喜歡這樣

INSTALLED_APPS = [
    # apps
    'polls.apps.PollsConfig',

    # builtins
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',

    # extensions
    'django_extensions'
]

```

接著在終端機輸入：

```shell
$ ./manage.py shell_plus --ipython

---
# Shell Plus Model Imports
from django.contrib.admin.models import LogEntry
...

Python 3.6.4 (default, Feb  8 2018, 14:42:51) 
Type 'copyright', 'credits' or 'license' for more information
IPython 6.2.1 -- An enhanced Interactive Python. Type '?' for help.

In [1]: 
```

至於Model的增刪查改就要去看cheat sheet了。

其實...PyCharm可以搞定這些事...

# Django Admin

Django Admin是django很有名的特色，打包後臺系統常見的許多功能，對於測試或很小的系統來說，幾乎可以隨開即用。

套一句公司內的架構師所說：「對於那些幾乎純CRUD的程式，Django Admin也只能幫你完成百分之八十，但是你很快就會發現，剩下的百分之二十所花的時間，還不如手動刻一個。」

簡單來說，如果只是系統管理員用來快速修改東西，很OK，如果是要給一般使用者使用，那麼很不ok；最近在用Django Admin做一個小專案，深有體會 :-(

## 新增管理員帳密

```shell
$ python manage.py createsuperuser
```

預設的admin位置在`/admin/`

## 爲poll model新增基本CRUD功能 

django有內建爲model建立基本CRUD介面的功能，只需要把該model註冊到admin頁面即可。

```python
# polls/admin.py

from django.contrib import admin

# Register your models here.
from .models import Question

admin.site.register(Question)
```

## 自定義Admin

放在別的筆記裏。

# 模板系統

django的預設模板位置爲`<app_name>/templates/`底下，與flask相同，django會搜尋全局可用的模板，因此常見的方式是放在`<app_name>/templates/<app_name>/`底下，對於複雜的應用，較可以避免模板名稱衝突。

django的模板加載函數有兩種：

- `from django.template import loader`

```python
from django.http import HttpResponse
from django.template import loader
from .models import Question


def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    template = loader.get_template('polls/index.html')
    context = {
        'latest_question_list': latest_question_list,
    }
    return HttpResponse(template.render(context, request))
```

使用這種方式有點囉唆，因此主要都是使用第二種。

- `from django.shortcuts import render`

```python
from django.shortcuts import render
from .models import Question

def index(request):
    latest_question_list = Question.objects.order_by('-pub_date')[:5]
    context = {'latest_question_list': latest_question_list}
    return render(request, 'polls/index.html', context)
```

第二種只需要引入render，djando會回傳一個HttpResponse物件，不需要手動引入loader與HttpResponse了。render函數首個引數一定要傳入request。

## 404Error

django處理404error也有兩種方法：

- `from django.http import Http404`

```python
from django.http import Http404

#...
def detail(request, question_id):
    try:
        question = Question.objects.get(pk=question_id)
    except Question.DoesNotExist:
        raise Http404("Question does not exist")
    return render(request, 'polls/detail.html', {'question': question})
```

- `from django.shortcuts import get_object_or_404`

```python
from django.shortcuts import get_object_or_404, render

# ...
def detail(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    return render(request, 'polls/detail.html', {'question': question})
```

其實都只是爲了方便～

## 避免路由硬編碼

在路由內，url可以接受name參數，這是用來避免在撰寫模板時，需要指向特定路由時，需要硬編碼的窘境，舉例

```python
# polls/urls.py
...
urlpatterns = [
    url(r'^(?P<question_id>[0-9]+)/$', views.detail, name='detail'),
    ...
]
```

將這個url規則命名爲'detail'，就可以直接在模板裡使用。

```django
# templates/polls/index.html
# 原本必須寫這樣
<li><a href="/polls/{{ question.id }}/">{{ question.question_text }}</a></li>

# 可以改寫成這樣，較好複用，你只需要改urls.py裡面的pattern即可。
<li><a href="{% url 'detail' question.id %}">{{ question.question_text }}</a></li>
```

然而，這樣還有一個小缺點：這樣的改動在只有一個app下運作良好，但是如果是多個app呢？如果現在有兩個app的url都被命名爲address呢？

在poll的urls.py加上`app_name`變數，並賦值給`polls`

```python
# polls/urls.py

app_name = 'polls'
urlpatterns = [...]
```

接著，我們來修改`templates/polls/index.html`的路由：

```django
<li><a href="{% url 'polls:detail' question.id %}">{{ question.question_text }}</a></li>
```

我們現在可以指定app名稱了，模板指向的url也更加明確。

# 表單

## Post

request.POST是一個類似dictionary的物件，可以藉由Post傳送的name爲鍵，取得值。

```PYTHON
from django.http import HttpResponseRedirect, HttpResponse
from django.urls import reverse

# ...

def vote(request, question_id):
    question = get_object_or_404(Question, pk=question_id)
    try:
        selected_choice = question.choice_set.get(pk=request.POST['choice'])
    except (KeyError, Choice.DoesNotExist):
        return render(request, 'polls/detail.html', {
            'question': question,
            'error_message': "You didn't select a choice.",
        })
    else:
        selected_choice.votes += 1
        selected_choice.save()
        return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))
```

## 重定向

提交表單後應該重定向回傳，避免使用者重新整理導致重複POST送出表單

```python
	return HttpResponseRedirect(reverse('polls:results', args=(question.id,)))
```

這裏的reverse()函數用途一樣也是避免路由硬編碼，跟flask裡面的url_for是一樣的東西。



# 測試

測試項目：

- model
- view

django的測試域預設單位爲app，每個app建立起來時，都有一個tests.py，django的testcase基於標準函式庫的unittest函式庫。

```python
from django.test import TestCase
...
```

要跑測試時，在終端上輸入：

```
$ python manage.py test <app_name>
```

## 視圖測試

django自帶測試客戶端，如果是繼承django TestCase類，只需要`self.client`即可，如果要在shell介面使用：

```python
>>> from django.test.utils import setup_test_environment
>>> setup_test_environment()
>>> from django.test import Client
>>> # create an instance of the client for our use
>>> client = Client()
response = client.get('/')
```



# 靜態檔案

這個blog寫的不錯http://blog.csdn.net/sinat_21302587/article/details/74059078

django預設靜態檔案存放的目錄爲static，在開發階段，官方建議分別放在各自的app目錄下，組織方法與模板一模一樣，一個css檔案位置範例：`<app_name>/static/<app_name>/style.css`。

django模板要引入靜態檔案時，需要在模板裡面寫入：

```django
{% load static %}

<link rel="stylesheet" type="text/css" href="{% static 'polls/style.css' %}" />
```

有時候我們的靜態檔案（css、javascript腳本）可能需要引用其他的靜態檔案（影像、額外css、javascipt腳本），以`<app_name>/static/<app_name>/style.css`為例，如果這個css要引入某個位於`polls/static/polls/images/background.gif`的圖片，只需這樣寫即可：

```css
body {
    background: white url("images/background.gif") no-repeat right bottom;
}
```