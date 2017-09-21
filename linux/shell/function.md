---
title: Bash 函数详解
date: 2016-06-02 13:00:00
updated:
comments: true
tags:
- Linux
- Bash
categories:
- Linux
---

默认情况下，脚本中定义的任何变量均为 `全局变量`，可以在函数内访问。

<!--more-->

# 创建函数

```bash

# function关键字创建函数

function func1 {
   echo "this is func1"
}

# 接近其它语言形式的函数

func2() {
   echo "this is func2"
}
```

# 引用函数

```bash
func1
func2
```

# 返回值

`return` 只能用来返回整数值（0-255 之间）。

# 变量作用范围

默认情况下，脚本中定义的任何变量均为 `全局变量`，可以在函数内访问。可以使用 `local` 关键字来定义局部变量。

# 参考链接

* http://www.cnblogs.com/dyllove98/p/3189998.html
