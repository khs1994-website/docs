---
title: Hexo + Travis CI 实践（整合优化）
date: 2017-07-30 13:00:00
updated:
comments: true
tags:
- Hexo
- CI
- Travis CI
categories:
- CI
- Travis CI
---

本文简要介绍了使用 Travis CI 构建 Hexo。

<!--more-->

使用 `Travis CI` 之前：

* 本地编写 `source/*.md`

* `hexo g` 本地预览

* `hexo d` 推送到 `GitHub` 和 `aliyun`

* `手动` 完成后续操作：登录到服务器，`pull` 到网站根目录。

使用 `Travis CI`：

* 本地编写 `source/*.md`

* `hexo g` 本地预览

* 将部署文件推送到 `GitHub` 和 `aliyun`

* `自动` 完成后续操作：

* `Travis CI` 云端生成 `HTML`,并将其推送到 `GitHub` 和 `aliyun` 仓库的 `master` 分支

* GitHub `webhooks` 通知服务器，服务器将 `aliyun` 仓库的代码 `强制pull`

* 调用 `百度站长平台` 完成URL `主动推送`

* 调用 `微信公众平台` 模板消息 API 完成消息提醒

# 配置

在 `Travis CI` 网站开启项目部署

[GitHub仓库](https://github.com/khs1994/khs1994.github.io) `hexo` 存放部署文件，`master` 存放HTML文件。

注意：用户名.github.io 仓库的 `Pages` 只能使用 `master` 分支

在项目根目录编写 `.travis.yml`

示例文件：https://github.com/khs1994/khs1994.github.io/blob/hexo/.travis.yml

使用 `命令行工具` 加密 SSH 私钥（也可以使用 `github Token`）注意去掉转义符。

最后推送项目到 GitHub。

一些常见问题请查看 [Travis CI 使用详解](README.html)

# 相关链接

* http://blog.csdn.net/woblog/article/details/51319364
* https://segmentfault.com/a/1190000004667156
