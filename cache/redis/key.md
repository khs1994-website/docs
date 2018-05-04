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

* http://redisdoc.com/

* http://redis.io/documentation

<!--more-->

切换数据库

```bash
SELECT 1 # redis 默认使用数据库 `0`
```

# 基本命令

* `set` KEY VALUE

* `del` KEY KEY2

* `exists` KEY

* `expire` KEY 30            # 单位为秒

* `pexpire` KEY 1500         # 单位为毫秒

* `ttl` key                  # 查看剩余生存时间

* `pttl` KEY                 # 查看剩余生存时间，单位毫秒

* `persist` KEY              # 去掉生存时间，不删除 key

* `expireat` KEY 1355292000  # unix 时间戳

* `pexpireat` KEY            # 毫秒时间戳

* `keys` *                   # 匹配数据库中所有 key

* `migrate` 127.0.0.1 6380 KEY DB_NAME TARGET_DB_NAME                # 将 key 原子性地从当前实例传送到目标实例的指定数据库上，一旦传送成功， key 保证会出现在目标实例上，而当前实例上的 key 会被删除。

* `move` KEY TARGET_DB_NAME        # 将当前数据库的 key 移动到给定的数据库 db 当中

* `randomkey`                      # 随机返回一个key

* `rename` KEY NEW_KEY_NAME

* `renamenx`                       # 当且仅当 newkey 不存在时，将 key 改名为 newkey nx => Not eXists

* `sort keys [DESC]`               # 默认从小到大 DESC 从大到小

* `dump` `restore` # 序列化给定的 KEY

# 数值类型

`type` KEY

* none
* string
* list
* set
* zset
* hash
