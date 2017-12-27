---
title: 树莓派 3 内核交叉编译详解
date: 2017-02-10 13:00:00
comments: true
tags:
- Raspberry Pi3
categories:
- Raspberry Pi3
---

GitHub: https://github.com/khs1994-pi/kernel

编译环境 Ubuntu 17.10 server 64 位(使用 VirtuaiBox 虚拟机)，本次编译专门针对 `树莓派 3`，可能不适用于前代产品！

<!--more-->

目录说明：本次编译目录位于 `~/pi`，请提前创建好该文件夹。

`arm64` 来源：https://github.com/bamarni/pi64

# 准备

## 安装包

### arm32v7 （官方系统）

```bash
$ sudo apt install \
       make \
       libncurses5-dev \
       gcc-arm-linux-gnueabihf \
       g++-arm-linux-gnueabihf

# 32 位库，不安装会提示 gcc 编译器提示 找不到文件

$ sudo apt install \
       lib32ncurses5 \
       lib32z1
```

### arm64v8

```bash
$ sudo apt-get update \
        && sudo apt-get -y install \
        bc \
        build-essential \
        cmake \
        device-tree-compiler \
        gcc-aarch64-linux-gnu \
        g++-aarch64-linux-gnu \
        git \
        unzip \
        qemu-user-static \
        multistrap \
        zip \
        wget \
        dosfstools \
        kpartx
```

## 克隆资源

https://github.com/raspberrypi

在 `~/pi` 目录执行以下命令

### firmware

> 树莓派的交叉编译好的二进制内核、模块、库、bootloader

```bash
$ git clone --depth=1 git@github.com:raspberrypi/firmware.git
```

### linux

> 内核源码

```bash
$ git clone -b rpi-4.13.y --depth=1 git@github.com:raspberrypi/linux.git linux-src
```

# 编译

## 准备 `.config`

在 `linux-src` 目录执行以下命令。

### arm32v7

使用以下两种方法之一，在 `linux-src` 文件夹下生成 `.config`。

#### 使用命令生成

```bash
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- bcm2709_defconfig
```

#### 使用图形化界面进行配置

有特殊需求再自行配置，一般使用第一种方法即可。

```bash
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- menuconfig
```

### arm64v8

```bash
$ wget https://raw.githubusercontent.com/bamarni/pi64/master/make/kernel-config.txt

$ mv kernel-config.txt .config

$ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
```

## 编译

### arm32v7

```bash
$ make ARCH=arm -j $(nproc) CROSS_COMPILE=arm-linux-gnueabihf-
```

### arm64v8

```bash
$ make ARCH=arm64 -j $(nproc) CROSS_COMPILE=aarch64-linux-gnu-
```

# 复制 kernel

在 `linux-src` 目录执行以下命令。

## arm32v7

```bash
$ mkdir -p ../linux/boot

$ cp arch/arm/boot/Image ../linux/boot/kernel7.img
```

>注意: `kernel.img` 是树莓派 1 用的，二代以后 cpu 是 `arm v7` 架构，内核名字被配置成了 `kernel7.img` ！

## arm64v8

```bash
$ mkdir -p ../linux/boot

$ cp arch/arm64/boot/Image ../linux/boot/kernel8.img
```

# 提取 modules

上一步不但编译出来了内核的源码，一些模块文件也编译出来了，这里我们提取一下（新的 Kernel 要正确运行，还需要编译所需的 `modules`，主要对应 `/lib` 目录下的内容）。

编译时，使用 `INSTALL_MOD_PATH` 参数指定目标路径。

在 `linux-src` 目录执行以下命令。

## arm32v7

```bash
$ make ARCH=arm \
       CROSS_COMPILE=arm-linux-gnueabihf- \
       INSTALL_MOD_PATH=../linux modules_install
```

## arm64v8

```bash
$ make ARCH=arm64 \
       CROSS_COMPILE=aarch64-linux-gnu- \
       INSTALL_MOD_PATH=../linux modules_install
```

# 提取 firmware

在 `~/pi` 目录执行以下命令。

```bash
$ cd firmware/boot

$ rm -rf *.dtb *.img

$ cp -a * ../../linux/boot
```

# 打包

由于编译环境位于虚拟机，把文件压缩之后，本机使用 `scp` 将压缩包拿回来。

```bash
$ tar -zcvf linux.tar.gz linux
```

# 将文件移动到 TF 卡

在本机将 `linux.tar.gz` 解压缩。

将 `linux/boot` 目录文件复制到 TF 卡 `boot` 目录，树莓派开机。

启动之后将 `linux.tar.gz` 通过 `scp` 上传到树莓派中。

```bash
$ tar -zxvf linux.tar.gz

$ cd linux

$ sudo rm -rf /lib/firmware

$ sudo cp -a lib/modules/* /lib/modules/
```

>注意: 这一步不可以省略，如果不复制 `modules` 一些软件比如 `Docker` 会出错。

# 相关链接

* [官方文档](https://www.raspberrypi.org/documentation/linux/kernel/)

* https://github.com/bamarni/pi64

* http://www.aptno1.com/YC/255.html
