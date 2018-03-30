---
title: MySQL 配置文件详解
date: 2015-03-14 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

MySQL 配置文件详解。

GitHub：https://github.com/khs1994-docker/lnmp/blob/master/config/mysql/docker.cnf

<!--more-->

# 错误设置

```bash
［client］
default-character-set=utf8

［mysqld］
# 5.5 之后不能在此处设置该选项
# default-character-set=utf8

# 正确
character-set-server=utf8
```

# 字符集

服务器级、数据库级、表级、列级和连接级。

* https://www.2cto.com/database/201302/189920.html
