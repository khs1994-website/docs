---
title: Ubuntu 编译 树莓派3 内核
date: 2017-04-01 13:00:00
updated:
comments: true
tags:
- Raspberry Pi3
categories:
- Raspberry Pi3
---

编译环境 Ubuntu16.04 64 位。本次编译专门针对 `树莓派 3`，可能不适用于前代产品！

<!--more-->

# 准备

```bash
$ sudo apt install make make-guile
$ sudo apt install libncurses5-dev
# 32 位库，不安装会提示 编译器找不到文件
$ sudo apt install lib32ncurses5 lib32z1
```

## GitHub 下载三个仓库

https://github.com/raspberrypi

`firmware`:树莓派的交叉编译好的二进制内核、模块、库、bootloader  
`linux`:内核源码  
`tools`:编译内核和其他源码所需的工具——交叉编译器等  

然后将 `GCC` 目录加入环境变量

```bash
ARM-GCC-PATH=/home/khs1994/arm-gcc/arm-rpi-4.9.3-linux-gnueabihf/bin
```

# 编译

使用以下两种方法之一，在 `linux` 文件夹下生成 `.config`。

## 使用命令生成

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- bcm2709_defconfig
```

## 使用图形化界面进行配置

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- menuconfig
```

之后执行编译命令

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- -j4
```

# 复制kernel

```bash
$ cp linux/arch/arm/boot/Image kernel7.img
```

之后将 `kernel7.img` 复制到 TF 卡中。注意 `kernel.img` 是树莓派1用的，二代以后 cpu 是 `arm v7` 架构，内核名字被配置成了 `kernel7.img` ！

# 提取modules

上一步其实不但编译出来了内核的源码，一些模块文件也编译出来了，这里我们提取一下。新的 Kernel 要正确运行，还需要编译所需的 module，主要对应 `/lib` 目录下的内容。编译时，使用 `INSTALL_MOD_PATH` 参数指定目标路径。

```bash
$ mkdir modules

$ cd linux/

$ make modules_install ARCH=arm \
       CROSS_COMPILE=${ARM-GCC-PATH}/arm-linux-gnueabihf- \
       INSTALL_MOD_PATH=../modules modules
```

# 升级 kernel、Firmware、lib

* 将上边得到的 `kernel7.img` 复制到 TF 卡 `boot` 目录下

* 将 `firmware/boot/` 目录下以下文件复制到 TF 卡 `boot` 目录：`fbootcode.bin` `fixup.dat` `fixup_cd.dat` `start.elf`

* 将编译出来的 `modules/lib/modules` 拷入树莓派文件系统 `/lib` 下

# 相关链接

* [官方文档](https://www.raspberrypi.org/documentation/linux/kernel/)
* http://www.aptno1.com/YC/255.html
