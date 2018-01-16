---
title: Docker Cloud 简介
date: 2017-10-20 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

`Docker Cloud` 是官方推出的构建、测试镜像，管理 Swarm mode，自动以镜像方式部署服务的地方。

<!--more-->

# 构建镜像

和我们熟悉的 `Dockr Hub` 一样，关联 `GitHub` 或者 `Bitbucket` 即可开始自动构建镜像。

构建镜像详情只有自己能够看到。

## 自动测试

https://docs.docker.com/docker-cloud/builds/automated-testing/

https://docs.docker.com/docker-cloud/builds/advanced/

每次源代码提交 Pr 时，Docker Cloud 会自动测试 Pr。

在构建配置选项打开自动测试，并在构建目录下新增 `docker-compose.test.yml`

```yaml
sut:
  build: .
  command: run_tests.sh
```

可以通过 `depends_on` 增加服务，也可以使用多个 `compose` 文件，只要以 `.test.yml` 结尾就行。

命令返回 0 则表示测试通过，其他均为失败。


示例：https://github.com/khs1994-docker/hexo/blob/dev/alpine/docker-compose.test.yml

# Swarm mode

https://docs.docker.com/docker-cloud/cloud-swarm/connect-to-swarm/

切换到 `Swarms beta` 标签，按照提示在 Docker 主机执行命令，即可在 Docker 桌面版方便的查看集群详情。

# 其他功能

链接特定云服务商才能使用，这里不再说明。
