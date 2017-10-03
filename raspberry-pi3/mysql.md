---
title: 树莓派 Debian9 MySQL 实践
date: 2017-07-23 23:00:00
updated:
comments: true
tags:
- Raspberry Pi3
- MySQL
categories:
- Raspberry Pi3
---

Debian 9 使用 apt 安装 MySQL 会安装 MariaDB，下面介绍一下常用的配置方法。

<!--more-->

# 密码

做一次安全检查，设置 root 密码等操作。

```bash
$ sudo /usr/bin/mysql_secure_installation  
```

刚装好的服务端时只能用 sudo 命令登录，然后进行后续设置

```bash
$ sudo mysql -u root -p
```

设置密码之后，根据测试，使用 sudo 登录 MySQL 在输密码处直接回车也能登录。

这是由于 [plugin=unix_socket](https://www.baidu.com/s?wd=plugin%20unix_socket) 造成的，使用如下命令解决该问题。

```bash
$ sudo mysql -u root
use mysql;
update user set plugin='' where User='root';
flush privileges;
```

执行之后必须使用密码才能登录。

# 远程登录

```bash
$ sudo vi /etc/mysql/mariadb.conf.d/50-server.cnf


[mysqld]

# 将 `bind-address		= 127.0.0.1` 注释
```

## 查看权限

```bash
MariaDB [(none)]> SELECT host,user,password,Grant_priv,Super_priv FROM mysql.user;
+-----------+------+-------------------------------------------+------------+------------+
| host      | user | password                                  | Grant_priv | Super_priv |
+-----------+------+-------------------------------------------+------------+------------+
| localhost | root | *06EE5A234B2A56A0FD89545356F30594E36CC7EF | Y          | Y          |
+-----------+------+-------------------------------------------+------------+------------+
1 row in set (0.00 sec)
```

## 赋予完整权限

```bash
GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.199.%' IDENTIFIED BY 'your-password' WITH GRANT OPTION;
```

我们已经创建root用户，并且让这个用户在192.168.199.0/24 地址内能连接到服务器。

重启 `mysql.service` 服务，进行测试。

```bash
$ sudo systemctl restart mysql.service
```

`mysql.service` 和 `mysqld.service` 位于 `/etc/systemd/system`，均软链接到了 `/lib/systemd/system/mariadb.service`

# 相关链接

* https://mariadb.com/kb/zh-cn/configuring-mariadb-for-remote-client-access/
