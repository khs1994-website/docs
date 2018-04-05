---
title: MySQL 插入/更新 INSERT UPDATE
date: 2015-03-10 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

```sql
INSERT (INTO) 表名 VALUES()
```

<!--more-->

```sql
INSERT 表名(字段1,字段2,...) VALUES()
```

```sql
INSERT 表名 SET 字段名=值;
```

# 将查询结果插入表中

```sql
INSERT 表名 SELECT
```

# 更新

```sql
UPDATE tb_name SET 字段名=值 WHERE 条件;
```
