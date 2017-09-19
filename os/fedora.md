---
title: Fedora 常用软件
date: 2017-02-01 13:00:00
updated:
comments: true
tags:
- Fedora
categories:
- OS
---

# 右键菜单在终端中打开

```bash
$ yum -y install nautilus-open-terminal
```

<!--more-->

# Tilix

原名 `terminix`

```bash
$ vi /etc/yum.repos.d/terminix.repo

[heikoada-terminix]  
name=Copr repo for terminix owned by heikoada  
baseurl=https://copr-be.cloud.fedoraproject.org/results/heikoada/terminix/fedora-$releasever-$basearch/  
skip_if_unavailable=True  
gpgcheck=1  
gpgkey=https://copr-be.cloud.fedoraproject.org/results/heikoada/terminix/pubkey.gpg  
enabled=1  
enabled_metadata=1

$ dnf update
$ dnf install tilix
```

# 字体

```
cp /usr/share/doc/freetype-infinality/infinality-settings-generic /etc/profile.d/infinality-settings-generic.sh ; \
cp /usr/share/doc/freetype-infinality/infinality-settings.sh /etc/X11/xinit/xinitrc.d/ ; \
chmod a+x /etc/X11/xinit/xinitrc.d/infinality-settings.sh
```
