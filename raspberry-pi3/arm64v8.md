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

国内资料关于 `64位` 系统的资料较少,我只在知乎里找到一篇关于此的 [文章](https://zhuanlan.zhihu.com/p/27837299)。

<!--more-->

从 [pi64](https://github.com/bamarni/pi64) 下载镜像，和以前一样将镜像刷入 TF 卡，开机。此处注意第一次系统启动时间较长并会重启一次，等待一会再通过 `SSH` 登录。

登录帐号： `pi`，密码： `raspberry`

# 内核信息

```php
Linux raspberrypi 4.11.12-pi64+ #1 SMP PREEMPT Sun Aug 27 14:50:58 CEST 2017 aarch64 GNU/Linux
```

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
