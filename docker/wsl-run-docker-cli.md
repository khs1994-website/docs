---
title: 使用 WSL 操控 Docker for Windows
date: 2017-12-27 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

当然，理论上可以操控任意的远程 Docker Daemon。

>注意：不要误认为是在 WSL 运行 Docker,这是完全没有可能的。

<!--more-->

# Docker for Windows 设置

设置中打开 `2375` 端口，这里不再赘述。

# 下载文件

注意替换为最新版本号

国内地址

```bash
$ curl -SL http://mirrors.ustc.edu.cn/docker-ce/linux/static/test/x86_64/docker-17.12.0-ce-rc4.tgz | tar -zxvf -
```

官方地址

```bash
$ curl -SL https://download.docker.com/linux/static/test/x86_64/docker-17.12.0-ce-rc4.tgz | tar -zxvf -
```

# 移入 PATH

```bash
$ sudo cp docker/docker /usr/local/bin/docker

$ rm -rf docker

$ docker --version
```

# 命令行补全

```bash
$ sudo curl -L https://raw.githubusercontent.com/docker/docker-ce/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker
```

# 设置环境变量

编辑 `~/.bash_profile`

```bash
export DOCKER_HOST="tcp://127.0.0.1:2375"
```

退出终端重新登录

```bash
$ docker info
```

# 高级玩法

完全在 WSL 中操控 Docker

```bash
$ ln -sf /mnt/c /C

$ cd /C

$ docker run -it --rm -v $PWD:/C busybox sh

$ cd /C

$ ls
```

原理 Windows Docker 服务端将 C 盘挂载到了 /C

所以我们在 WSL 中也将 C 盘软链接到 /C,这样在 WSL /C 中使用 Docker 就可以使用 $PWD 变量挂载本地文件了。
