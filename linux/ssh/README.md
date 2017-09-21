---
title: SSH 配置详解
date: 2016-08-10 13:00:00
updated:
comments: true
tags:
- Linux
- SSH
categories:
- Linux
---

本文详细介绍了 SSH 的配置。

<!--more-->

# SSH无密码登录

```bash
# 产生公钥与私钥对

$ ssh-keygen

# 按三次回车键
# 将本机的公钥(id_rsa.pub)复制到远程机器的authorized_keys文件中( 用户主目录/.ssh/authorized_keys)

$ ssh-copy-id user@ip
```

# Ubuntu

SSH 分客户端 `openssh-client`和服务端 `openssh-server` 如果你只是想登陆别的机器只需要安装客户端

```bash
$ sudo apt install openssh-client
```

如果要使本机开放 SSH 服务就需要安装服务端

```bash
$ sudo apt install openssh-server
```

然后确认 sshserver 是否启动了：

```bash
$ ps -e |grep ssh
```

如果看到 sshd 那说明 ssh-server 已经启动了,如果没有则可以这样启动：

```bash
$ sudo /usr/sbin/sshd
```

# 配置

`ssh-server` 配置文件位于 `/etc/ssh/sshd_config` 在这里可以定义 SSH 的服务端口，默认端口是 22，你可以自己定义成其他端口号。

## 不允许密码登录,只允许公钥登录

```bash
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication no
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no
```

配置文件中上诉两项改为 `no`，之后重启 `sshd` 服务。现在我们在一台不带信任 key 的机器尝试登录，那么会提示如下信息:

```bash
⋊> ~ ssh ubuntu@123.206.62.18
Permission denied (publickey).
```

# 解决自动断开

服务端设置环境变量 `TMOUT=0`，在客户端 `~/.ssh/config` 文件中进行如下配置:

```bash
Host *
     ServerAliveInterval 60
```

# 相关链接

* http://www.cnblogs.com/kqdongnanf/p/6517836.html
* http://blog.csdn.net/iloveyin/article/details/11808377
