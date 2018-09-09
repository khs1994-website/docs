---
title: GitHub API
date: 2017-07-08 14:00:00
updated:
comments: true
tags:
- GitHub
categories:
- GitHub
---

本文简要介绍了 GitHub 的 API。

<!--more-->

官方网站：https://api.github.com

官方文档：https://developer.github.com/v3/

# 验证方式

https://developer.github.com/v3/#authentication

* `curl -u "username" https://api.github.com`

* URL 参数 `url?access_token=OAUTH-TOKEN`

* Header 方式 `Authorization: token OAUTH-TOKEN`

* `URL?client_id=xxxx&client_secret=yyyy` (S2S only)

# 举例

* 获取项目最新版本 https://api.github.com/repos/docker/compose/releases/latest


* 获取组织的项目列表 https://api.github.com/orgs/khs1994-docker/repos
