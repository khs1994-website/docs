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
SELECT 字段1,字段2 FROM 表名 WHERE 条件 LIMIT 限制结果返回数量 OFFSET 偏移量;
```

<!--more-->

* WHERE

* `IN` `NOT IN`

* LIMIT

* OFFSET

* ORDER BY

* GROUP BY

* FETCH NEXT n

```sql
SELECT 表名.字段名 FROM 表名;

# 别名

SELECT 长字段 AS 别名 FROM 表名;

# 从第 2 条（0 为第一条）开始读（即，跳过第一条数据），返回 5 条数据

SELECT * FROM tbl_name LIMIT 1,5;

# 从第 2 条开始读（即，跳过前 1 条数据 ）

SELECT * FROM tbl_name LIMIT 1 OFFSET 1;
```

# 条件

```sql
SELECT 字段 FROM 表名 WHERE 条件;

SELECT 字段 FROM 表名 WHERE 条件 IS NULL;

SELECT 字段 FROM 表名 WHERE 条件 IS NOT NULL;

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

# 分组条件

SELECT 字段 FROM 表名 GROUP BY 字段 HAVING 字段 > 5;
```

# UNION

用于连接两个以上的 SELECT 语句的结果组合到一个结果集合中，多个 SELECT 语句会删除重复的数据。

```sql
mysql> SELECT col_name FROM tb1 UNION [ ALL | DISTINCT ] SELECT col_name FROM tb2;
```

# 连接 `JOIN`

* `INNER JOIN` 内连接（等值连接）获取两个表中字段匹配关系的记录。

* `LEFT JOIN` 获取左表所有记录，即使右表没有对应匹配的记录。

* `RIGHT JOIN`
