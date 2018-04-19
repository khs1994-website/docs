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

# 跨域 （同源策略）

* https://zhuanlan.zhihu.com/p/35404847

```bash
Access-Control-Allow-Origin *
Access-Control-Allow-Methods "GET"
Access-Control-Allow-Headers *
Access-Control-Max-Age 3600

# Cookie 跨域

*-Origin 值必须为请求地址
Access-Control-Allow-Credentials "true"
```

NGINX 配置解决跨域

```nginx
add_header Access-Control-Allow-Methods *;
add_header Access-Control-Allow-Max-Age 3600;
add_header Access-Control-Allow-Credentials true;

add_header Access-Control-Allow-Origin $http_origin;
add_header Access-Control-Allow-Headers
$http_access_control_request_headers;
```

## 简单请求与非简单请求

* 简单请求

GET

HEAD

POST

且 请求 header 无自定义头

且 Content-Type 为 `text/plain` `multipart/from-data` `application/x-www-form-urlencoded`

* 非简单请求

PUT

DELETE

JSON 格式的 AJAX

有自定义头

简单请求 先发送，后验证

非简单请求 先发送 OPTION 请求，通过验证再发送请求

# 1. 创建 XMLHttpRequest 对象 （XHR）

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

# 2. 发送请求 open send

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

.getResponseHeader() 查询某个报头的值
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
