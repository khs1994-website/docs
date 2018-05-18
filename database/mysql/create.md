---
title: MySQL CREATE 指令
date: 2015-03-06 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

`CREATE` 指令可用于创建数据库、数据表、函数等。

<!--more-->

```sql
mysql> CREATE DATABASE [if not exists] db_name CHARACTER set utf8mb4;

mysql> USE db_name;

mysql> CREATE TABLE `tb1`(
  `id` INT AUTO_INCREMENT,
  `pid` INT UNSIGNED COMMENT '注释',
  `username` VARCHAR(20) UNIQUE NOT NULL,
  PRIMARY key(`id`),
  unique index index_name(col_name)
) ENGINE=InnoDB auto_increment=100 DEFAULT CHARSET=utf8mb4;

# 临时表 断开与数据库的连接后，临时表就会自动被销毁

CREATE TEMPORARY TABLE  tb1();
```

# 函数

请查看其它文章。
