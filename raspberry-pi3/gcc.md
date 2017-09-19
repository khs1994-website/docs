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

编译环境 Ubuntu16.04 64位

# 准备

```bash
$ sudo apt install make make-guile
$ sudo apt install libncurses5-dev
# 32 位库，不安装会提示 编译器找不到文件
$ sudo apt install lib32ncurses5 lib32z1
```

<!--more-->

## GitHub下载三个仓库

https://github.com/raspberrypi

`firmware`:树莓派的交叉编译好的二进制内核、模块、库、bootloader  
`linux`:内核源码  
`tools`:编译内核和其他源码所需的工具——交叉编译器等  

# 编译

## 生成 .config

~~第一种，复制原系统中的~~

~~在树莓派 /proc 下执行~~

~~`$ sudo modprobe configs`~~

~~得到`config.gz`，解压并改名`.config`复制到 `linux` 文件夹下。~~

## 第二种，使用命令生成

### 声明环境变量

```bash
ARM-GCC-PATH=/home/khs1994/arm-gcc/arm-rpi-4.9.3-linux-gnueabihf/bin
```

以下命令均在`linux`文件夹下执行

若复制树莓派中的`.config`文件,执行

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- oldconfig
```

### 使用命令生成

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- bcm2709_defconfig
```

### 使用图形化进行配置

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- menuconfig
```

## 编译

通过以上各种方法得到`.config`文件。

以下命令在`linux`文件夹下执行

```bash
$ make ARCH=arm CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- -j4
```

# 复制kernel

~~旧方法~~

~~`arch/arm/boot/zImage` 就是我们所编译获得的文件。`zImage` 是 `Compressed kernel image` 文件，要转换为 `kernel.img` 还需要进一步处理。~~

~~$ cd tools/mkimage
$ ./imagetool-uncompressed.py ../../linux/arch/arm/boot/zImage~~

## 树莓派3
```bash
$ cp linux/arch/arm/boot/Image kernel7.img
```
之后将`kernel7.img`复制到SD卡中，详细看后边说明
`kernel.img`是树莓派1用的，二代以后cpu是`arm v7`架构，内核名字被配置成了`kernel7.img` ！

# 提取modules

上一步其实不但编译出来了内核的源码，一些模块文件也编译出来了，这里我们提取一下。
新的Kernel要正确运行，还需要编译所需的module，主要对应`/lib`目录下的内容。编译时，使用“INSTALL_MOD_PATH”参数指定目标路径。
```bash
$ mkdir modules
$ cd linux/
$ make modules_install ARCH=arm \
  CROSS_COMPILE=$ARM-GCC-PATH/arm-linux-gnueabihf- \
  INSTALL_MOD_PATH=../modules modules
```
# 升级RPi的kernel、Firmware、lib

将SD卡拔下插在电脑上（使用读卡器）

## 升级内核

~~旧方法~~

~~将新编好的内核拷入SD卡，改名为：`kernel_new.img`，打开`boot`目录下找到`config.txt`文件，加入：`kernel=kernel_new.img`这一行~~

### 树莓派3

上边得到的 `kernel7.img` 复制到SD卡`boot`目录下

## 升级boot

将`firmware/boot/`目录下以下文件拷入SD卡`boot`目录：`fbootcode.bin` `fixup.dat` `fixup_cd.dat` `start.elf`

## 更新vc库及内核modules

编译出来的`modules/lib/modules`拷入树莓派文件系统`/lib`下

# 相关链接

* 官方文档：https://www.raspberrypi.org/documentation/linux/kernel/
* http://www.aptno1.com/YC/255.html
