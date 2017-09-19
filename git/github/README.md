---
title: GitHub 使用规范
date: 2017-08-01 14:00:00
updated:
comments: true
tags:
- GitHub
categories:
- Git
- GitHub
---

标准化`Git`使用

<!--more-->

# repo.json

```json
{
  "repo": {
    "github": "git@github.com:khs1994/docs.git",
    "aliyun": "git@code.aliyun.com:khs1994/docs.git"
  },
  "branch": "gitbook",
  "deploy-branch": "master",
  "description": "khs1994.com 技术文档"
}
```

# `.gitignore`

每个项目必须有`.gitignore`
