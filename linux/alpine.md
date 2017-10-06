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

```bash
$ setup-alpine
```

# SSH

`/etc/ssh/sshd_config`

```bash
PermitRootLogin yes
```

# More Information

* http://blog.csdn.net/freewebsys/article/details/53638227
