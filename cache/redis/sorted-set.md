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

集合插入，按照分数范围超找，可以想象为学生成绩表

<!--more-->

* `zadd` zset1 10.1 value

* `zcard` zset1

* `zcount` zset1 min max              # 返回有序集 key 中， score 值在 min 和 max 之间(默认包括 score 值等于 min 或 max )的成员的数量

* `zincrby` set1 key increment member

* `zrange` zset1 0 2 withscores       # 返回有序集 key 中，指定区间内的成员

* `zrank` zset1 val2                  # 返回有序集 key 中成员 member 的排名

* `zrem` zset member 
