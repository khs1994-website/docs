---
title: CoreOS 配置工具 Ignition 官方示例
date: 2016-09-02 14:00:00
updated:
comments: true
tags:
- Docker
- CoreOS
- Ignition
categories:
- Docker
- CoreOS
- Ignition
---

CoreOS 配置工具 已由 `Ignition` 代替 `cloud-config`。

GitHub：https://github.com/coreos/ignition

<!--more-->

使用 Ignition 需要两步：

* 第一步编写 `Container Linux Config` ( yaml 格式 )
* 第二步使用 [`container-linux-config-transpiler`](https://github.com/khs1994/container-linux-config-transpiler) 将 `Container Linux Config` 转化为 `Ignition Config` (json 格式)
* `container-linux-config-transpiler` 安装方法请查看该项目 GitHub

```bash
$ ct-v0.4.2-x86_64-apple-darwin -in-file ignition.yaml  > ignition.json
```

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
        - ssh-rsa AAAAB3NzaC1yc...
      create:
        groups:
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

https://github.com/khs1994-website/docker-coreos/blob/master/ignition.yaml

# 相关链接

* https://coreos.com/os/docs/latest/migrating-to-clcs.html
* https://coreos.com/blog/introducing-ignition.html
