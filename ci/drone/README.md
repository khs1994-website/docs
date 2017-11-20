---
title: Docker + Drone CI/CD 实践
date: 2017-09-01 13:00:00
updated:
comments: true
tags:
- CI
- Drone
categories:
- CI
- Drone
---

测试环境：macOS + Drone + Gogs + Docker Registry

生产环境：Debian 9 + Drone + GitHub + 腾讯云容器服务

官方网站：http://drone.io/

GitHub：https://github.com/drone

<!--more-->

GitHub: https://github.com/khs1994-docker/ci

GitHub: https://github.com/khs1994-drone-ci-examples

# 安装

请使用或升级到最新 0.8 版本。

编写 `docker-compose.yml`，示例文件请到 [这里](https://github.com/khs1994-docker/ci/blob/master/docker-compose.yml) 查看。

注意：0.8 版本的 `drone-server`、`drone-agent` image 不同。

与 GitHub 或 Gogs 集成请参考官方文档 http://docs.drone.io 的配置。一些说明可以查看中文文档 http://docs.drone.io/zh/。

之后使用以下命令启动即可

```bash
$ docker-compose up -d
```

# 使用

与 Travis CI 类似，项目中包含 `.drone.yml` 即可使用。

使用文档请查看 [这里](http://docs.drone.io/getting-started/)。

# 示例

请查看 Fork 源项目。

GitHub: https://github.com/khs1994-drone-ci-examples
