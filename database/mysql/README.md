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

# 常见指令

```sql
# 切换数据库、数据表等

USE

# UNION 将多个 SELECT 结果组合到一起

SELECT country FROM tb1 UNION SELECT country FROM tb2 ORDER BY country; # 结果没有重复值

SELECT country FROM tb1 UNION ALL SELECT country FROM tb2 ORDER BY country; # 结果有重复值

# 正则表达式 REGEXP

SELECT ... WHERE name REGEXP '^st';
```

# 查看

```sql
SHOW DATABASES;

SHOW TABLES;

SHOW TABLES FROM 数据库名;

# 查看表结构

SHOW COLUMNS FROM 表名;
```

# 约束

`NULL` `NOT NULL`

`AUTO_INCREMENT`

`UNSIGNED`

`PRIMARY KEY` 或 `KEY`

`UNIQUE KEY`

`DEFAULT`

`FOREIGN KEY REFERENCES`

## 外键约束

`FOREIGN KEY`

```sql
CREATE TABLE 表名(
  pid 定义,
  FOREIGN KEY (pid) REFERENCES 父表 (字段) [参照操作];
);
```

### 参照操作

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

# 事务

保证数据库的完整性

`原子性` 要么成功，要么不成功。

`一致性` 事务开始之前和结束之后，数据库的完整性没有被破坏。

`隔离性` 防止多个事务并发执行时由于交叉执行而导致的数据的不一致，分为 `读未提交(READ UNCOMMITTED)` `读提交(READ COMMITTED)` `可重复读(REPEATABLE READ)` `串行化(SERIALIZABLE)`。


`持久性` 事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。

`BEGIN` `START TRANSACTION` 显式的开启一个事务。

`COMMIT` 提交事务，并使对数据库进行的所有修改称为永久性的。

`ROLLBACK` 回滚 结束事务，并撤销正在进行的所有未提交的修改。

`SAVEPOINT` 创建一个保存点。

`RELEASE SAVEPOINT` 删除保存点。

`ROLLBACK TO ` 回滚到某个保存点。

`SET TRANSACTION` 设置事务的隔离级别。

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
