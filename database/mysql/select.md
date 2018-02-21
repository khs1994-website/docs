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

```sql
SELECT 表名.字段名 FROM 表名;
```

# 别名

```sql
SELECT 长字段 AS 别名 FROM 表名;
```

# 条件

```sql
SELECT 字段 FROM 表名 WHERE 条件;
```

```sql
SELECT 字段 FROM 表名 WHERE 条件 IS NULL;
```

```sql
SELECT 字段 FROM 表名 WHERE 条件 IS NOT NULL;
```

## LIKE

```sql
SELECT 字段 FROM 表名 WHERE LIKE '%COM'
```

> `%` 是通配符

# 排序

```sql
SELECT 字段 FROM 表名 ORDER BY 字段 [ ASC | DESC ];
```

`ASC` 升序

# 分组

```sql
SELECT 字段 FROM 表名 GROUP BY 字段;
```

```sql
SELECT 字段 FROM 表名 GROUP BY 字段 WITH ROLLUP;
```

## 分组条件

```sql
SELECT 字段 FROM 表名 GROUP BY 字段 HAVING 字段 > 5;
```
