---
title: Virtualbox 安装 Alpine Linux
date: 2017-10-02 13:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
---

本文介绍使用 Virtualbox 安装 Alpine Linux。

<!--more-->

# 安装

下载 [iSO](https://www.alpinelinux.org/downloads/)，挂载，配置网络，启动。

用户名 `root`，默认密码为空。

```bash
$ setup-alpine
```

然后交互式输入信息，完成安装。

注意一定要设置 DNS 服务器，否则会遇到网络问题而安装失败。

输入 `$ poweroff` 关机，移除安装 ISO 光盘。

# SSH

开机之后在虚拟机窗口登录，修改 SSH 配置之后，使用 SSH 来登录即可开始使用。

`/etc/ssh/sshd_config`

```bash
PermitRootLogin yes
```

# More Information

* http://blog.csdn.net/freewebsys/article/details/53638227
