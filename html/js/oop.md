---
title: JavaScript 面向对象
date: 2018-10-03 13:00:00
updated: null
comments: true
tags:
  - JavaScript
categories:
  - JavaScript
---

ES6 `class`

<!--more-->

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
