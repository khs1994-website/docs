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

# 修改列定义 `MODIFY`

```sql
ALTER TABLE 表名 MODIFY 列名 列定义 位置[FIRST | AFTER 列名];
```

<!--more-->

# 修改列名称 `CHANGE`

```sql
ALTER TABLE 表名 CHANGE 列名 新列名 列定义 位置;
```

# 数据表更名 `RENAME`

```sql
ALTER TABLE 表名 RENAME [ TO | AS ] 新名称;
```

```sql
RENAME TABLE 表名 TO 新名称;
```

# 添加单列 `ADD`

```sql
ALTER TABLE 表名 ADD [COLUMN] 列名 列定义 位置;
```

# 添加约束

```sql
ALTER TABLE 表名 ADD PRIMARY KEY (列名);
```

```sql
ALTER TABLE 表名 ADD UNIQUE (列名);
```

```sql
ALTER TABLE 表名 ADD FOREIGN KEY (列名) REFERENCES 父表(列名);
```

```sql
ALTER TABLE ALTER 列名 SET DEFAULT 值;
```

# 删除约束

```sql
ALTER TABLE 表名 ALTER 列名 DROP DEFAULT;
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
