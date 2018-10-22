---
title: JavaScript 对象
date: 2013-04-05 13:00:00
tags:
  - JavaScript
categories:
  - JavaScript
---

JavaScript 中的所有事物都是对象：字符串、数值、数组、函数...

<!--more-->

# 对象创建

```js
let obj = Object.create({
  x:1,                       // 对象属性
  firstName: 'x',
  methodName: function () {  // 对象方法
      return this.firstName + " " + this.lastName;
  }
});
```

```js
obj.x;          // 通过 . 访问

obj["y"];       // 通过中括号访问

obj.methodName(); // 调用方法

delete obj.x;   // 删除属性

for (let variable in object) {
  if (object.hasOwnProperty(variable)) {

  }
}

'x' in obj;         // true
'toString' in obj;  // true 会查找原型链上的属性

obj.hasOwnProperty('x');          //true
obj.hasOwnProperty('toString');   //false 不会查找原型链上的属性
```

# 原型链

```js
function foo() {}

foo.prototype.z = 3;

let obj = new foo();

obj.x = 2;

obj.y = 3;

obj.z // 3
```

# 解构赋值

```js
let [x, y, z] = ['hello', 'JavaScript', 'ES6']; // 同 PHP list($a)=[1]

let [x, [y, z]] = ['hello', ['JavaScript', 'ES6']]; // 嵌套

let [, , z] = ['hello', 'JavaScript', 'ES6']; // 忽略前两个元素，只对z赋值第三个元素

var person = {
    name: '小明',
    age: 20,
    gender: 'male',
    passport: 'G-12345678',
    school: 'No.4 middle school'
};

// 把 passport 属性赋值给变量id:
let {name, passport:id} = person;

// 如果 person 对象没有 single 属性，默认赋值为 true:
var {name, single=true} = person;
```

# 对象详解

## 日期对象

```javascript
let myDate=new Date();   // 可以在括号中定义初始值

document.write(myDate);  // 打印当前时间

myDate.getFullYear();    // 输出、设置年份

myDate.setFullYear(2013);

myDate.getDay();            // 返回星期，整数 0 代表星期日
```

## 字符串对象

```javascript
obj.charAt(index);  // 返回指定位置的字符

// 返回指定字符串(substring)在某个字符串(obj)中首次出现的位置

// 从 startPos 开始检索

obj.indexOf(substring, startPos);

obj.split(separator, limit);        // 将字符串(obj)用(separator)分割并返回数组

obj.substring(startPos, stopPos)    // 截取指定位置的字符串

obj.substring(7)                    // 若只有一个值，则返回从该位置直到结束

obj.substring(2,6);

obj.substr(startPos, length);       // 从指定位置提取指定长度的字符串

obj.toUpperCase();                  // 字符串转换成大写
```

## Math

向上取整

```javascript
Math.ceil(0.8); // 返回 1
```

## JSON

```js
JSON.stringify(); // 对象 -> json

JSON.parse(); // json -> 对象
```
