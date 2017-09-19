---
title: GitBook + Travis CI 实践
date: 2017-07-31 13:00:00
updated:
comments: true
tags:
- GitBook
- CI
- Travis CI
categories:
- CI
- Travis CI
---

刚开始在Travis CI中从`零`开始搭建环境，全部执行时间为 `3分半`，将环境部署进Docker， `pull Docker` 之后直接开始生成，时间缩短为`1分半`。

<!--more-->

# 示例文件

```yaml
language: node_js
node_js: stable
cache:
  directories:
    - "node_modules"
before_install:
- openssl aes-256-cbc -K $encrypted_4514352cb17e_key -iv $encrypted_4514352cb17e_iv
  -in .travis/khs1994-robot.enc -out ~/.ssh/id_rsa -d
- chmod 600 ~/.ssh/id_rsa
- git config --global user.name "khs1994-merge-robot"
- git config --global user.email "ai@khs1994.com"
- echo "TZ='Asia/Shanghai'; export TZ" >> ~/.profile
- . ~/.profile
install:
- git ls-files | while read file; do touch -d $(git log -1 --format="@%ct" "$file") "$file"; done
- npm install gitbook -g
- npm install gitbook-cli
script:
- gitbook install
- gitbook build
deploy:
  provider: script
  script: .travis/deploy.sh
  skip_cleanup: true
  on:
    branch: gitbook
branches:
  only:
  - gitbook
env:
  global:
  - REPO: git@github.com:khs1994-gitbook/docker_practice.git
addons:
  ssh_known_hosts:
  - github.com
  - code.aliyun.com
```

# 相关链接

* https://github.com/steveklabnik/automatically_update_github_pages_with_travis_example
* http://blog.csdn.net/qq8427003/article/details/64921201
