---
title: MySQL 查找数据 SELECT
date: 2015-03-12 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

```sql
SELECT 字段1 AS 别名,tbl_name.字段2 FROM 表名 WHERE 条件 LIMIT N OFFSET 偏移量;
```

<!--more-->

* WHERE

* `IN` `NOT IN`

* LIMIT

* OFFSET

* ORDER BY

* GROUP BY

* FETCH NEXT n

* IS NULL

* IS NOT NULL

* LIKE

```sql
# 从第 2 条（0 为第一条）开始读（即，跳过第一条数据），返回 5 条数据

SELECT * FROM tbl_name LIMIT 1,5;

# 从第 2 条开始读（即，跳过前 1 条数据 ）

SELECT * FROM tbl_name LIMIT 1 OFFSET 1;
```

# 条件

```sql
SELECT 字段 FROM 表名 WHERE 条件;

# LIKE

SELECT 字段 FROM 表名 WHERE LIKE '%COM'
```

> `%` 是通配符

# 去重

```sql
SELECT DISTINCT cl_name FROM tb_name;
```

# 排序

```sql
SELECT 字段 FROM 表名 ORDER BY 字段 [ ASC | DESC ];
```

`ASC` 升序

# 分组

```sql
SELECT 字段 FROM 表名 GROUP BY 字段;

SELECT 字段 FROM 表名 GROUP BY 字段 WITH ROLLUP;

# 分组条件 对符合数据的进行分组

SELECT 字段 FROM 表名 GROUP BY 字段 HAVING 字段 > 5;
```

# UNION

用于连接两个以上的 `SELECT` 语句的结果组合到一个结果集合中，多个 `SELECT` 语句会删除重复的数据。

```sql
mysql> SELECT col_name,col_name2 FROM tb1 UNION [ ALL | DISTINCT ] SELECT col_name,col_name3 FROM tb2;
```

`SELECT` 后边字段数量要一致。结果的列名为第一个 `SELECT` 的列名。

# 子查询

```sql
mysql> SELECT * FROM tbl_name WHERE col = ANY (SELECT col2 FROM tbl_name2);

# 子查询返回多条结果，必须使用以下关键字 ANY SOME ALL

# [NOT] IN (subquery)

mysql> INSERT INTO tbl_name(col) SELECT col FROM tbl_name2;

```

## 多表更新

```sql
mysql> UPDATE tbl_references SET col={expr}

# UPDATE tbl_name AS tbl1 INNER JOIN tbl_name2 AS tbl2 ON col=col SET tbl1.col = tbl2.col;

mysql> CREATE tbl_name() SELECT * FROM tbl_name2;
```
