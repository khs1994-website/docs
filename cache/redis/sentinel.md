---
title: Redis 哨兵模式 Sentinel
date: 2018-02-11 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

GitHub：https://github.com/khs1994-docker/lnmp/blob/master/docker-cluster.redis.sentinel.yml

* https://redis.io/topics/sentinel

* http://www.redis.cn/topics/sentinel.html

<!--more-->

* 监控（Monitoring）：Sentinel 会不断地检查你的主服务器和从服务器是否运作正常。

* 提醒（Notification）：当被监控的某个 Redis 服务器出现问题时， Sentinel 可以通过 API 向管理员或者其他应用程序发送通知。

* 自动故障迁移（Automatic failover）：当一个主服务器不能正常工作时， Sentinel 会开始一次自动故障迁移操作， 它会将失效主服务器的其中一个从服务器升级为新的主服务器，并让失效主服务器的其他从服务器改为复制新的主服务器；当客户端试图连接失效的主服务器时，集群也会向客户端返回新主服务器的地址，使得集群可以使用新主服务器代替失效服务器。
