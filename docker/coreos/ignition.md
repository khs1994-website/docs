---
title: CoreOS 配置工具 Ignition 官方示例
date: 2016-09-02 14:00:00
updated:
comments: true
tags:
- CoreOS
- Ignition
categories:
- CoreOS
- Ignition
---

CoreOS 配置工具已由 [`Ignition`](https://github.com/coreos/ignition) 代替 [`cloud-config`](https://github.com/coreos/coreos-cloudinit)。

GitHub：https://github.com/coreos/ignition

<!--more-->

使用 `Ignition` 需要两步：

* 第一步编写 `Container Linux Config` ( `yaml` 格式 )

* 第二步使用 [`container-linux-config-transpiler`](https://github.com/coreos/container-linux-config-transpiler/releases) 将 `Container Linux Config` 转化为 `Ignition Config` (`json` 格式)

```bash
$ ct-v0.5.0-x86_64-apple-darwin -in-file ignition.yaml  > ignition.json
```

# `container-linux-config-transpiler` 安装方法

在 https://github.com/coreos/container-linux-config-transpiler/releases 下载二进制文件移入 `PATH`，并赋予可执行权限之后即可使用。

## brew

```bash
$ brew install coreos-ct

$ ct -help
```

官方文档：https://coreos.com/os/docs/latest/overview-of-ct.html

# 常用配置举例

## etcd

```yaml
etcd:
  name:                        coreos3
  discovery: https://discovery.etcd.io/249ea9815631abc753fe4a4743f147d2
  advertise_client_urls:       http://192.168.57.102:2379
  initial_advertise_peer_urls: http://192.168.57.102:2380
  listen_client_urls:          http://192.168.57.102:2379,http://0.0.0.0:4001
  listen_peer_urls:            http://0.0.0.0:2380
```

## 网络配置

通过与网络接口名称（ `enp0s3` 等）匹配来设置静态或动态 IP 地址

```yaml
networkd:
   units:
     - name: 10-static.network
       contents: |
         [Match]
         Name=enp0s3

         [Network]
         Address=192.168.57.102/24
     - name: 20-dhcp.network
       contents: |
         [Match]
         Name=enp0s8

         [Network]
         DHCP=yes
```

## 用户

```yaml
passwd:
  users:
    - name: core
      ssh_authorized_keys:
        - ssh-rsa SSH_PUB
      groups:
        - wheel
        - sudo
        - docker
```

## systemd unit

```yaml
systemd:
  units:
    - name: settimezone.service
      enable: true
      contents: |
        [Unit]
        Description=Set the time zone

        [Service]
        ExecStart=/usr/bin/timedatectl set-timezone  PRC
        RemainAfterExit=yes
        Type=oneshot
```

## 文件

```yaml
storage:
  files:
    - filesystem: "root"
      path:       "/etc/hostname"
      mode:       0644
      contents:
        inline: coreos3
    - filesystem: "root"
      path:       "/etc/resolv.conf"
      mode:       0644
      contents:
        inline: |
          nameserver 114.114.114.114
```

# 示例文件

https://github.com/khs1994-docker/lnmp-k8s/blob/master/coreos/disk/example/ignition-1.example.yaml

# 相关链接

* https://coreos.com/os/docs/latest/migrating-to-clcs.html

* https://coreos.com/blog/introducing-ignition.html
