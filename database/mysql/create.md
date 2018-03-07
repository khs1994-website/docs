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

# 数据库

```sql
CREATE DATABASE db1;
```

# 数据表

```sql
USE DB1;

CREATE TABLE `tb1`(
  `id` INT AUTO_INCREMENT,
  `pid` INT UNSIGNED,
  `username` VARCHAR(20) UNIQUE NOT NULL,
  key(`id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
```

# 函数

请查看其它文章。
