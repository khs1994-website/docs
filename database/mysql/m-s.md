---
title: 使用 Docker 配置 MySQL 主从集群
date: 2016-04-02 13:00:00
updated:
comments: true
tags:
- MySQL
- Docker
categories:
- DataBase
- MySQL
---

使用 Docker Compose 启动一主一从的 MySQL 集群。

GitHub：https://github.com/khs1994-docker/mysql

<!--more-->

# 配置文件内容

## 主服务器

```yaml
[mysqld]
log-bin = mysql-bin
server-id = 1
```

## 从服务器

```yaml
[mysqld]
pid-file	= /var/run/mysqld/mysqld.pid
socket		= /var/run/mysqld/mysqld.sock
datadir		= /var/lib/mysql
#log-error	= /var/log/mysql/error.log
# By default we only accept connections from localhost
#bind-address	= 127.0.0.1
# Disabling symbolic-links is recommended to prevent assorted security risks
symbolic-links=0


log-bin = mysql-bin
server-id = 2
```

## 启动Docker MySQL

编写 `docker-compose.yml` 文件

```yaml
version: '3'
services:
  mysql_1:
    image: mysql
    env_file: .env
    ports:
      - 3306:3306
    volumes:
      - ./var/lib/mysql1:/var/lib/mysql
      - ./etc/mysql/mysql.conf.d:/etc/mysql/mysql.conf.d
  mysql_2:
    image: mysql
    env_file: .env
    ports: "3307:3306"
    volumes:
      - ./var/lib/mysql2:/var/lib/mysql
      - ./etc/mysql/mysql2.conf.d/:/etc/mysql/mysql.conf.d      
```

新建 `.env` 文件

```bash
MYSQL_ROOT_PASSWORD=mytest
```

启动 Docker 容器

```bash
$ docker-compose up -d
```

# 关联节点

## 主服务器

登录主服务器

```bash
$ docker exec -it **** bash
$ mysql -uroot -p
```

```sql
GRANT REPLICATION SLAVE ON *.* to 'backup'@'%' identified by 'mytest';
SHOW master status;
```

记住File、Position的值。我查出来的是 `mysql-bin.000004`、`312`

## 从服务器

登录从服务器

```bash
$ docker exec -it **** bash
$ mysql -uroot -p
```

```sql
change master to master_host='172.17.0.1',master_user='backup',
     master_password='mytest',master_log_file='mysql-bin.000001',
     master_log_pos=154,master_port=3306;
start slave;
show slave status;
```

# 测试

在主服务器创建一个数据库

```sql
create database test;
```

登录从服务器查看数据库，发现已经存在了 test（与主服务器同步）

```sql
show databases;
```

# 相关链接

* http://blog.csdn.net/qq362228416/article/details/48569293  
* http://blog.csdn.net/he90227/article/details/54140422
