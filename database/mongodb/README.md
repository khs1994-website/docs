---
title: MongoDB 安装配置
date: 2016-04-01 13:00:00
updated:
comments: true
tags:
- MongoDB
categories:
- DataBase
- MongoDB
---

官方网站：https://www.mongodb.com/

<!--more-->

`MongoDB` 是一个基于分布式文件存储的数据库。由 `C++` 语言编写。旨在为 WEB 应用提供可扩展的高性能数据存储解决方案。是一个介于关系数据库和非关系数据库之间的产品，是非关系数据库当中功能最丰富，最像关系数据库的。

# 配置文件

```bash
systemLog:
  destination: file
  path: /var/log/mongodb/mongo.log
  logAppend: true
storage:
  dbPath: /var/lib/mongodb
processManagement:
  fork: true
net:
  bindIp: 127.0.0.1
  port: 27017
```

# 启动

```bash
$ mongod --config /usr/local/etc/mongod.conf

# 客户端连接

$ mongo 127.0.0.1:端口/数据库
```

# 关闭

```bash
use admin
db.shutdownServer()
```
