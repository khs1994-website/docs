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

```bash
hset[nx] HASH1 KEY value
```

<!--more-->

* `hget` HASH1 key1

* `hgetall` HASH1

* `hmset` hash1 key1 12 key2 1

* `hmget` hash1 key1 key2

* `hdel` hash1 key1 key2

* `hexists` hash1 key1

* `hlen` hash1 # 哈希表域中域的数量

* `hstrlen` hash1 key # 返回哈希表中域的值的长度

* `hkeys` hash1 # 这个指令只返回域

* `hvals` hash1 # 这个指令只返回域的值

* `hincrby` hash1 key1 10       # 可以为负数

* `hincrbyfloat` hash1 key1 0.1 # 浮点增量
