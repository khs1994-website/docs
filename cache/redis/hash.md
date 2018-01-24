---
title: Redis hash 类型
date: 2016-04-05 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

# 赋值

<!--more-->

```bash

hset hash1 key1 12

hget hash1 key1

hgetall hash1                 # 获取某个哈希表中的所有域及其值

hmset hash1 key1 12 key2 13   # 一次设置某个哈希表里的多个域及其值

hmget hash1 key1 key2

hsetnx hash1 key3 13          # 当且仅当域的值不存在时赋值
```

# 删除数据

`hdel hash1 key1 key2`

# 是否存在

`hexists hash1 key1`

# 哈希表域中域的数量

`hlen hash1`

# 获取哈希表中所有域

和 `hgetall` 不同的是，这个指令只返回域，下一个指令只返回域的值，`hgetall` 域及其值都返回。

`hkeys hash1`

# 返回哈希表中所有域的值

`hvals hash1`

# 返回哈希表中域的值的长度

`hstrlen hash1 key`

# 增量

```bash
hincrby hash1 key1 10       # 可以为负数

hincrbyfloat hash1 key1 0.1 # 浮点增量
```
