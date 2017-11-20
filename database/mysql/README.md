---
title: MySQL 初级命令
date: 2015-03-01 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

本文列举了一些初级的 MySQL 命令。

<!--more-->

# 创建

## 数据库

```sql
CREATE DATABASE 数据库名;
```

## 数据表

```sql
CREATE TABLE IF NOT EXISTS 表名(
  字段名 列定义,
  字段名 列定义
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

# 查看

```sql
SHOW DATABASES;

SHOW TABLES;

SHOW TABLES FROM 数据库名;

SHOW COLUMNS FROM 表名;
```

# 约束

`NULL`

`NOT NULL`

`AUTO_INCREMENT`

`UNSIGNED`

`PRIMARY KEY` 或 `KEY`

`UNIQUE KEY`

`DEFAULT`

## 外键约束

`FOREIGN KEY`

```sql
CREATE TABLE 表名(
  pid 定义,
  FOREIGN KEY (pid) REFERENCES 父表 (字段) [参照操作];
);
```

`CASCADE`

`SET NULL` `ON DELETE`

`RESTRICT`

# 删除用户

```sql
USE mysql;
DELETE FROM user WHERE user='admin' and host='%';
```

# 字符集

## 修改配置文件

```yaml
character-set-server = utf8mb4
```

## 查看字符集

```sql
SHOW VARIABLES LIKE 'character%';
```

# 元数据

```sql
SELECT VERSION();

SELECT DATABASE();

SELECT USER();

SHOW STATUS;         # 服务器状态

SHOW VARIABLES;      # 服务器配置变量
```

# 事物

保证数据库的完整性

`原子性`

`一致性`

`隔离性`

`持久性`

# 存储引擎

`InnoDB`

`MyISAM` 8.0 已废弃

`Memory`

`CSV`

`Archive`

## 设置存储引擎

```bash
default-storage-engine = engine
```

# 并发控制

当多个连接对记录进行修改时保证数据的一致性和完整性。

## 锁

共享锁（读锁）同一时间段内，多个用户可以读取同一资源，读取过程中数据不会发生任何变化。

排它锁（写锁）在任何时候只能有一个用户写入资源，当进行写锁时会阻塞其他的读锁或者写锁操作。

## 锁颗粒

表锁

行锁
