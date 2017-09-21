---
title: Bash echo read 命令详解
date: 2016-06-01 13:00:00
updated:
comments: true
tags:
- Linux
- Shell
categories:
- Linux
- Shell
---

echo 命令用来输出内容，read 命令用于读取用户输入。

<!--more-->

# echo 高亮输出

格式如下：

```bash
$ echo -e "\033[字背景颜色；文字颜色m字符串\033[0m"

$ echo -e "\033[41;36m something string \033[0m"

$ echo -e "\033[31m 红色字 \033[0m"
$ echo -e "\033[34m 黄色字 \033[0m"
$ echo -e "\033[41;33m 红底黄字 \033[0m"
$ echo -e "\033[41;37m 红底白字 \033[0m"
```

# read

read 命令从标准输入中读取一行，并把输入行的每个字段的值指定给 shell 变量。

## 提示语句

`-p` 参数

## 命令计数

`-n` 参数

当输入的字符数目达到预定数目时，自动退出，并将输入的数据赋值给变量。

## 等待时间

`-t` 参数 ，单位为秒

## 关闭回显

`-s`参数，能够使 read 命令中输入的数据不显示在显视器上，例如密码

# 参考链接

* http://www.cnblogs.com/lr-ting/archive/2013/02/28/2936792.html
