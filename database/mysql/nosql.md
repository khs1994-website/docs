---
title: MySQL 存储 NoSQL 数据
date: 2018-04-22 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

MySQL 存储 `JSON`

<!--more-->

```sql
mysql> CREATE TABLE tb1(c1 JSON);

mysql> INSERT INTO tb1 VALUSE('{"key"=>1}');

mysql> SELECT json_array('a','b',now()); # ['a','b',time]

mysql> SELECT json_object('key1',1,'key2',2); # {'ksy1':1,'key2',2}
```
