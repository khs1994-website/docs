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

按照 key 进行增加删除

`hset hash1 key1 12`

<!--more-->

# 设置多条数据

`hmset hash1 key1 12 key2 13`

# 设置不存在的域,如果域存在则不赋值

`hsetnx hash1 key3 13`

`hget hash1 key1`

# 获取多条数据

`hmget key1 key2`

`hdel hash1 key1 key2`

`hexists hash1 key1`

`hgetall hash1`

# 获取哈希表中所有域的值

`hvals hash1`

# 增量

`hincrby hash1 key1 10`

# 浮点增量

`hincrbyfloat hash1 key1 0.1`

`hkeys hash1`

# 哈希表 域的数量

`hlen hash1`
