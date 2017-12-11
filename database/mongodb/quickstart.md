---
title: MongoDB 基本操作
date: 2016-04-02 13:00:00
updated:
comments: true
tags:
- MongoDB
categories:
- DataBase
- MongoDB
---

# 切换数据库

`use test`

无需新建数据库，切换时若不存在则自动新建数据库。

<!--more-->

# 查看数据库

```bash
$ show dbs
```

# 插入数据

`db.表名.方法`

不指明 id 则自动插入 id

`db.test_collection.insert({x:1})`

`db.test_collection.insert({x:3,_id:1})`

## 查看表名

`show collections`

## 查看表数据

`db.test_collection.find()`

`db.test_collection.find().count()`

`db.test_collection.find().skip(3).limit(2).sort({x:1})`

## 一次插入多条数据

`for(i=10;i<100;i++)db.test_collection.insert({x:i})`

# 数据更新

`db.test_collection.update({x:1},{x:999})`

## 更新部分数据

`db.test_collection.insert({x:1,y:2,z:3})`

`db.test_collection.update({z:100},{$set:{y:99}})`

## 更新不存在数据

`db.test_collection.update({x:999},{x:1099},true)`

## 更新多条数据

`db.test_collection.update({c:1},{$set:{c:2}},false,true)`

# 数据删除

`db.test_collection.remove({c:2})`

## 删除表

`db.test_collection.drop()`

`show tables`

# 索引
