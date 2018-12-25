---
title: 使用 PCIT 持续集成 Node.js 项目
date: 2018-12-02 13:00:00
updated:
comments: true
tags:
- CI
- Style CI
categories:
- CI
- PCIT
---

PCIT 是一整套 CI 工具集。

<!--more-->

官方网站: https://ci.khs1994.com

```yaml

language: node_js

pipeline:

  install:
    commands:
      - npm i

  script:
    commands:
      - npm test
```
