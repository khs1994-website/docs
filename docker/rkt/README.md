---
title: CoreOS 容器 Rkt 简单介绍
date: 2017-10-24 14:00:00
updated:
comments: true
tags:
- Rkt
categories:
- Rkt
---

由于 Docker 已经成为事实上的容器老大，这里暂且将 rkt 内容放入 docker 文件夹。哈哈

官方网站：https://coreos.com/rkt/

官方文档：https://coreos.com/rkt/docs/latest/

GitHub：https://github.com/rkt/rkt/

<!--more-->

这里使用 `CoreOS` 来学习 `Rkt`，其他 Linux 系统上 `Rkt` 的安装方法很简单，这里不再赘述。

`Rkt` 目前只支持 Linux 系统。

先看一下命令列表

```
NAME:
	rkt - rkt, the application container runner

USAGE:
	rkt [command]

VERSION:
	1.29.0

COMMANDS:
	api-service		      Run API service (experimental)
	cat-manifest		    Inspect and print the pod manifest
	completion		      Output shell completion code for the specified shell
	config			        Print configuration for each stage in JSON format
	enter			          Enter the namespaces of an app within a rkt pod
	export			        Export an app from an exited pod to an ACI file
	fetch			          Fetch image(s) and store them in the local store
	gc			            Garbage collect rkt pods no longer in use
	image cat-manifest	Inspect and print the image manifest
	image export		    Export a stored image to an ACI file
	image extract		    Extract a stored image to a directory
	image gc		        Garbage collect local store
	image list		      List images in the local store
	image render		    Render a stored image to a directory with all its dependencies
	image rm		        Remove one or more images with the given IDs or image names from the local store
	image verify		    Verify one or more rendered images in the local store
	list			          List pods
	metadata-service	  Run metadata service
	prepare			        Prepare to run image(s) in a pod in rkt
	rm			            Remove all files and resources associated with an exited pod
	run			            Run image(s) in a pod in rkt
	run-prepared		    Run a prepared application pod in rkt
	status			        Check the status of a rkt pod
	stop			          Stop a pod
	trust			          Trust a key for image verification
	version			        Print the version and exit
	help			          Help about any command

DESCRIPTION:
	A CLI for running app containers on Linux.

	To get the help on any specific command, run "rkt help command".

OPTIONS:
      --debug[=false]			print out more debug information to stderr
      --dir=/var/lib/rkt		rkt data directory
      --insecure-options=none		comma-separated list of security features to disable. Allowed values: "none", "image", "tls", "ondisk", "http", "pubkey", "capabilities", "paths", "seccomp", "all-fetch", "all-run", "all"
      --local-config=/etc/rkt		`local` configuration directory
      --system-config=/usr/lib/rkt	system configuration directory
      --trust-keys-from-https[=false]	automatically trust gpg keys fetched from https
      --user-config=			user configuration directory
```

rkt 使用的是 `pod` 的概念，与 k8s 联系紧密，可能对应 docker 中的容器概念。

# 下载 Docker 镜像

`rkt` 比 `docker` 多了一个验证的功能，下载 Docker 镜像必须加上不要验证的参数。

```bash
$ rkt fetch --insecure-options=image docker://ubuntu

# fetch 与 git 中的 fetch 含义差不多，对应 docker pull
```

# 查看镜像

```bash
$ rkt image list

ID			            NAME						                            SIZE	IMPORT TIME	  LAST USED
sha512-bea6e5210d47	registry-1.docker.io/library/ubuntu:latest	98MiB	1 minute ago	1 minute ago

# 与 docker 中的命令一致，可能遵循了某种标准。哈哈，别和我说 docker images 那是旧命令了，好吧！
```

# 运行一个 pod

```bash
$ sudo rkt --insecure-options=image \
    run \
    --interactive \
    docker://ubuntu

# docker run XXX

$ rkt run --help
```

`--interactive` 与 docker `-it` 对应

`--volume data,kind=host,source=/srv/data,readOnly=false` 挂载文件

`--volume data,kind=empty,readOnly=false`

`--mount volume=VOL,target=PATH`

```bash
$ sudo rkt --insecure-options=image \
    run \
    --interactive \
    --volume data,kind=host,source=/srv/data \
    --mount volume=data,target=/srv/data \
    docker://ubuntu \
    --exec /bin/sh
```

`--port=80-tcp:80` 暴露端口

```bash
$ sudo rkt --insecure-options=image \
    run \
    docker://nginx:alpine \
    --port=80-tcp:80
```

`--set-env=KEY=VALUE` 设置 pod 环境变量

`--environment=foo=bar` 设置 pod 环境变量

`--exec /bin/sh`

`--name=name`

`--net=host | default | none`

`--net="net1:IP=1.2.3.4"`

## 后台运行

### systemd-run

https://coreos.com/rkt/docs/latest/using-rkt-with-systemd.html#systemd-run

```bash
$ sudo systemd-run \
    --slice=machine \
		rkt \
		--insecure-options=image \
		run \
		--net=host \
		docker://nginx:alpine
```

### daemon

http://www.libslack.org/daemon/

# 查看 pods 信息

```bash
$ rkt list
UUID		  APP	  IMAGE NAME					                      STATE		  CREATED			    STARTED		    NETWORKS
ea4b9fe5	nginx	registry-1.docker.io/library/nginx:alpine	running		9 seconds ago		9 seconds ago	default:ip4=172.16.28.5

# docker ps -a
```

# 进入 pod

```bash
$ sudo rkt enter ea sh

# docker exec
```

# 停止 pod

```bash
$ sudo rkt stop ea

# docker stop
```

# 删除 pod

```bash
$ sudo rkt rm ea

# docker rm
```

# More information

* http://www.infoq.com/cn/articles/coreos-rkt-container-part-01

* http://www.infoq.com/cn/articles/coreos-rkt-container-part-02
