---
title: Travis CI 使用详解
date: 2017-07-29 13:00:00
updated:
comments: true
tags:
- CI
- Travis CI
categories:
- CI
- Travis CI
---

本文列举了使用 Travis CI 可能遇到的问题及其解决方法。

<!--more-->

首先明确三个环境  

`开发机`  
`Travis CI`  
`服务器（生产环境）`

# 错误排查

`Travis CI` 本质就是一台云上的 `Linux`,当执行错误时从以下两方面排查问题:

* 路径问题(使用 `$ echo $PWD`)

* 权限问题(没有执行权限 `$ chmod +x filename.sh`)

# 命令行工具

`开发机` 安装 `Travis CI` 命令行工具

```bash
# ruby 可能需要 sudo
$ gem isntall travis

# 登录
# github-token 在 GitHub 设置页面生成，当然也可以使用密码登录
$ travis login --github-token
```

# SSH

原理:

`开发机` 登录到 `服务器` 使用 `SSH` (主要是 `id_rsa` 和 `id_rsa.pub`)

我们现在要让 `Travis CI` 能够登录到 `服务器`，就将 `开发机` 的 `~/.ssh/id_rsa` 「复制」 到 `Travis CI` 即可  

## 加密 id_rsa

进入项目根目录执行：

```bash
$ travis encrypt-file ~/.ssh/id_rsa --add
```

请根据实际修改 SSH 密钥文件名，一般默认为 `id_rsa`。

## 解密 id_rsa

命令执行之后,自动生成了 `id_rsa.enc` 文件，并自动在 `.travis.yml` 增加如下内容：

```yaml
before_install:
- openssl aes-256-cbc -K $encrypted_023c3608ff03_key -iv $encrypted_023c3608ff03_iv
  -in id_rsa.enc -out ~\/.ssh/id_rsa -d
```

注意：请将上述内容的 `转义符` 去掉: `-out ~\/.ssh/id_rsa -d` 改为 `-out ~/.ssh/id_rsa -d`

## ssh_known_hosts

首次 SSH 到某网址或 IP 需要输入 `yes` 来确认，在脚本中不太方便输入 yes ：

```yaml
after_success:
  - scp README.md ubuntu@123.206.62.18:~

addons:
  ssh_known_hosts:
  - 123.206.62.18
  - code.aliyun.com
  - github.com

# 这样就不用输入 yes 了
```

# 时区

```yaml
before_install:
- echo "TZ='Asia/Shanghai'; export TZ" >> ~/.profile
- . ~/.profile
```

# 部署

## GitHub Pages

```yaml
deploy:
  #要push的文件夹
  local_dir: _book
  provider: pages
  target_branch: master
  skip_cleanup: true
  github_token: $GH_TOKEN # Set in travis-ci.org dashboard
  on:
    branch: gitbook       #哪个分支构建的就推送
```

## script

```yaml
deploy:
  provider: script
  script: .travis/deploy.sh
  skip_cleanup: true
  on:
    branch: gitbook
```

# 缓存 Cache

```yaml
cache:
  directories:
  - node_modules
```

# 相关链接

* [官方文档](https://docs.travis-ci.com/)
