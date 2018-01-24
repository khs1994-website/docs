---
title: 国内使用 minikube
date: 2017-12-01 12:00:00
updated:
comments: true
tags:
- K8s
- Minikube
categories:
- K8s
- Minikube
---

OS：macOS

GitHub：https://github.com/khs1994-docker/minikube

GitHub: https://github.com/kubernetes/minikube

<!--more-->

# 修订记录

* 2018-01-15：请在之前看过我文章的务必按照本文重新安装配置 minikube

* 2018-01-15：由于阿里云的 localkube 出现问题（已反馈给相关人员），暂时只能使用我编译的 localkube。

# 镜像列表

```bash
gcr.io/google_containers/kubernetes-dashboard-amd64    v1.8.0              55dbc28356f2        6 weeks ago         119MB
gcr.io/k8s-minikube/storage-provisioner                v1.8.1              4689081edb10        2 months ago        80.8MB
gcr.io/google_containers/k8s-dns-sidecar-amd64         1.14.5              fed89e8b4248        3 months ago        41.8MB
gcr.io/google_containers/k8s-dns-kube-dns-amd64        1.14.5              512cd7425a73        3 months ago        49.4MB
gcr.io/google_containers/k8s-dns-dnsmasq-nanny-amd64   1.14.5              459944ce8cc4        3 months ago        41.4MB
gcr.io/google-containers/kube-addon-manager            v6.4-beta.2         0a951668696f        7 months ago        79.2MB
gcr.io/google_containers/pause-amd64                   3.0                 99e59f495ffa        20 months ago       747kB
```

本人也是初学 `minikube`，本文基于 `minikube` 0.24.1 版本。

如果我们直接使用从 https://github.com/kubernetes/minikube 下载的 `minikube` 你可能会发现根本不能运行成功。

这是因为它要从 `gcr.io` 拉取镜像，而国内网络问题导致镜像下载不了，当然也就不能启动了。

知道为什么成功不了，那我们就替换源码中的国外镜像为国内镜像源（阿里云）。

具体要变更哪些文件请看 [GitHub](https://github.com/khs1994-docker/minikube)

我已经把变更过的文件上传到了 [GitHub](https://github.com/khs1994-docker/minikube)，本文以这个 git 仓库为源码，重新编译 `minikube`


# 安装 `kubectl`

>注意，由于网络问题，从官网下载极有可能下载失败。你可以使用浏览器在国内镜像下载之后移入 `PATH` https://github.com/khs1994-docker/kubectl-cn-mirror

使用 `minikube` 必须先安装好 `k8s` 命令行工具 `kubectl`。

## macOS

`Docker for Mac` 17.12+ 启用 `k8s` 之后会在 `/usr/local/bin` 放入 `kubectl`，所以你无需安装。

`Docker for Mac` 自带的 `k8s` 会与 `minikube` 冲突，请以下命令进行切换。

```bash
$ kubectl config get-contexts

CURRENT   NAME                 CLUSTER                      AUTHINFO             NAMESPACE
          docker-for-desktop   docker-for-desktop-cluster   docker-for-desktop
*         minikube             minikube                     minikube

# 切换到 docker 自带的 k8s

$ kubectl config use-context docker-for-desktop


# 切换到 minikube

$ kubectl config use-context minikube
```

如果你没启用 `k8s` 那么请使用下面的方法。

```bash
$ brew install kubectl
```

## curl

或者使用 `curl` 下载。

### bash

```bash
# OS X
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl

# Linux
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

# Windows
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/windows/amd64/kubectl.exe
```

### fish

```
# OS X
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/darwin/amd64/kubectl

# Linux
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

# Windows
$ curl -LO https://storage.googleapis.com/kubernetes-release/release/(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/windows/amd64/kubectl.exe
```

# 重新安装 `minikube` 国内版

>注意：国内从 GitHub 下载文件可能较慢，你可以在国内镜像下载之后移入 `PATH` https://code.aliyun.com/khs1994-docker/minikube/tree/v1.8.0

你可以选择 `编译安装` 或者 `下载安装`。为了避免混乱，编译安装的方法，放到了文章最后。

## 直接下载安装

你可以根据你的操作系统，下载对应的二进制文件。你也可以在命令行使用 curl 下载。

https://github.com/khs1994-docker/minikube/releases

### bash

```bash
$ curl -LO https://github.com/khs1994-docker/minikube/releases/download/v0.24.1/minikube-`uname -s`-`uname -m`

$ chmod +x minikube-`uname -s`-`uname -m`

$ sudo cp minikube-`uname -s`-`uname -m` /usr/local/bin/minikube
```

### fish

```
$ curl -LO https://github.com/khs1994-docker/minikube/releases/download/v0.24.1/minikube-(uname -s)-(uname -m)

$ chmod +x minikube-(uname -s)-(uname -m)

$ sudo cp minikube-(uname -s)-(uname -m) /usr/local/bin/minikube
```

# 虚拟机驱动

https://github.com/kubernetes/minikube/blob/master/docs/drivers.md

`macOS` 上默认的驱动是 `VirtualBox`，但是我们这里选择 `hyperkit`。

>注意，你可能看到一些旧教程使用了 `xhyve`，如果你使用这个驱动，启动时 `minikube` 会提示你该驱动已经废弃。

```
WARNING: The xhyve driver is now deprecated and support for it will be removed in a future release.
Please consider switching to the hyperkit driver, which is intended to replace the xhyve driver.
```

```bash
$ curl -LO https://github.com/kubernetes/minikube/releases/download/v0.24.1/docker-machine-driver-hyperkit

$ chmod +x docker-machine-driver-hyperkit

$ sudo mv docker-machine-driver-hyperkit /usr/local/bin/

$ sudo chown root:wheel /usr/local/bin/docker-machine-driver-hyperkit

$ sudo chmod u+s /usr/local/bin/docker-machine-driver-hyperkit
```

这样我们就安装好了驱动。

# 启动

```bash
$ minikube start --vm-driver=hyperkit --alsologtostderr --v 10
```

选择一种驱动之后，不要再改变，否则可能会启动失败。

# 错误排查

若启动时出现错误，请执行以下命令删除本地集群，再重新执行启动命令。

```bash
$ minikube delete
```

如果仍然出现错误请删除 `~/.minikube`，再重新执行启动命令。

# 使用方法

## 打开控制面板

```bash
$ minikube dashboard

Opening kubernetes dashboard in default browser...
```

之后会自动打开浏览器页面。

## 查看 IP

```bash
$ minikube ip

192.168.64.12
```

## 查看状态

```bash
$ minikube status

minikube: Running
cluster: Running
kubectl: Correctly Configured: pointing to minikube-vm at 192.168.64.12
```

## 查看集群

```bash
$ kubectl cluster-info

Kubernetes master is running at https://192.168.64.12:8443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

更多方法请查看后续文章。

# 关闭

```bash
$ minikube stop
```

# 附录

## Windows 启动 minikube

自行在上面提到的 [GitHub](https://github.com/khs1994-docker/minikube/releases/download/v0.24.1/minikube) 或 [国内镜像](https://code.aliyun.com/khs1994-docker/minikube/tree/v1.8.0) 下载好 `kubectl.exe` `minikube.exe`,并加入 `PATH`

配置 `Hyper-V`，具体图解请查看：https://yq.aliyun.com/articles/221687

```bash
$ minikube.exe start --registry-mirror=https://registry.docker-cn.com --vm-driver="hyperv" --memory=4096 --hyperv-virtual-switch="minikube"
```

## 编译安装 minikube

>注意：编译安装适用于对 `Go` 有一定了解的人。

### 安装 `Go`

```bash
$ brew install go
```

设置 `Go` 相关环境变量，自行修改为你自己的路径。

```bash
GOROOT="/usr/local/opt/go/libexec"
GOPATH="/Users/khs1994/go"
```

### 编译安装

```bash
$ git clone -b 0.24.1 --depth=1 git@github.com:khs1994-docker/minikube.git $GOPATH/src/k8s.io/minikube

$ cd $GOPATH/src/k8s.io/minikube

$ make

$ sudo cp out/minikube /usr/local/bin
```

# More Information

* https://github.com/kubernetes/minikube

* https://github.com/AliyunContainerService/minikube

* https://yq.aliyun.com/articles/221687

* https://github.com/oucb/minikube

* http://wiselyman.iteye.com/blog/2381738
