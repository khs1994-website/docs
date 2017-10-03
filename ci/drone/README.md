---
title: Drone CI/CD 实践
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

测试环境：macOS + Drone + GitHub

生产环境：Debian9 + Drone + GitHub

<!--more-->

# 安装

## 0.7 版本

编写 `docker-compose.yml`，示例文件请到 [这里](https://github.com/khs1994-docker/drone/blob/0.7/docker-compose.yml) 查看。

## 0.8 版本

编写 `docker-compose.yml`，示例文件请到 [这里](https://github.com/khs1994-docker/drone/blob/0.8/docker-compose.yml) 查看。

注意：0.8 版本的 `drone-server`、`drone-agent` image 不同。

之后使用以下命令启动即可

```bash
$ docker-compose up -d
```

# 使用

与 Travis CI 类似，项目中包含 `.drone.yml` 即可使用。

使用文档请查看 [这里](http://docs.drone.io/getting-started/)。

# 相关链接

* http://drone.io/
* http://docs.drone.io/zh/
