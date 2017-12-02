---
title: Docker 清理命令 prune
date: 2017-10-16 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Docker 1.13.0+ 引入了清理命令。

官方文档：https://docs.docker.com/engine/admin/pruning/

<!--more-->

# 清理镜像

```bash
$ docker image prune
```

# 清理容器

```bash
$ docker container prune
```

# 清理网络

```bash
$ docker network prune
```

# 清理 Volume

```bash
$ docker volume prune
```

# 清理所有

```bash
$ docker system prune

$ docker system prune --volumes
```

# More Information

* https://segmentfault.com/a/1190000007822648
