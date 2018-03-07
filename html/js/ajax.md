---
title: AJAX
date: 2013-04-06 13:00:00
updated: null
comments: true
tags:
  - JavaScript
  - AJAX
categories:
  - JavaScript
---

AJAX `Asynchronous JavaScript and XML` 异步的 JavaScript 和 XML。

慕课网：https://www.imooc.com/video/5644

<!--more-->

# 1. 创建 XMLHttpRequest 对象

```html
<button id="search">按钮名字</button>

<p id="return">
  服务器返回的数据会出现在这里
</p>
```

```js
document.getElementById("search").onclick=function(){
  xmlHttp=new XMLHttpRequest();
  // ...
}
```

# 2. 发送请求

```js
xmlHttp.open("method", "url", true); // 第三个参数为 async,默认为 true

// 设置 header

xmlHttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");

xmlHttp.send("strring");
```

# 3. 获取响应

```js
// 字符串形式的响应

document.getElementById("return").innerHTML=xmlHttp.responseText;

// xml 形式的响应

xmlDoc=xmlHttp.responseXML;

// 之后解析 XML
```

## 其他方法

```js
.statusText 以文本形式返回 HTTP 信息

.getAllResponseHeader() 获取所有响应报头

.getResponseHeader() 查询某个字段值
```

## 判断状态之后再操作 DOM

```js
xmlHttp.onreadystatechange=function()
{
    if (xmlHttp.readyState == 4 && xmlHttp.status == 200)
    {
        // 做一些事情

        document.getElementById("return").innerHTML=xmlHttp.responseText;
    }
}
```

* 0: 请求未初始化
* 1: 服务器连接已建立
* 2: 请求已接收
* 3: 请求处理中
* 4: 请求已完成，且响应已就绪

# JSON 解析

```js
JSON.parse("JSON 字符串");
```

# jQuery

```js
$(document).ready(function(){
  $("#search").click(function(){
    $.ajax({
      type: "GEt",
      url: "url",
      dataType:"json",
      data:{
        // post 数据
        name:1
      },
      success:function(data){
        if(data.success){
          $("#return").html(data.msg);
        }else{
          $("#return").html("出现错误");
        }
      },
      error:function(){
        alert("发生错误");
      }
    })
  })
})
```

# 跨域
