---
title: Redis string 类型
date: 2016-04-10 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

可以是字符串、整数或浮点，统称为元素。对字符串操作，对整数类型加减。

<!--more-->

* `append` KEY value # 将 值追加到原值末尾

* `mset[nx]` KEY1 value1 KEY2 value2   # 一次设置多个键的值

* `mget` KEY1 KEY2         # 一次返回多个键的值

* `getset` KEY NEW_VALUE   # 设置新值，返回旧值

* `incr | decr` KEY                 # 自增(减) 1

* `incrby | decrby` KEY 20          # 自定义增量

* `incrbyfloat` KEY 0.01

* `getrange` KEY start end # 截取指定位置的字符串 -1 表示最后一个字符。

* `setrange` KEY offset value        # 从指定位置重写值

* `psetex` KEY 1000 "Hello"          # 单位 毫秒

* `setex`  KEY 60 "value"            # 单位 秒

* `strlen` KEY                       # 字符串长度
