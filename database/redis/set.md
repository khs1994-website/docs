---
title: Redis set 类型
date: 2016-04-08 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- DataBase
- Redis
---

从集合中插入或者删除元素。

<!--more-->

```bash
sadd set1 12 13 14

# 移除

srem set1 12 13

# 集合元素数量

scard set1

# 判断 member 元素是否是集合 key 的成员

sismember set1 13

# 返回集合 key 中的所有成员

smembers set1

# 删除

sren set1 13

# 比较

sdiff set1 set2

# 将比较结果放入新的集合

sdiffstore newset set1 set2

# 返回一个集合的全部成员，该集合是所有给定集合的交集。

sinter set1 set2

# 将交集存入新的集合

sinterstore newset set1 set2

# 将 member 元素从 source 集合移动到 destination 集合

smove set1 set2 "string"

# 移除并返回集合中的一个随机元素

spop set1

# 返回集合中的一个随机元素

srandmember set1

# 返回一个集合的全部成员，该集合是所有给定集合的并集。

sunion set1 set2

sunionstore newset set2 set3
```
