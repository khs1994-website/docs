---
title: 使用 Docker 配置 MySQL 主从集群
date: 2015-03-04 13:00:00
updated:
comments: true
tags:
- MySQL
- Docker
categories:
- DataBase
- MySQL
---

使用 `Docker Compose` 启动一主两从的 MySQL 集群。

GitHub：https://github.com/khs1994-docker/lnmp/blob/master/docker-cluster.mysql.yml

<!--more-->

# 类型

* 一主多从

* 多主一丛 （多源复制）

# 配置文件内容

可以通过命令配置，这里以配置文件举例。

## 主服务器

```yaml
[mysqld]
log-bin = mysql-bin
server-id = 1
```

## 从服务器

```yaml
[mysqld]
server-id = 10
```

# 关联节点

下面了介绍手动执行的步骤，GitHub 中将这一步写入了 shell 脚本文件。

## 主服务器

登录主服务器

```sql
CREATE USER 'backup'@'%' identified by 'mytest';

GRANT REPLICATION SLAVE ON *.* to 'backup'@'%';

SHOW master status;
```

记住 `File`、`Position` 的值。我查出来的是 `mysql-bin.000004`、`312`

## 从服务器

登录从服务器

```sql
change master to master_host='mysql_1',master_user='backup',
     master_password='mytest',master_log_file='mysql-bin.000004',
     master_log_pos=312,master_port=3306;

start slave;

show slave status;
```

# 测试

在主服务器创建一个数据库

```sql
create database test;
```

在从服务器查看数据库，发现已经存在了 test（与主服务器同步）

```sql
show databases;
```

# More Information

* http://blog.csdn.net/qq362228416/article/details/48569293

* http://blog.csdn.net/he90227/article/details/54140422
