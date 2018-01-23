---
title: Redis 使用详解
date: 2016-04-04 12:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

官方网站：https://redis.io/

<!--more-->

下载，解压，进入文件夹

```bash
$ make

$ make install

$ mkdir /usr/local/redis

$ cp redis.conf /usr/local/redis/

# 启动服务

$ redis-server /usr/local/redis/redis.conf

# 客户端连接工具

$ redis-cli

# 关闭服务

$ redis-cli shutdown

```

# systemd

`/etc/systemd/system/redis.service`

```bash
[Unit]  
Description=Redis  
After=syslog.target network.target remote-fs.target nss-lookup.target  

[Service]  
Type=forking  
PIDFile=/var/run/redis.pid
# 注意替换为你自己的实际路径
ExecStart=/REDIS_PATH/redis-3.2.0/src/redis-server /usr/local/redis/redis.conf
ExecReload=/bin/kill -s HUP $MAINPID  
ExecStop=/bin/kill -s QUIT $MAINPID  
PrivateTmp=true  

[Install]  
WantedBy=multi-user.target
```

# 相关链接

* http://blog.csdn.net/nimasike/article/details/52471992
