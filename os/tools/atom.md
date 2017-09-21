---
title: Atom 配置插件记录
date: 2016-04-20 13:00:00
updated:
comments: true
tags:
- Atom
categories:
- OS
- Tools
---

Find and run available commands using `cmd-shift-p` (macOS) or `ctrl-shift-p` (Linux/Windows) in Atom.

<!--more-->

# 插件

## 命令行方式

>apm - Atom Package Manager powered by https://atom.io

```bash
apm install sync-settings
```

# 插件列表

## sync-settings

>备份插件、配置

gitst: `80a9978333b86f4a6deb5cb2ddca56ad`

https://gist.github.com/khs1994/80a9978333b86f4a6deb5cb2ddca56ad

按下全局命令搜索面板`Ctrl+shift+p`  
搜索`sync` ,会有可选项:
* sync-settings:backup       – 备份当前的配置
* sync-settings:restore      – 恢复配置
* sync-settings:view-backup  – 查询备份
* sync-settings:check-backup – 查询最后一次是否正常

## Other

* file-icons
* recent-projects
* language-docker
* language-nginx
* platformio-ide-terminal



# 相关链接

* http://blog.csdn.net/crper/article/details/47291063  
* [插件列表](https://atom.io/packages)
