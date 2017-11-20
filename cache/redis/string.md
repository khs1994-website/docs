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

`set string1 tom`

# 将 key 的值设为 value ，当且仅当 key 不存在

`setnx string2 bob`

`mset`

`get string1`

`mget`

# 自增

`incr string2`

# 增量

`incrby key1 20`

`incrbyfloat key1 0.01`

# 减2

`decrby string2 2`

# 追加

`append string "add"`

# 字符串截取  -1 表示最后一个字符

`getrange key1 0 4`

# 设置新值，返回旧值

`getset key newvalue`

时设置一个或多个 key-value 对，当且仅当所有给定 key 都不存在。

即使只有一个给定 key 已存在， MSETNX 也会拒绝执行所有给定 key 的设置操作。

`msetnx`

# 生存时间

```bash
psetex mykey 1000 "Hello"         # 单位 毫秒

setex  key1 60 "value"            # 单位 秒

strlen mykey
```
