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
  x:1,                   // 对象属性
  fun: function () {     // 对象方法
    return 1
  }
});
```

## 属性

```js
obj.x;          // 通过 . 访问

obj["y"];       // 通过中括号访问

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

## 方法

```js
let obj = {
    firstName: "John",
    methodName: function () {
        return this.firstName + " " + this.lastName;
    }
}

obj.methodName();
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

# ES6

```js
class A
{
    constructor(){
      this.type = 'a'
    }  

    says(say){
      console.log(say)
    }
}

let a = new A()

a.says('hello');

// 继承

class B extends A{
  constructor(){
    super()
    this.type = 'cat'
  }
}
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
