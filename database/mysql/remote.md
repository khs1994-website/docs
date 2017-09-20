---
title: MySQL 远程登录配置
date: 2016-04-03 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

开启 MySQL 的远程登录需要一些配置，网上一些教程较陈旧，不适用于新版本。

<!--more-->

# 改表法

更改 "mysql" 数据库里的 "user" 表里的 "host" 项，将 "localhost" 改为 "%"

```sql
mysql>use mysql;

mysql>update user set host = '%' where user = 'root';

mysql>select host, user from user;
```

# 授权法

例如，你想 myuser 使用 mypassword 从任何主机连接到 mysql 服务器的话。

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户 myuser 从ip为 192.168.1.6 的主机连接到 mysql 服务器，并使用 mypassword 作为密码

```sql
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户 myuser 从 ip 为 192.168.1.6 的主机连接到 mysql 服务器的 dk 数据库，并使用 mypassword 作为密码

```sql
GRANT ALL PRIVILEGES ON dk.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

# 参考链接
