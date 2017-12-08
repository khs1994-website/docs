---
title: CentOS7 最小化安装初始化配置
date: 2016-08-05 13:00:00
updated:
comments: true
tags:
- Linux
- CentOS
categories:
- Linux
---

本文简要介绍了 `CentOS 7` 常用配置。

<!--more-->

# yum 源配置

## 阿里云开源镜像

http://mirrors.aliyun.com

```bash
$ mv /etc/yum.repos.d/CentOS-Base.repo \        
    /etc/yum.repos.d/CentOS-Base.repo.backup
$ wget -O /etc/yum.repos.d/CentOS-Base.repo \
    http://mirrors.aliyun.com/repo/Centos-7.repo
```

## EPEL

```bash
$ wget -O /etc/yum.repos.d/epel.repo \
    http://mirrors.aliyun.com/repo/epel-7.repo
```

# 网络设置

## 开机网络连接

编辑 `/etc/sysconfig/network-scripts/ifcfg-enp0s8`

```bash     
ONBOOT=yes
```

## 静态 IP

```bash
BOOTPROTO=static
...
IPADDR=192.168.56.121
NETMASK=225.225.225.0
NAME=enp0s8
DEVICE=enp0s8
ONBOOT=yes
```

## 路由

编辑 `/etc/sysconfig/network-scripts/route-enp0s8` 文件

```bash
192.168.56.0/24 via 192.168.56.1 dev enp0s8

# 虚拟机采用双网卡，网卡1桥接模式；网卡2 host-only 模式此处添加网卡2 ip段 192.168.56.0、24 静态路由
```

### 显示路由表

```bash
$ ip route show|column -t
```

### 添加静态路由

```bash
$ ip route add 10.15.150.0/24 via 192.168.150.253 dev enp0s3
```

### 删除静态路由

```bash
$ ip route del 10.15.150.0/24

$ nmcli dev disconnect enp0s3 && nmcli dev connect enp0s3
```

>存在多个网卡时，默认路由似乎是随机经由某个网卡设备。检查了所有连接配置文件后发现，第一网卡的默认连接配置文件 ifcfg-eth0 设置了GATEWAY0（此设置会覆盖/etc/sysconfig/network 定义的全局默认网关），第二网卡的连接配置文件 ifcfg-eth1 使用的是dhcp，会在启动时也分配默认网关，两个默认网关让计算机糊涂了。这是在测试系统里经常发生的现象，生产系统一般不会让网卡用dhcp，或者即使是用了也会仔细分配默认网关防止冲突。

## DNS（重要）

编辑 `/etc/NetworkManager/NetworkManager.conf`

``` bash
[main]
plugins=ifcfg-rh
#增加dns=none
dns=none
```

编辑 `/etc/resolv.conf` 文件

```bash
nameserver 114.114.114.114
```

重启网络

```bash
$ systemctl restart NetworkManager.service
```

# 常用软件包

```bash
$ yum install zip unzip wget  \
    gcc gcc-c++ gdb git openssl-devel \
    bash-completion tree vim
```

# 安全配置

## 关闭防火墙、selinux

```bash
$ systemctl status firewalld
```
### 停止 firewall

```bash
$ systemctl stop firewalld.service
```

### 禁止 firewall 开机启动

```bash
$ systemctl disable firewalld.service
$ /usr/sbin/sestatus -v
```

## 关闭 SELINUX

编辑 `/etc/selinux/config` 文件。

```bash
#SELINUX=enforcing #注释掉
#SELINUXTYPE=targeted #注释掉
#增加
SELINUX=disabled
```

执行以下命令生效，或者重启电脑

```bash
$ setenforce 0
```

# 删除旧内核

```bash
$ rpm -qa | grep kernel
$ yum remove kernel-3.10.0-514.10.2.el7.x86_64
```

# 常用命令

## 查看硬盘 UUID

```bash
$ blkid
```

# 相关链接

* http://www.centoscn.com/CentOS/Intermediate/2015/1211/6508.html
