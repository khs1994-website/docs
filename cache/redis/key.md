---
title: Redis key 操作详解
date: 2016-04-06 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

<!--more-->

```bash
set key value

del key     # 删除键，后边可以跟多个值，用空格分开

exists key  # key 是否存在，存在返回 1 ，不存在返回 0
```

# 过期时间

```bash
expire key 30        # 单位为秒

ttl key              # 查看剩余生存时间

persist              # 去掉生存时间，不删除 key

pexpire mykey 1500   # 单位为毫秒

pttl mykey           # 查看剩余生存时间，单位毫秒

expireat name 1355292000  # unix 时间戳

pexpireat key             # 毫秒时间戳

```

# 查找所有符合给定模式 pattern 的 key

```bash
keys * # 匹配数据库中所有 key
```

# 迁移

`migrate` 将 key 原子性地从当前实例传送到目标实例的指定数据库上，一旦传送成功， key 保证会出现在目标实例上，而当前实例上的 key 会被删除。

```bash
migrate 127.0.0.1 6380 key 0 1000
```

# 将当前数据库的 key 移动到给定的数据库 db 当中

`move key db_name`

redis 默认使用数据库 `0`

```bash
SELECT 0   # 切换数据库

move key 1 # 移到数据库 1
```

# 随机返回一个key

`randomkey`

# 重命名

`rename key newkey`

## 当且仅当 newkey 不存在时，将 key 改名为 newkey

nx => Not eXists

`renamenx key newkey`

# 排序

https://khs1994.github.io/redis/key/sort.html

## 数值排序

`sort keys`  默认从小到大

`sort keys DESC` DESC 从大到小

## 字符串排序

`sort keys alpha`

# 查看类型

`type key`

返回结果

* none
* string
* list
* set
* zset
* hash
