---
title: C Linux 下的编译
date: 2016-02-01 12:00:00
updated:
comments: true
tags:
- C
categories:
- Other
- C
---

本文简要介绍了 C 语言的编译命令。

<!--more-->

# `Hello World!`

```c
#include <stdio.h>

int main()
{  
     printf("Hello World!\n");
     return 0;
}
```

# 基本编译命令

```bash
$ gcc a.c
# 生成 a.out
$ ./a.out
```

## 多个文件分而治之

```c
//声明
# include “max.c”
```

```bash
# 不声明,会发生警告信息
$ gcc max.c hello.c -o main.out
# 声明
$ gcc hello.c
```

## 头文件与函数定义分离

不经常变动的函数 生成`静态库`

```bash
$ gcc -c max.c -o max.o
# hello.c 声明去掉
$ gcc max.o hello.c
# 可以将文件写为 头文件
$ gcc max.o min.o hello.c
```

## Makefile

```
# 注释
hello.out:max.o min.o hello.c
        gcc max.o min.o hello.c -o hello.out
max.o:max.c
        gcc -c max.c
min.o:min.c
        gcc -c min.c
```

# 指针与内存

## gdb 工具

```bash
$ gcc -g main.c -o main.out
$ gdb ./main.out
```
