---
title: MySQL 导出数据 mysqldump 命令
date: 2015-03-15 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

`mysqldump` 命令用于导出数据库。

<!--more-->

```bash
# 导出某数据库 只能是一个数据库，后边参数表示这个数据的表名
# 导出多个数据库请使用下一条命令
# 导出某数据库中的某表
mysqldump [OPTIONS] database [tables]

# 导出指定数据库

mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]

# 导出全部数据库

mysqldump [OPTIONS] --all-databases [OPTIONS]
```
