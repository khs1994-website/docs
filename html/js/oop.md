---
title: JavaScript 面向对象
date: 2013-04-03T13:00:00.000Z
updated: null
comments: true
tags:
  - JavaScript
categories:
  - JavaScript
---

<!--more-->

# 对象

```js
var obj={x:1,y:2};

obj.x;
```

## 原型链

```js
function foo() {}

foo.prototype.z = 3;

var obj = new foo();

obj.x = 2;

obj.y = 3;

obj.z // 3
```

## 对象创建

```js
var obj = Object.create({x:1});
```

## 属性读写

```js
obj.x;

obj["y"];

for (var variable in object) {
  if (object.hasOwnProperty(variable)) {

  }
}

// 删除属性

delete obj.x;

'x' in obj; // true
'toString' in obj; // true 会查找原型链上的属性

obj.hasOwnProperty('x'); //true
obj.hasOwnProperty('toString'); //false 不会查找原型链上的属性
```

# 面向对象
