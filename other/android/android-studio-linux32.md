---
title: AndroidStudio Linux 安装错误的解决方法
date: 2016-01-01 12:00:00.00
tags:
- Android
categories:
- Other
- Android
---

Android Studio 在 Linux 64 位安装 `SDK` 会提示错误。

> This is important If you have 64-bitsystems, you will need to install some 32bit packages, because Android SDK is 32bit.

<!-- more -->

# Fedora

```bash
$ dnf install glibc.i686 glibc-devel.i686 \
   libstdc++.i686 zlib-devel.i686 ncurses-devel.i686 \
   libX11-devel.i686  libXrender.i686 libXrandr.i686
```

# Ubuntu

```bash
$ sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1
```

# 相关链接

- https://fedoraproject.org/wiki/HOWTO_Setup_Android_Development#Install_Android_SDK
- http://tools.android.com/tech-docs/linux-32-bit-libraries
- http://stackoverflow.com/questions/29112107/how-to-solve-unable-to-run-mksdcard-sdk-tool-when-installing-android-studio-on
