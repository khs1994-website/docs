---
title: Redis sorted set 有序集合类型
date: 2016-04-09 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

集合插入，按照分数范围超找

<!--more-->

```bash
zadd zset1 10.1 val1
zadd zset1 11.2 val2
zadd zset1 10.3 val3

zcard zset1
zrange zset1 0 2 withscores

zrank zset1 val2
zadd zset1 12.2 val3
```
