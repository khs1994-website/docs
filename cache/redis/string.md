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

# 追加

```bash
set key value

append key 1

get key
```

# 赋值

```bash
setnx key 10 # 当且仅当 key 不存在时，将 key 的值设为 value

# 多键操作

mset    # 一次设置多个键的值
msetnx  # 当且仅当键不存在时才能赋值

mset key1 value1 key2 value2

mget    # 一次返回多个键的值

mget key1 key2

getset key newvalue # 设置新值，返回旧值
```

# 增减

```bash

incr string2          # 自增 1

incrby key1 20         # 自定义增量

incrbyfloat key1 0.01

decr key                # 减 1

decrby string2 2        # 减 2
```

# 字符串截取

截取指定位置的字符串 -1 表示最后一个字符。

`getrange key 0 4`

# 生存时间

```bash
psetex mykey 1000 "Hello"         # 单位 毫秒

setex  key1 60 "value"            # 单位 秒
```

# 字符串长度

`strlen mykey`
