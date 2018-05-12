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

官方文档：https://dev.mysql.com/doc/refman/8.0/en/json-function-reference.html

<!--more-->

```sql
mysql> CREATE TABLE tb1(c1 JSON);

mysql> INSERT INTO tb1 VALUSE('{"key"=>1}');

mysql> SELECT json_array('a','b',now()); # ['a','b',time]

mysql> SELECT json_object('key1',1,'key2',2); # {'ksy1':1,'key2',2}
```

# 函数详解

## 创建

* `json_array()`

* `json_merge()` => ` JSON_MERGE_PRESERVE()`(8.0)

* `JSON_MERGE_PATCH()`

* `json_object()`

## 查询

* `json_contains()`

* `json_contains_path()`

* `json_extract()`

* `json_keys()`

* `json_search()`

## 修改

* `json_append()`（8.0 废弃） => `JSON_ARRAY_APPEND()`

* `json_array_insert()`

* `json_insert()` 对于原文本中已存在的键值，采取跳过而不覆盖的策略。

* `json_remove()`

* `json_replace()`

* `json_set()`

* `json_quote()` 转义引号

* `json_unquote()`

## Mete

* `json_depth()`

* `json_length()`

* `json_type()`

* `json_valid()`
