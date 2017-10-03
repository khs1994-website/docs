---
title: Fedora 常用软件
date: 2017-03-01 13:00:00
updated:
comments: true
tags:
- Fedora
categories:
- OS
---

本文列举了 Fedora 常用软件。

<!--more-->

# 右键菜单在终端中打开

```bash
$ yum -y install nautilus-open-terminal
```

# Tilix

原名 `terminix`

新建 `/etc/yum.repos.d/terminix.repo` 文件

```yaml
[heikoada-terminix]  
name=Copr repo for terminix owned by heikoada  
baseurl=https://copr-be.cloud.fedoraproject.org/results/heikoada/terminix/fedora-$releasever-$basearch/  
skip_if_unavailable=True  
gpgcheck=1  
gpgkey=https://copr-be.cloud.fedoraproject.org/results/heikoada/terminix/pubkey.gpg  
enabled=1  
enabled_metadata=1
```

之后执行以下命令进行安装

```bash
$ dnf update
$ dnf install tilix
```

# 字体

```bash
$ cp /usr/share/doc/freetype-infinality/infinality-settings-generic /etc/profile.d/infinality-settings-generic.sh ; \
$ cp /usr/share/doc/freetype-infinality/infinality-settings.sh /etc/X11/xinit/xinitrc.d/ ; \
$ chmod a+x /etc/X11/xinit/xinitrc.d/infinality-settings.sh
```
