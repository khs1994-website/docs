---
title: Redis key 操作详解
date: 2016-04-06 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- DataBase
- Redis
---

设置过期时间、排序等。

<!--more-->

```bash

del name

exists name

# 过期时间

expire name 30       # 单位为秒

pexpire mykey 1500   # 单位为毫秒

expireat name 时间戳

pexpireat key 毫秒时间戳

# 查看剩余生存时间

pttl mykey           # 单位为毫秒

ttl mykey            # 单位为秒

# 去掉过期时间

persist mykey        # 单位为秒

# 查找所有符合给定模式 pattern 的 key

keys *

# 迁移

migrate

# 将当前数据库的 key 移动到给定的数据库 db 当中

move key db_name

# 随机返回一个key

randomkey

rename key newkey

# 当且仅当 newkey 不存在时，将 key 改名为 newkey

renamenx key newkey

# 排序
sort keys

sort keys alpha

# 查看类型

type key
```
