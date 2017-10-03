---
title: Redis list 类型
date: 2016-04-07 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- DataBase
- Redis
---

序列两端推入、或弹出元素，修剪、查找、移除元素。

<!--more-->

```bash
lpush list1 12
lpush list1 13

rpop list1

# 数据不唯一

lpush list2 12
lpush list2 13
lpush list1 12

llen list2
```
