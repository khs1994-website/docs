---
title: 安卓依赖服务器 Nexus
date: 2016-01-02 13:00:00
updated:
comments: true
tags:
- Android
categories:
- Other
- Android
---

Nexus 是一个基于 maven 的仓库管理的社区项目。主要的使用场景就是可以在局域网搭建一个 maven 私服，用来部署第三方公共构件或者作为远程仓库在该局域网的一个代理。

<!--more-->

# Docker

```bash
$ docker run -d -p 8081:8081 --name nexus \                          
   -v /Users/khs1994/docker/data/nexus-data:/nexus-data \
   sonatype/nexus3
```

# 配置

## 项目 buid.gradle

    allprojects {
      repositories {
        jcenter()
        //
        mavenLocal()
      }
    }

## app

    allprojects {
      repositories {
          maven {
            url "https://nexus.khs1994.com/repository/com.khs1994.khs1994lib/"
          }
      }
    }

## lib

    uploadArchives {
    repositories.mavenDeployer() {
        repository(url:"https://nexus.khs1994.com/repository/com.khs1994.khs1994lib/"){
            authentication(userName:"khs1994", password:"khs19941218")
        }
        pom.version="0.0.1"
        pom.artifactId="khs1994lib"
        pom.groupId="com.khs1994"
      }
    }

# 相关链接

* [官方网站](https://www.sonatype.com/download-oss-sonatype)
* [nexus Docker](https://hub.docker.com/r/sonatype/nexus3/)
* http://blog.csdn.net/l2show/article/details/48653949  
