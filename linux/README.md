---
title: Linux 常见问题解决方法
date: 2017-07-07 12:00:00
updated:
comments: true
tags:
- Linux
categories:
- Linux
---

本文列举了 Linux 常见问题及其解决方法。

<!--more-->

# 网页搜索软件包

* https://pkgs.org/ 包含各种系统的软件包

* Alpine https://pkgs.alpinelinux.org/packages

* Debian https://packages.debian.org/zh-cn/

* Ubuntu https://packages.ubuntu.com/zh-cn/

# 软件源

* https://pkgs.org/ 包含各种系统的软件包

## RHEL 第三方源

* REMI http://rpms.remirepo.net/ http://rpms.remirepo.net/enterprise/remi-release-7.rpm

* EPEL https://fedoraproject.org/wiki/EPEL/zh-cn http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

* RPM Fusion https://rpmfusion.org/ http://download1.rpmfusion.org/free/el/updates/7/x86_64/r/rpmfusion-free-release-7-1.noarch.rpm

* IUS https://ius.io/ https://centos7.iuscommunity.org/ius-release.rpm

# 设置环境变量

* export 临时

* `/etc/profile`

* `~/.bashrc`

* `~/.bash_profile`

# sudo

## 找不到命令

编辑 `/etc/sudoers` 文件。

```bash
Defaults  secure_path=...
# 在后边加上PATH
```

## 脚本输入密码

```bash
echo "password" | sudo -S cmd
```

## sudo 重定向到文件

```bash
$ echo 1 | sudo tee 1.txt
```

# 相关链接

* http://blog.csdn.net/wangbole/article/details/17579463
