---
title: Redis 使用详解
date: 2016-04-05 12:00:00
updated:
comments: true
tags:
- Redis
categories:
- DataBase
- Redis
---

官方网站：https://redis.io/

<!--more-->

下载，解压，进入文件夹

```bash
$ make

$ make install

$ mkdir /data/usr/local/redis

$ cp redis.conf /data/usr/local/redis/

# 启动服务

$ redis-server /usr/local/etc/redis.conf

# 客户端连接工具

$ redis-cli

# 关闭服务

$ redis-cli shutdown

```

# Systemd

```bash
$ vi /lib/systemd/system/redis.service

[Unit]  
Description=Redis  
After=syslog.target network.target remote-fs.target nss-lookup.target  

[Service]  
Type=forking  
PIDFile=/var/run/redis.pid  
ExecStart=/home/redis/redis-3.2.0/src/redis-server /home/redis/redis-3.2.0/redis.conf  
ExecReload=/bin/kill -s HUP $MAINPID  
ExecStop=/bin/kill -s QUIT $MAINPID  
PrivateTmp=true  

[Install]  
WantedBy=multi-user.target
```

相关链接：
* http://blog.csdn.net/nimasike/article/details/52471992
