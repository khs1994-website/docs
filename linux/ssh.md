---
title: SSH 初始化配置
date: 2016-08-09 13:00:00
updated:
comments: true
tags:
- Linux
- SSH
categories:
- Linux
---

# SSH无密码登录

```bash
# 产生公钥与私钥对

$ ssh-keygen

# 按三次回车键
# 将本机的公钥(id_rsa.pub)复制到远程机器的authorized_keys文件中( 用户主目录/.ssh/authorized_keys)

$ ssh-copy-id user@ip
```

<!--more-->

# Ubuntu

SSH分客户端`openssh-client`和`openssh-server`

如果你只是想登陆别的机器只需要安装openssh-client（ubuntu有默认安装，如果没有)

```bash
$ sudo apt install openssh-client
```

如果要使本机开放SSH服务就需要安装openssh-server

```bash
$ sudo apt install openssh-server
```

然后确认sshserver是否启动了：

```bash
$ ps -e |grep ssh
```

如果看到sshd那说明ssh-server已经启动了,如果没有则可以这样启动：

```bash
$ sudo /usr/sbin/sshd
```

# 配置

`ssh-serve`r配置文件位于`/etc/ssh/sshd_config`。  
在这里可以定义SSH的服务端口，默认端口是22，你可以自己定义成其他端口号，如222。

## 不允许密码登录,只允许公钥登录

```bash
# To disable tunneled clear text passwords, change to no here!
PasswordAuthentication no
#PermitEmptyPasswords no

# Change to yes to enable challenge-response passwords (beware issues with
# some PAM modules and threads)
ChallengeResponseAuthentication no
```

配置文件中上诉两项改为 `no`,之后重启`sshd`服务。

我们用一台不带信任key的机器尝试登录，那么会提示如下信息:
```bash
⋊> ~ ssh ubuntu@123.206.62.18
Permission denied (publickey).
```

# 解决自动断开

服务端设置环境变量`TMOUT=0`

客户端：`~/.ssh/config`文件中配置:

```bash
Host *
     ServerAliveInterval 60
```

# 相关链接

* http://www.cnblogs.com/kqdongnanf/p/6517836.html
* http://blog.csdn.net/iloveyin/article/details/11808377
