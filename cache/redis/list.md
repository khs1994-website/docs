---
title: Redis list 类型
date: 2016-04-07 13:00:00
updated:
comments: true
tags:
- Redis
categories:
- Cache
- Redis
---

序列（list）两端推入、或弹出元素，修剪、查找、移除元素。

<!--more-->

* `lpush` list1 1 2 3  

* `rpop` list1

* `llen` list1

* `lindex` key index # 返回列表中下表为 index 的元素

* `lset` key index value

* `linsert` key berore | after pivot value # 将值 value 插入到列表 key 当中，位于值 pivot 之前或之后。

* `lrange` key start end # 返回列表 key 中指定区间内的元素，区间以偏移量 start 和 stop 指定

* `lrem` key count value # 根据参数 count 的值，移除列表中与参数 value 相等的元素

* `ltrim` key start end  # 让列表只保留指定区间内的元素，不在指定区间之内的元素都将被删除
