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

# 字段规则

小写 + 下划线 `user_name`

# 基本概念

* 表头(header): 每一列的名称;

* 列(row): 具有相同数据类型的数据的集合;

* 行(col): 每一行用来描述某个人/物的具体信息;

* 值(value): 行的具体信息, 每个值必须与该列的数据类型相同;

* 键(key): 表中用来识别某个特定的人\物的方法, 键的值在当前列中具有唯一性。

# 字符集

## 修改配置文件

```yaml
[client]
default-character-set = utf8mb4

[mysql]
default-character-set = utf8mb4

[mysqld]
character-set-client-handshake = FALSE
character-set-server = utf8mb4
collation-server = utf8mb4_unicode_ci
init_connect='SET NAMES utf8mb4'
```

## 查看字符集

```sql
SHOW VARIABLES WHERE Variable_name LIKE 'character\_set\_%' OR Variable_name LIKE 'collation%';

# 以下为原始配置信息，修改后的配置请自行查看

+--------------------------+-------------------+
| Variable_name            | Value             |
+--------------------------+-------------------+
| character_set_client     | utf8              |
| character_set_connection | utf8              |
| character_set_database   | latin1            |
| character_set_filesystem | binary            |
| character_set_results    | utf8              |
| character_set_server     | latin1            |
| character_set_system     | utf8              |
| collation_connection     | utf8_general_ci   |
| collation_database       | latin1_swedish_ci |
| collation_server         | latin1_swedish_ci |
+--------------------------+-------------------+
```

# 常见指令

```bash
$ mysql -uroot -pmytest -D test
```

* `-D` 指定数据库

* `-h` 指定主机

* `-P` 指定端口

```sql
# 切换数据库、数据表等

mysql> USE

# UNION 将多个 SELECT 结果组合到一起

mysql> SELECT country FROM tb1 UNION SELECT country FROM tb2 ORDER BY country; # 结果没有重复值

mysql> SELECT country FROM tb1 UNION ALL SELECT country FROM tb2 ORDER BY country; # 结果有重复值

# 正则表达式 REGEXP

mysql> SELECT ... WHERE name REGEXP '^st';
```

## 查看

```sql
mysql> SHOW DATABASES;

mysql> SHOW TABLES;

mysql> SHOW TABLES FROM db_name;


mysql> { SHOW COLUMNS FROM | DESCRIBE | DESC } tbl_name;

mysql> SHOW CREATE DATABASE db_name;

mysql> SHOW CREATE TABLE tbl_name;

mysql> SHOW warnings;

mysql> SHOW engines \G;
```

## 约束

`NULL` `NOT NULL`

`AUTO_INCREMENT`

`UNSIGNED`

`PRIMARY KEY` 或 `KEY`

`UNIQUE KEY`

`DEFAULT`

`FOREIGN KEY REFERENCES`

### 外键约束

`FOREIGN KEY`

```sql
mysql> CREATE TABLE 表名(
  pid 定义,
  FOREIGN KEY (pid) REFERENCES 父表 (字段) [参照操作];
);
```

#### 参照操作

`CASCADE`

`SET NULL` `ON DELETE`

`RESTRICT`

## 元数据

```sql
mysql> SELECT VERSION();

mysql> SELECT DATABASE();

mysql> SELECT USER();

mysql> SHOW STATUS;         # 服务器状态

mysql> SHOW VARIABLES;      # 服务器配置变量
```

## 事务

保证数据库的完整性

* `原子性` 要么成功，要么不成功。

* `一致性` 事务开始之前和结束之后，数据库的完整性没有被破坏。

* `隔离性` 防止多个事务并发执行时由于交叉执行而导致的数据的不一致，分为 `读未提交(READ UNCOMMITTED)` `读提交(READ COMMITTED)` `可重复读(REPEATABLE READ)` `串行化(SERIALIZABLE)`。

* `持久性` 事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。

`BEGIN` `START TRANSACTION` 显式的开启一个事务。

`COMMIT` 提交事务，并使对数据库进行的所有修改称为永久性的。

`ROLLBACK` 回滚 结束事务，并撤销正在进行的所有未提交的修改。

`SAVEPOINT` 创建一个保存点。

`RELEASE SAVEPOINT` 删除保存点。

`ROLLBACK TO ` 回滚到某个保存点。

`SET TRANSACTION` 设置事务的隔离级别。

# 并发控制

当多个连接对记录进行修改时保证数据的一致性和完整性。

## 锁

共享锁（读锁）同一时间段内，多个用户可以读取同一资源，读取过程中数据不会发生任何变化。

排它锁（写锁）在任何时候只能有一个用户写入资源，当进行写锁时会阻塞其他的读锁或者写锁操作。

## 锁颗粒

表锁

行锁
