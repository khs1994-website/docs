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

# 特例

```js
var a = (1,2,3); // 取右边的数值 a = 3
```

# 调试

```js
var x = 15 * 5;
debugger;
document.getElementbyId("demo").innerHTML = x;
```

# 变量

```javascript
var a;

a = 1;

a = "Hello";

var b = 6;

var c, d;         // 一次声明多个变量

var c = 1,d = 1;  // 声明同时赋值
```

## 变量提升

```js
a = 1;

console.log(a); // 可以正常输出

console.log(b); // 报错

var a

var b = 1; // 声明的同时赋值，变量不会提升
```

## 变量作用域

函数外部声明，函数内部可以调用，反之不行。

下边是一个特例

如果变量在函数内没有声明（没有使用 `var` 关键字），该变量为全局变量

```js
// 此处可调用 carName 变量

function myFunction() {
    carName = "Volvo";
    // 此处可调用 carName 变量
}
```

# 函数

```js
function fun1(a, b) {
  console.log(a);
  console.log(b);
  return a;        // 函数返回值
}

fun1(1,2);  // 调用函数
```

在函数表达式存储在变量后，变量也可作为一个函数使用：

```js
var x = function (a, b) {return a * b};
var z = x(4, 3);
```

## 函数参数

### `Arguments` 对象

`argument` 对象包含了函数调用的参数数组。

## 自调用函数

```js
(function () {
    var x = "Hello!!";      // 我将调用自己
})();
```

# 数据类型(6 种)

- `number`

- `string`

- `boolean`

- `null`

- `undefined`

- `对象` 包含 `function` `Data` `Array`

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

## 类型转换

```js
String(123);

(123).toString();

Number("3.14");


```

# 数组

```javascript
var myArray = new Array();

var myArray = new Array(1,2,3);

var myArray = [1,2,3];

myArray[0] = 80;  // 数组赋值
```

```javascript
myArray.length;  // 数组长度
myArray.sort()   // 数组排序
```

# 流程控制

```javascript
if (true) {

} else {

}
```

```javascript
switch (expression) {
  case expression: // 这里是恒等 ===

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



# 错误处理

```js
try {
  throw "test"
} catch (e) {
  console.log(e);
} finally {
  console.log('finally');
}
```

# 严格模式 `'use strict'`

提供更强的错误检查。

```js
function functionName() {
  'use strict'
}
```

不允许用 `with`

`delete` 参数、函数名会报错

对象字面量重复属性报错 `{x:1,x:2}`

等等。
