---
title: Ubuntu 常用软件
date: 2017-03-02 13:00:00
updated:
comments: true
tags:
- Linux
- Ubuntu
categories:
- OS
---

本文列举了 Ubuntu 常用软件。

<!--more-->

# 娱乐

## 网易云音乐

http://music.163.com/#/download

## mpv播放器

https://mpv.io/   

https://launchpad.net/~mc3man/+archive/ubuntu/mpv-tests

```bash
$ sudo add-apt-repository ppa:mc3man/mpv-tests
$ sudo apt update
$ sudo apt install mpv
```

# 工具

## Atom

## Chrome

## tilix 终端

原名 `terminix`

https://github.com/gnunn1/tilix  

```bash
$ sudo add-apt-repository ppa:webupd8team/terminix
$ sudo apt update
$ sudo apt install terminix
```

b站介绍视频
http://www.bilibili.com/video/av5879001/

## OBS录屏工具

```bash
$ sudo apt-get install ffmpeg
$ sudo add-apt-repository ppa:obsproject/obs-studio
$ sudo apt-get update && sudo apt-get install obs-studio
```

https://github.com/jp9000/obs-studio/wiki/Install-Instructions#linux

## Firefox Flash 插件

https://get.adobe.com/flashplayer/?loc=cn

```bash
$ sudo cp /home/khs1994/下载/libflashplayer.so /usr/lib/firefox-addons/plugins
```

[Adobe重新支持Linux平台：Flash Player 23开始测试](http://www.ithome.com/html/soft/255434.htm)

## 虚拟机

https://www.virtualbox.org/

双网卡 卡1桥接 卡2hostonly

## 搜狗拼音输入法

http://pinyin.sogou.com/linux/?r=pinyin

## PDF

https://code-industry.net/free-pdf-editor/

# 主题

不建议使用，使用默认就好  

```bash
#移动启动器到底部和恢复默认
$ gsettings set com.canonical.Unity.Launcher launcher-position Bottom  
$ gsettings set com.canonical.Unity.Launcher launcher-position Left
```
