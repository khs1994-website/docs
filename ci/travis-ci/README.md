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

官方网站：https://travis-ci.org

<!--more-->

# 注册登录

在 https://travis-ci.org 直接通过 GitHub 登录。

# 项目同步

登录之后点击右上角用户名，再点击右上的 `Sync account` 来同步项目。

如果你名下的 GitHub 组织没有显示，请点击左下 `Review and add` 重新授予权限。

# 使用 Travis CI

在项目列表中（点击右上角头像进入）点击开关，即可打开项目构建，点击开关后边的设置按钮来设置构建选项（增加变量，计划构建等）。

在项目根目录增加 `.travis.yml` 文件，即可开始使用 travis， travis 会在项目每次提交（commit），PR，tag 时自动构建项目。

## 使用示例

* https://github.com/khs1994/khs1994.github.io/blob/hexo/.travis.yml

* https://github.com/travis-ci-examples

# 构建变量（环境变量）

在每个项目的设置页面中，通过 `K-V` 形式设置环境变量。

变量分为加密变量（构建过程不可见）和普通变量。

加密变量在构建项目中他人的 `PR` 时将不能被使用。在构建项目内不同分支的 PR 时可以使用。这一点需要注意：

例如，项目的 `dev` 分支向 `master` 分支提交 PR，构建 PR 时就可以使用加密变量。

他人向 `dev` 分支提交 PR，构建 PR 时就不能使用加密变量。

# 错误排查

`Travis CI` 本质就是一台云上的 `Linux`（Docker 容器或者是虚拟机），当执行错误时从以下两方面排查问题:

* 路径问题(使用 `$ echo $PWD` 调试)

* 权限问题(没有执行权限 `$ chmod +x filename.sh`)

# 命令行工具

安装 `Travis CI` 命令行工具

```bash
$ sudo gem isntall travis

# 登录
# github-token 在 GitHub 设置页面生成，当然也可以使用密码登录

$ sudo travis login --github-token 0abc23
```

# SSH

我们现在要让 `Travis CI` 能够通过 SSH 登录到 `服务器`，就将 `~/.ssh/id_rsa` 「加密复制」 到 `Travis CI`。

## 加密 id_rsa

进入项目根目录执行：

```bash
$ travis encrypt-file ~/.ssh/id_rsa --add
```

请根据实际修改 SSH 密钥文件名，一般默认为 `id_rsa`。

## 解密 id_rsa

命令执行之后，自动生成了 `id_rsa.enc` 文件，并自动在 `.travis.yml` 增加如下内容：

```yaml
before_install:
- openssl aes-256-cbc -K $encrypted_023c3608ff03_key -iv $encrypted_023c3608ff03_iv
  -in id_rsa.enc -out ~\/.ssh/id_rsa -d
```

> 注意：请将上述内容的 `转义符` 去掉: `-out ~\/.ssh/id_rsa -d` 改为 `-out ~/.ssh/id_rsa -d`

## ssh_known_hosts

首次 SSH 到某网址或 IP 需要输入 `yes` 来确认，你可以在 `.travis.yml` 文件中增加 `ssh_known_hosts` 来避免输入 yes

```yaml
after_success:
  - scp README.md ubuntu@123.206.62.18:~

addons:
  ssh_known_hosts:
  - 123.206.62.18
  - code.aliyun.com
  - github.com
```

# 时区

```yaml
before_install:
- export TZ='Asia/Shanghai'
```

# 部署

## GitHub Pages

```yaml
deploy:
  # 要 push 的文件夹
  local_dir: _book
  provider: pages
  # pages 所在分支
  target_branch: master
  skip_cleanup: true
  github_token: $GH_TOKEN # Set in travis-ci.org dashboard
  on:
    branch: gitbook       # 哪个分支构建的就推送
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
