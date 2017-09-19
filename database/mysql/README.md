---
title: MySQL 常用命令
date: 2016-04-03 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

# 删除用户

```bash
use mysql;
DELETE FROM user WHERE user='admin' and host='%';
```

<!--more-->

# 远程登录问题

## 改表

可能是你的帐号不允许从远程登陆，只能在localhost。这个时候只要在localhost的那台电脑，登入mysql后，更改 "mysql" 数据库里的 "user" 表里的 "host" 项，从"localhost"改称"%"

```
mysql -u root -pvmwaremysql>use mysql;

mysql>update user set host = '%' where user = 'root';

mysql>select host, user from user;
```

## 授权法。

例如，你想myuser使用mypassword从任何主机连接到mysql服务器的话。

```
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'%' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器，并使用mypassword作为密码

```
GRANT ALL PRIVILEGES ON *.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

如果你想允许用户myuser从ip为192.168.1.6的主机连接到mysql服务器的dk数据库，并使用mypassword作为密码

```
GRANT ALL PRIVILEGES ON dk.* TO 'myuser'@'192.168.1.3' IDENTIFIED BY 'mypassword' WITH GRANT OPTION;

FLUSH   PRIVILEGES;
```

我用的第一个方法,刚开始发现不行,在网上查了一下,少执行一个语句 `mysql>FLUSH RIVILEGES` 使修改生效.就可以了

另外一种方法,不过我没有亲自试过的,在csdn.net上找的,可以看一下.

在安装mysql的机器上运行：

```
$ mysql -h localhost -u root

mysql>GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION  //赋予任何主机访问数据的权限

mysql>FLUSH PRIVILEGES;  

```
