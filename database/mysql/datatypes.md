---
title: MySQL 数据类型
date: 2017-10-05 13:00:00
updated:
comments: true
tags:
- MySQL
categories:
- DataBase
- MySQL
---

对 MySQL 数据类型进行简要介绍。

<!--more-->

5.0 版本之后 `varchar(10)` 可以放 10 个汉字，10 个字母。此处表示字符数。

varchar(M) 其中的 M 代表的是字符数，而不是字节数，和编码类型无关。无论是哪种编码都只能存 M 个字符，比如 M=10 那么他能存 10 个汉字或者存 10 个英文字母。
