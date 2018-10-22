---
title: Docker for Mac 开启 Docker API
date: 2018-01-30 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

参考链接：https://segmentfault.com/q/1010000008458880

参考链接：https://my.oschina.net/u/2306127/blog/777695

<!--more-->

任选一种。

```bash
$ docker run -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 2375:2375 \
    bobrik/socat \
    TCP4-LISTEN:2375,fork,reuseaddr UNIX-CONNECT:/var/run/docker.sock
```

```bash
$ docker run -d \
    -p 2375:2375 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e PORT=2375 \
    shipyard/docker-proxy
```

之后打开浏览器 `127.0.0.1:2375/version`。

# More Information

* [Docker API](https://docs.docker.com/engine/api/v1.35/)
