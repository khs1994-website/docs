---
title: Docker Machine 使用详解
date: 2017-06-01 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

Automate container provisioning on your network or in the cloud. Available for Windows, macOS, or Linux.

<!--more-->

```bash
$ docker-machine create --driver virtualbox default
$ docker-machine ls
$ docker-machine env default
$ eval "$(docker-machine env default)"
$ docker run -d -p 8000:80 nginx
$ curl $(docker-machine ip default):8000
```
