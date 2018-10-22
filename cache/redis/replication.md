---
title: Redis 复制(主从)
date: 2016-04-16 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

* https://redis.io/topics/replication

* http://www.redis.cn/topics/replication.html

<!--more-->

5.0.0 + 请将 slave 替换为 replica

主节点不用修改，从节点选择以下三种方法进行配置。

```bash
# 1.修改配置文件

slaveof master-ip master-port
# replicaof master-ip master-port

# 2.不修改配置文件，直接在启动时加上参数也可以

$ redis-server --port 6380 --slaveof 127.0.0.1 6379
# $ redis-server --port 6380 --replicaof 127.0.0.1 6379

# 3. redis-cli 中修改

redis> SLAVEOF 127.0.0.1 6379 # REPLICAOF

redis> SLAVEOF NO ONE # 使当前数据库停止接收其他数据库的同步，转成主数据库
```
