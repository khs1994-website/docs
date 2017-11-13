---
title: 树莓派 3 64 位系统体验
date: 2017-09-02 13:00:00
updated:
comments: true
tags:
- Raspberry Pi3
categories:
- Raspberry Pi3
---

国内关于 `arm64位` 系统的资料较少，我只在知乎里找到一篇关于此的 [文章](https://zhuanlan.zhihu.com/p/27837299)。

GitHub: https://github.com/bamarni/pi64

<!--more-->

从 [pi64](https://github.com/bamarni/pi64) 下载镜像，和以前一样将镜像刷入 TF 卡，开机。注意第一次系统启动时间较长并会重启一次，等待一会再通过 `SSH` 登录。

登录帐号： `pi`，密码： `raspberry`

# 内核信息

```php
Linux raspberrypi 4.11.12-pi64+ #1 SMP PREEMPT Sun Aug 27 14:50:58 CEST 2017 aarch64 GNU/Linux
```

# 最新内核

GitHub: https://github.com/khs1994-pi/kernel

我参考作者编译内核步骤，使用 Travis CI 自动构建最新的内核，你可以在 [releses](https://github.com/khs1994-pi/kernel/releases) 下载 arm64 开头的内核，[替换](https://www.khs1994.com/raspberry-pi3/build-kernel.html) 即可。

# 配置

## 国内源

直接使用 Debian 9 源

```bash
deb http://mirrors.ustc.edu.cn/debian stretch main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian stretch main contrib non-free

deb http://mirrors.ustc.edu.cn/debian stretch-updates main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian stretch-updates main contrib non-free

deb http://mirrors.ustc.edu.cn/debian-security stretch/updates main contrib non-free
deb-src http://mirrors.ustc.edu.cn/debian-security stretch/updates main contrib non-free
```
