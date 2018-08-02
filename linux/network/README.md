---
title: Linux 网络相关
date: 2016-08-01 13:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
- Network
---

* https://www.imooc.com/learn/344

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

### ss

* http://man.linuxde.net/ss

```bash
$ ss -h
```

# Other

* `nslookup`

* `ip route list` 查看路由表

* `tracepath` 追踪并显示报文到达目的主机所经过的路由信息

* `traceroute`
