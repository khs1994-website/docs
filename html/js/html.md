---
title: JavaScript 与 HTML 相关的内容
date: 2013-04-04T13:00:00.000Z
updated: null
comments: true
tags:
  - JavaScript
categories:
  - JavaScript
---

```html
<script src="main.js"></script>

<script> let a=1; document.write(a);</script>
```

<!--more-->

* 获取元素对象

```js
let obj = document.getElementById('id'); // 还可以 ByClassName / ByName
```

# 输出

* 输出到 HTNL `document.write(1)` 会重写整个 HTML 文档

* 输出到控制台 `console.log("Hello")`

* 输出到 html 元素 `obj.innerHTML("Hello")`

* 弹窗警告 `alert('Hello')`

* 确认对话框 `confirm(1)`

```javascript
confirm(a);

let b = confirm(a); // 若用户点击确认，则返回 true，此时变量 b 的值为 true
```

## `prompt` 提问

文本对话框，可以输入文本

```javascript
prompt(str1,str2);  // 若用户点击确定，文本框中的内容将作为函数返回值，点击取消，将返回 null

// str1: 要显示在消息对话框中的文本，不可修改
// str2：文本框中的内容，可以修改
```

# 设置 CSS

```js
let obj = document.getElementById('id');

obj.innerHTML="Hello";

obj.style.display = 'none' ;   // block 隐藏 显示

obj.style.color="red";         // 设置样式 CSS

obj.style.fontSize="20";
```

# 设置属性

```js
// obj 变量接上部分

let b = obj.className;         // 获取、设置元素的 class

obj.className = "className";

obj.getAttribute('class');     // 获取元素属性

obj.setAttribute('class', 'new_value'); // 设置元素属性

obj.innerHTML('内容');         // 设置文本
```

# 事件

HTML 页面完成加载(`onload`)

HTML input 字段改变时

HTML 按钮被点击

## `onclick` 鼠标单击事件

## `onmouseover` 鼠标经过事件

## `onmouse` 鼠标移开事件

## `onmouseout` 从一个 HTML 元素移开鼠标

## `onchange` HTML 元素改变

## `onkeydown` 按下键盘按键

## `onload` 页面完成加载

```html
<some-HTML-element onclick="fun_name()">

<button onclick="this.innerHTML=Date()">现在的时间是?</button>
```

# 浏览器对象

## `window`

```js
window.open()

window.close()

window.moveTo() // 移动当前窗口

window.resize() // 调整当前窗口的尺寸
```

## `cookie`

```js
document.cookie="key=value; expires=Thu, 01 Jan 1970 00:00:00 GMT"
```

## 计时器

```javascript

// 增加计时器，返回整数

let int = setInterval(代码,交互时间); // 单位毫秒

clearInterval(id_of_setInterval);   // 取消计时器

setTimeout(代码,延迟时间);            // 页面载入之后延迟指定时间后，去执行一次表达式，仅执行一次，和上边一样，返回整数

clearTimeout(id_of_setTimeout);     // 取消
```

## `history` 历史

```javascript
window.history.[属性|方法];   // window 可省略

history.length;             // 返回浏览器历史列表中的 URL 数量。

history.back();             // 返回前一个页面

history.go(-1);             // 下边的代码等同于 back

history.forward();         // 倒退之后，回到倒退之前的页面 相当于 go(1)
```

## `location` 解析网页 URL

```javascript
location.[属性|方法];

location.host;          // 返回或设置主机名+端口号
location.href;          // 完整 URL
```

## `navigator` 有关浏览器的信息

`Navigator` 对象包含有关浏览器的信息，通常用于检测浏览器与操作系统的版本。

```javascript
navigator.appVersion; // 返回浏览器的平台和版本信息

navigator.platform;   // 返回浏览器的操作系统平台

navigator.userAgent;  // 返回用户代理头的字符串表示(就是包括浏览器版本信息等的字符串)
```

## `screen`

```javascript
window.screen.属性;

screen.availHeight;   // 窗口可以使用的屏幕高度，单位像素
```
