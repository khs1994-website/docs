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
);
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
