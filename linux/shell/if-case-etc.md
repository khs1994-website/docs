---
title: Bash 条件判断与流程控制相关语句详解
date: 2016-06-03 13:00:00
updated:
comments: true
tags:
- Linux
- Bash
categories:
- Linux
---

介绍 if case 等语句。

<!--more-->

# 条件判断语句

## 字符串判断

str1 = str2　　　　当两个串有相同内容、长度时为真

str1 != str2　　　当串str1和str2不等时为真

-n str1　　　　　　当串的长度大于0时为真(串非空)

-z str1　　　　　　当串的长度为0时为真(空串)

str1　　　　　　　　当串str1为非空时为真

## 数值的判断

int1 -eq int2　　　两数相等为真

int1 -ne int2　　　两数不等为真

int1 -gt int2　　　int1大于int2为真

int1 -ge int2　　　int1大于等于int2为真

int1 -lt int2　　　int1小于int2为真

int1 -le int2　　　int1小于等于int2为真

## 文件相关的判断语句

-r file　　　　　用户可读为真

-w file　　　　  用户可写为真

-x file　　　　　用户可执行为真

-f file　　　　　文件为普通文件为真

-d file　　　　　文件为目录为真

-c file　　　　　文件为字符特殊文件为真

-b file　　　　　文件为块特殊文件为真

-s file　　　　　文件大小非0时为真

-t file　　　　　当文件描述符(默认为1)指定的设备为终端时为真

## 逻辑判断

-a 　 与

-o　　或

!　　 非

# if

## 基本结构

```bash
if [ 条件判断 ]; then
do something here
elif [ 条件判断 ]; then
do another thing here
else
do something else here
fi
```

或者

```bash
if [ 条件判断 ]
then
 Command
else
 Command
fi
```

举例如下

```bash
# 获取操作系统类型
SYSTEM=`uname -s`
# [] 内两边必须有空格
# if 与 then 在同一行，判断语句后加上 ;
if [ $SYSTEM = "Linux" ]; then
echo "Linux"
else
echo "OS is not Linuix"
fi
```

也可以写成

```bash
SYSTEM=`uname -s`
if [ $SYSTEM = "Linux" ]
then
echo "Linux"
else
echo "OS is not Linuix"
fi
```

# case

## 基本结构

```bash
case $1 in
  模式1 ）

  命令序列1

  ;;

  模式2 ）

  命令序列2

  ;;

  * ）

  默认执行的命令序列
  ;;
esac
```

# 参考链接

* http://www.cnblogs.com/huai371720876/p/4561195.html
