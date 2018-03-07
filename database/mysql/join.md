---
title: MySQL 连接 JOIN
date: 2015-03-14 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

从多个表中读取数据，在 `SELECT` `UPDATE` `DELETE` 语句中使用 `JOIN`。

<!--more-->

* `INNER JOIN` 内连接（等值连接）获取两个表中字段匹配关系的记录

* `LEFT JOIN` 左连接 获取左表所有记录，即使右表没有对应的匹配记录

* `RIGHT JOIN` 右连接 与上边的相反

# 示例表

```sql
DROP TABLE tb1,tb2;

CREATE TABLE `tb1`(
  `id` INT AUTO_INCREMENT ,
  `title` VARCHAR(100) NOT NULL,
  `author` VARCHAR(100) NOT NULL,
  `data` DATE DEFAULT NULL,
  key (`id`)
);

INSERT tb1 VALUES(null,'学习 MySQL','001','2018-01-01'),
                 (null,'学习 PHP','001','2018-01-02'),
                 (null,'学习 Java','002','2018-01-02'),
                 (null,'学习 HTML','003','2018-01-03');

CREATE TABLE `tb2`(
  `author` VARCHAR(100) NOT NULL,
  `num_count` INT NOT NULL
);

INSERT tb2 VALUES('001',20),
                 ('002',21),
                 ('003',22);
```

# 详解

```sql
SELECT tb1.id,tb1.author,tb2.num_count FROM tb1 a INNER JOIN tb2 b ON a.author=b.author;

SELECT tb1.id,tb1.author,tb2.num_count FROM tb1 a LEFT JOIN tb2 b ON a.author=b.author;

SELECT tb1.id,tb1.author,tb2.num_count FROM tb1 a RIGHT JOIN tb2 b ON a.author=b.author;
```
