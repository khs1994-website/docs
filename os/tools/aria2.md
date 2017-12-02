---
title: macOS aria2 命令行使用详解
date: 2017-10-06 13:00:00
updated:
comments: true
tags:
- aria2
categories:
- OS
- Tools
---

aria2 是一个下载工具。

<!--more-->

* aria2 https://github.com/aria2/aria2

* BaiduExporter https://github.com/acgotaku/BaiduExporter

# 安装

```bash
$ brew install aria2
```

# 配置

参考 http://aria2c.com/usage.html 在 `~/.aria2/aria2.conf` 中写入配置内容。

主要修改 `下载路径`

注意：将示例配置中的以下内容注释，不注释的话启动会报错。

```yaml
# 从会话文件中读取下载任务
input-file=/etc/aria2/aria2.session
# 在Aria2退出时保存`错误/未完成`的下载任务到会话文件
save-session=/etc/aria2/aria2.session
```

# 启动

```bash
$ aria2c
```

# 下载百度网盘里的文件

## Chrome 插件

```bash
git clone https://github.com/acgotaku/BaiduExporter
```

或者下载项目打包文件。

在 Chrome 扩展中加载该项目 `chrome` 文件夹

在百度网盘页面点击 `导出下载` -> `ARIA2 PRC`

回到命令行，看到开始下载
