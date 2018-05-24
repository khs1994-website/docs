---
title: 参看某 IP 端口是否打开
date: 2016-08-01 13:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
- Network
---

端口相关命令介绍。

<!--more-->

```bash
$ telnet 192.168.199.120 80

$ nc -z 192.192.193.211 22

$ nc -vz 192.168.120 20-30
```

# 谁占用了端口

## Windows

PowerShell

```bash
$ netstat -ano | select-string port

# 结果最后一行为 pid

$ stop-process pid
```

## Linux

```bash
$ lsof -i

$ lsof -i:8000

$ netstat -anp | grep 80
```
