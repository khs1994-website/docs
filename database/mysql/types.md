---
title: MySQL 数据类型
date: 2015-03-02 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

`MySQL` 有三大类数据类型, 分别为 `数字`、`日期\时间`、`字符串`。

<!--more-->

# 注意事项

5.0 版本之后 `varchar(M)` 其中的 `M` 代表的是字符数，而不是字节数，和编码类型无关。无论是哪种编码都只能存 M 个字符，比如 M=10 那么他能存 10 个汉字或者存 10 个英文字母。

# JSON 类型

```sql
CREATE TABLE tb1(
  `id`   BIGINT,
  `json` JSON
);
```

# 数值类型

`TINYINT` 8 位

`SMALLINT` 16 位

`MEDIUMINT` 24 位

`INT` `INTEGER` 32 位

`BIGINT` 64 位

## 浮点型

`FLOAT` 32 位 `DOUBLE` 64 位

`DECIMAL(M,D)`

# 日期时间类型

`DATA` 3 字节 YYYY-MM-DD

`TIME` 3 字节 HH:MM:SS

`YEAR` 1 字节 YYYY

`DATATIME` 8 字节 YYYY-MM-DD HH:MM:SS

`TIMESTAMP` 4 字节

# 字符串

`CHAR` 0-255 字节

`VARCHAR` 0-65535 字节 变长

`TINYBLOB` 0-255 字节

`TINTTEXT` 0-255 字节

`BLOB` 0-65535 字节

`TEXT` 0-65535 字节

`MEDIUMBLOB` 0-16 777 215 字节

`MEDIUMTEXT` 0-16 777 215 字节

`LONGBLOB` 0-4 294 967 295 字节

`LONGTEXT` 0-4 294 967 295 字节

`BINARY` `VARBINARY` 存储二进制字符串

## 用法说明

`BINARY` 保存二进制字符串，它保存的是字节而不是字符，没有字符集限制

`BLOB` 变长 保存二进制数据 比如 `图片` `音频` `视频`

`TEXT` 保存字符数据 比如 `文本`
