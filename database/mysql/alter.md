---
title: MySQL 修改列定义 ALTER
date: 2015-03-04 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

# 修改列定义

```sql
ALTER table 表名 MODIFY 字段名 列定义 位置[FIRST | AFTER 字段名];
```

<!--more-->

# 修改列名称

```sql
ALTER table 表名 CHANGE 原字段名 新字段名 列定义 位置;
```

# 数据表更名

```sql
ALTER table 表名 RENAME [ TO | AS ] 新名称;
```

```sql
RENAME table 表名 TO 新名称;
```

# 添加单列

```sql
ALTER TABLE 表名 ADD [COLUMN] 字段名 列定义 位置;
```

# 添加约束

```sql
ALTER TABLE 表名 ADD PRIMARY KEY (字段);
```

```sql
ALTER TABLE 表名 ADD UNIQUE (字段);
```

```sql
ALTER TABLE 表名 ADD FOREIGN KEY (字段) REFERENCES 父表(字段);
```

```sql
ALTER TABLE ALTER 字段 SET DEFAULT 值;
```

# 删除约束

```sql
ALTER TABLE 表名 ALTER 字段 DROP DEFAULT;
```

```sql
ALTER TABLE 表名 DROP PRIMARY KEY;
```

## 删除唯一约束

```sql
SHOW INDEXES FROM 表名;
ALTER TABLE 表名 DROP 索引;
```

## 删除外键约束

```sql
SHOW CREATE TABLE 表名;
ALTER TABLE 表名 DROP FOREIGN KEY fk_symbol;
```
