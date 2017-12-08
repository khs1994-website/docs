---
title: macOS 使用简介
date: 2017-01-01 13:00:00
updated:
comments: true
tags:
- macOS
categories:
- OS
- macOS
---

本文列举了 macOS 配置，常用软件。

<!--more-->

# 安装镜像制作

```bash
$ sudo 拖入安装包...app/Contents/Resources/createinstallmedia \
    --volume 拖入U盘 --applicationpath 拖入安装包...app \
    --nointeraction
```

# 安全与隐私

没有`允许任何来源`选项的解决办法

```bash
$ sudo spctl --master-disable
```

# ssh 免密码登录实现

```bash
$ brew install ssh-copy-id
$ ssh-keygen
$ ssh root@192.168.1.101
```

# mpv 播放器中文乱码

```bash
$ vi ~/.config/mpv/mpv.conf

# Subtitles
sub-auto=fuzzy
sub-text-font-size=48
sub-codepage=utf8:gb18030
```

# 常用软件

## 常用

搜狗输入法  
火狐浏览器  
网易云音乐  
Chrome  
迅雷  
VirtualBox

## 开发

atom  
JetBrainsToolbox  
Android Studio  
jdk  
iterm2  
Etcher
