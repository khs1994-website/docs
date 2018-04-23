---
title: Redis 其他操作
date: 2016-04-15 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

Redis 其他操作介绍。

<!--more-->

# 地理位置信息 GEO

* `geoadd` KEY long lat 'member' long lat 'member2'

* `geopos` KEY 'member' 'member2'  # 返回 KEY 中指定成员的经纬度

* `geodist` KEY 'member' 'member2' [ m | km | mi |ft ] # 计算距离

* `georadius` KEY long lat radius [单位] # 以给定的经纬度为中心， 返回键包含的位置元素当中， 与中心的距离不超过给定最大距离的所有位置元素。

* `georadiusbymember` 中心位置为成员

* `geohash` KEY 'member' 'member2' # 返回一个或多个位置元素的 Geohash 表示。

# 发布订阅

# 事务
