---
title: MySQL 函数
date: 2015-03-09 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

函数相关内容。

<!--more-->

# 字符函数

## 字符连接

`CONCAT('a','b')`

## 使用指定分隔符进行字符连接

`CONCAT_WS('-','a','b')`

## 数字格式化

`FORMAT(1234.56,2)`

## 大小写转化

`LOWER()` `UPPER()`

## 获取左侧、右侧 字符

`LEFT('MYSQL',2)`

`RIGHT('MYSQL',2)`

`LENGTH()`

`LTRIM()` `RTRIM()`

`TRIM()`

例子，删除前导的字符

`TRIM(LEADING '?' FROM '??MYSQL???')`

结果为

`MYSQL???`

## 字符串截取

`SUBSTRING('MYSQL','1','2')` 结果 `MY`

## 模式匹配

`[NOT] LIKE`

`%` 任意字符

下划线 `_` 任意一个字符

## 替换

`REPLACE('??MYSQL??','?','')`

# 数值运算

## 进一取整

`CEIL()`

## 舍一取整

`FLOOR()`

## 整数除法

`DIV`

`3 DIV 4` 结果 0

## 取余 （取模）

`MOD`

## 幂运算

`POWER(3,3)` 结果 9

## 四舍五入

`ROUND(3.61,2)`

## 数字截取

`TRUNCATE(125.89,0)` 结果 125

# 比较运算符

`[NOT] BETWEEN ... AND ...`

`15 BETWEEN 1 AND 20`

`[NOT] IN()`

`10 IN(2,10,20)`

`IS [NOT] NULL`

# 日期时间函数

`NOW()`

`CURDATE()`

`CURTIME()`

`DATE_ADD('2014-3-12',INTERVAL 365 DAY)`

## 相差天数

`DATEDIFF('2014-3-12','2013-3-12')`

## 日期格式化

`DATE_FORMATE('2014-3-12','%m/%d/$Y')`

# 信息函数

`CONNECTION_ID()`

`DATABASE()`

`LAST_INSERT_ID()`

`USER()`

`VERSION()`

# 聚合函数

## 平均数

`AVG()`

## 计数

`COUNT()`

`MAX()`

`MIN()`

`SUM()`

# 加密函数

`MD5()`

`PASSWORD()`

# 自定义函数

## 创建函数

```sql
CREATE FUNCTION 函数名
RETURNS
{STRING|INTEGER|REAL|DECIMAL}
函数体;
```
## 删除函数

`DROP FUNCTION f1;`

## 举例

```sql
CREATE FUNCTION f1()
RETURNS VARCHAR(30)
RETURN DATA_FORMAT(NOW(),'%Y/%m/%d %H:%i:%s')
```

```sql
CREATE FUNCTION f2(num1 SMALLINT UNSIGNED,num2 SMALLINT UNSIGNED)
RETURNS FLOAT(10,2) UNSIGNED
RETURN (num1+num2)/2
```

函数体若为复合结构，则使用 `BEGIAN END`

```sql
CREATE FUNCTION adduser(username VARCHAR(20))
RETURNS INT UNSIGNED
BEGIN
INSERT test() VALUES(username);
LATEST_INSERT_ID()
END
//
```
