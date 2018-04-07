---
title: Python3 面向对象
date: 2015-01-03 13:00:00
updated:
comments: true
tags:
- Python
categories:
- Python
---

本文介绍了 Python3 面向对象编程

<!--more-->

```python
class A(object): # () 括号里表示 类 A 继承于 object, 可以多继承 (B, C, D)
    i = 1   # 属性
    __a = 2 # 私有属性
    def __init__(self,age): # 构造函数
        self.name = 'tom'
        self.age = age


    def f(self, v): # 方法，第一个参数必须为 self
        print(v)


    def __f2(self):
        print('私有方法')


    def __del__(self):
        print('析构函数')


a = A(1)

print(a.name)
print(a.age)
a.f(1)
```
