---
title: MySQL 索引 INDEX
date: 2015-03-11 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

```sql
[ UNIQUE | FULLTEXT | SPATIAL ]  [ INDEX | KEY ]
[ 别名 ]  ( col_name  [(索引长度，仅字符串类型)]  [ ASC | DESC ] );
```

<!--more-->

**单列索引** 即一个索引只包含单个列。 `KEY [ index_name ] (col_name)`

**组合/复合 索引** 即一个索引包含多个列。`INDEX index_name (col_name1,col_name2)`

* 普通索引

* 主键 `primary key`

* 唯一索引 `unique INDEX index_name (col_name1,col_name2)`

* 空间索引 (仅 MyISAM 引擎支持)

* 全文索引 `fulltext KEY` (仅 MyISAM 引擎支持) (只能创建在 CHAR、VARCHAR 或 TEXT 类型的字段上)

MySQL 只对以下操作符才使用索引：`<` `<=` `=` `>` `>=` `between` `in` 以及某些时候的 `like` (不以通配符 % 或 _ 开头的情形，`%a` 不可以，`a%` 可以)

索引不会包含有 null 值的列

不要在列上进行运算

```sql
SELECT * FROM table_name WHERE YEAR(column_name)<2017;
```

# 原则

* 最左前缀

* 可以考虑使用索引的主要有两种类型的列：在 where 子句中出现的列，在 join 子句中出现的列

* 考虑列中值的分布，索引的列的基数越大，索引的效果越好

* 使用短索引，如果对字符串列进行索引，应该指定一个前缀长度，可节省大量索引空间，提升查询速度

* 不要过度索引

```sql
SHOW INDEX FROM tbl_name;

CREATE INDEX index_name ON tbl_name(col_name(长度));

# 修改表结构 添加索引

ALTER TABLE tbl_name ADD INDEX index_name(col_name);

DROP INDEX index_name ON tbl_name;
```

# explain

```sql
mysql> explain select * from servers;
+----+-------------+---------+------+---------------+------+---------+------+------+-------+
| id | select_type | table   | type | possible_keys | key  | key_len | ref  | rows | Extra |
+----+-------------+---------+------+---------------+------+---------+------+------+-------+
|  1 | SIMPLE      | servers | ALL  | NULL          | NULL | NULL    | NULL |    1 | NULL  |
+----+-------------+---------+------+---------------+------+---------+------+------+-------+
```
