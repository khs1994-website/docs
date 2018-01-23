---
title: JavaScript 基础
date: 2013-04-01T13:00:00.000Z
updated: null
comments: true
tags:
  - JavaScript
categories:
  - JavaScript
---

JavaScript 基础语法介绍。

<!-- more -->

# 数据类型(6 种)

- `number`

- `string`

- `boolean`

- `null`

- `undefined`

- `对象`

## 隐式转换

```javascript
"37" - 7 // 30

"37" + 7 // 377
```

## 包装对象

```javascript
var a = 'a';

var obj = new String('a');
```

## 类型检测

```javascript
typeof 100 // number

obj instanceof Object // obj 是不是 Object

Object.prototype.toString.apply([]); // [object Array]

// constructor

// duck type
```

# 运算符

```javascript
var a = (1,2,3); // 取右边的数值 a = 3

var obj = {x:1};

delete obj.x;

window.x = 1;

'x' in window; // true
```

# 严格模式

提供更强的错误检查。

```js
function functionName() {
  'use strict'
}
```

不允许用 `with`

`delete` 参数、函数名会报错

对象字面量重复属性报错 `{x:1,x:2}`

# 变量

```javascript
var a;

var c, d;

var c = 1,d = 1;

var b = 6;

a = 1;
a = "a";
```

# 数组

```javascript
var myArray = new Array();

var myArray = new Array(1,2,3);

var myArray = [1,2,3];

myArray[0] = 80;
```

## 数组长度

```javascript
myArray.length;
```

# 输出内容

```javascript
document.write(a);

document.write("Hello");
```

## 输出警告

```javascript
alert('Hello');
```

## `confirm`

```javascript
confirm(a);

var b=confirm(a);

// 若用户点击确认，则返回 true，此时变量 b 的值为 true
```

## 提问

```javascript
prompt(str1,str2);

// str1: 要显示在消息对话框中的文本，不可修改
// str2：文本框中的内容，可以修改

// 若用户点击确定，文本框中的内容将作为函数返回值

// 点击取消，将返回 null
```

# 窗口

## 打开新窗口

```javascript
window.open(URL,窗口名称,参数);
```

## 关闭窗口

```javascript
window.close();

窗口对象.close();
```

# 获取元素

```javascript
obj=document.getElementById('id');

obj.innerHTML="Hello";

obj.style.color="red";

obj.style.fontSize="20";

// 设置或返回 obj 的 class 属性

// 获取
var b = obj.className;

// 设置

obj.className="className";
```

# 流程控制

```javascript
if (true) {

} else {

}
```

```javascript
switch (expression) {
  case expression:

    break;
  default:

}
```

```javascript
for (var i = 0; i < array.length; i++) {
  array[i]
}
```

```javascript
for (var variable in object) {
  if (object.hasOwnProperty(variable)) {

  }
}
```

```javascript
while (true) {

}
```

```javascript
do {

} while (true);
```

`break` 跳出循环。

`continue` 跳过本次循坏。

# 函数

```javascript
function functionName(x, y) {
  return x;
}
```

# 事件

- `onclick` 鼠标单击事件

- `onmouseover` 鼠标经过事件

- `onmouse` 鼠标移开事件

```html
< onclick="fun()" >
```

# 对象

```javascript
mystr.toUpperCase();

// 将字符串变成大写
```

## 日期

```javascript
var myDate=new Date();

// 可以在括号中定义初始值

// 打印当前时间

document.write(myDate);

// 输出年份

myDate.getFullYear();

// 设置年份

myDate.setFullYear(2013);

// 返回星期

obj.getDay();
```

## 字符串

```javascript
// 返回指定位置的字符

obj.charAt(index);

// 返回指定字符串(substring)在某个字符串(obj)中首次出现的位置

// 从 startPos 开始检索

obj.indexOf(substring, startPos);

// 将字符串(obj)用(separator)分割并返回数组

obj.split(separator, limit);

// 截取指定位置的字符串

obj.substring(startPos, stopPos)

obj.substring(7)

// 若只有一个值，则返回从该位置知道结束

obj.substring(2,6);

// 从指定位置提取指定长度的字符串

obj.substr(startPos, length);
```

## Math

向上取整

```javascript
Math.ceil(0.8); // 返回 1
```

## 数组

```javascript
// 数组排序

obj.sort();
```

# 浏览器对象

## 计时器

```javascript

// 增加计时器，返回整数

var int = setInterval(代码,交互时间); // 单位毫秒

// 取消计时器

clearInterval(id_of_setInterval);

// 页面载入之后延迟指定时间后，去执行一次表达式，仅执行一次，和上边一样，返回整数

setTimeout(代码,延迟时间);

// 取消

clearTimeout(id_of_setTimeout);
```

## 历史 `history`

```javascript
window.history.[属性|方法];

// window 可省略

history.length;

// 返回浏览器历史列表中的 URL 数量。

//返回前一个页面

history.back();

// 下边的代码等同于 back

history.go(-1);

// 倒退之后，回到倒退之前的页面

history.forward(); // 相当于 go(1)
```

## `location`

解析网页 URL

```javascript
location.[属性|方法];

location.host; // 返回或设置主机名+端口号
location.href; // 完整 URL
```

## `navigator`

`Navigator` 对象包含有关浏览器的信息，通常用于检测浏览器与操作系统的版本。

```javascript
navigator.appVersion; // 返回浏览器的平台和版本信息

navigator.platform; // 返回浏览器的操作系统平台

navigator.userAgent; // 返回用户代理头的字符串表示(就是包括浏览器版本信息等的字符串)
```

## `screen`

```javascript
window.screen.属性;

screen.availHeight; // 窗口可以使用的屏幕高度，单位像素
```
