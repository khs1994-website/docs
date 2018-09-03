---
title: Bash set 详解
date: 2016-06-05 13:00:00
updated:
comments: true
tags:
- Linux
- Shell
categories:
- Linux
- Shell
---

* http://www.ruanyifeng.com/blog/2017/11/bash-set.html

<!--more-->

`set -u` 遇到不存在的变量就会报错，并停止执行。

`set -x` 用来在运行结果之前，先输出执行的那一行命令。

`set -e` 脚本只要发生错误，就终止执行

`set +e` 表示关闭 -e 选项

`set -o pipefail` 管道中只要有命令失败就退出。
