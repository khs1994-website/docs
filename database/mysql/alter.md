---
title: MySQL 修改数据表 ALTER
date: 2015-03-05 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

```sql
ALTER TABLE tbl_name AUTO_INCREMENT = 100;

ALTER TABLE tbl_name ADD [COLUMN] 列名 列定义 位置;

ALTER TABLE tbl_name MODIFY col_name 列定义 [ FIRST | AFTER 列名];
```

<!--more-->

# 修改列名称 `CHANGE`

```sql
ALTER TABLE tbl_name CHANGE 列名 新列名 列定义 位置;
```

# 数据表更名 `RENAME`

```sql
ALTER TABLE tbl_name RENAME [ TO | AS ] 新名称;

RENAME TABLE tbl_name TO 新名称;
```

# 添加约束

```sql
ALTER TABLE tbl_name ADD PRIMARY KEY (列名);
```

```sql
ALTER TABLE tbl_name ADD UNIQUE (列名);
```

```sql
ALTER TABLE tbl_name ADD FOREIGN KEY (列名) REFERENCES 父表(列名);
```

```sql
ALTER TABLE tbl_name ALTER 列名 SET DEFAULT 值;
```

# 删除默认约束

```sql
ALTER TABLE tbl_name ALTER 列名 DROP DEFAULT;
```

## 删除主键

```sql
ALTER TABLE tbl_name DROP PRIMARY KEY;
```

## 删除唯一约束

```sql
SHOW INDEXES FROM tbl_name;

ALTER TABLE tbl_name DROP 索引;
```

## 删除外键约束

```sql
SHOW CREATE TABLE 表名;

ALTER TABLE 表名 DROP FOREIGN KEY fk_symbol;
```
