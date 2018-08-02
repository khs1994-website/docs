---
title: Fedora 常用软件
date: 2017-02-08 13:00:00
updated:
comments: true
tags:
- Fedora
categories:
- Linux
---

本文列举了 Fedora 常用软件。

<!--more-->

# 右键菜单在终端中打开

```bash
$ yum -y install nautilus-open-terminal
```

# Tilix

* https://github.com/gnunn1/tilix

```bash
$ dnf install tilix
```

# 字体

```bash
$ cp /usr/share/doc/freetype-infinality/infinality-settings-generic /etc/profile.d/infinality-settings-generic.sh ; \
$ cp /usr/share/doc/freetype-infinality/infinality-settings.sh /etc/X11/xinit/xinitrc.d/ ; \
$ chmod a+x /etc/X11/xinit/xinitrc.d/infinality-settings.sh
```
