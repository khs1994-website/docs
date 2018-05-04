---
title: Redis set 类型
date: 2016-04-08 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

从集合 (set) 中插入或者删除元素，set 中不能有重复值

```bash
sadd set1 12 13 14
```

* `srem` set1 12 13 # 移除

* `scard` set1 # 集合元素数量

* `sismember` set1 13 # 判断 member 元素是否是集合 key 的成员

* `smembers` set1 # 返回集合 key 中的所有成员

* `sdiff` set1 set2

* `sdiffstore` newset set1 set2 # 将比较结果放入新的集合

* `sinter` set1 set2 # 交集

* `sinterstore` newset set1 set2 # 将交集存入新的集合

* `sunion` set1 set2 # 并集

* `sunionstore` newset set2 set3

* `smove` SRC_SET TARGET_SET "string"

* `spop` set1 # 移除并返回集合中的一个随机元素

* `srandmember` set1 # 返回集合中的一个随机元素
