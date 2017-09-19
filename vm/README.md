---
title: 虚拟机常用配置
date: 2017-02-01 13:00:00
updated:
comments: true
tags:
- VirtualBox
categories:
- VM
---

# 压缩虚拟磁盘体积

## 碎片整理

```bash
$ sudo dd if=/dev/zero of=/EMPTY bs=1M
$ sudo rm -f /EMPTY
```

<!--more-->

## 压缩磁盘

关闭虚拟机，现在可以开始压缩虚拟硬盘了

```bash
$ VBoxManage modifyhd ****.vdi --compact
```

# 改UUID

```bash
$ VBoxManage internalcommands sethduuid ****.vid   #虚拟磁盘文件
```
