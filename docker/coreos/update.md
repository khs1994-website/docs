---
title: CoreOS 系统升级
date: 2017-09-11 13:00:00
updated:
comments: true
tags:
- CoreOS
categories:
- CoreOS
---

`CoreOS` 会自动检测升级，由于国内网络环境，下载升级包可能会失败。

<!--more-->

官方文档：https://coreos.com/os/docs/latest/update-strategies.html

# 查看升级进度

```bash
$ systemctl status update-engine
```

# 手动升级

```bash
$ update_engine_client
```

参数如下

* -status

* -watch_for_updates

* -update

* -check_for_update

# 设置升级代理服务器

```bash
$ sudo mkdir -p /etc/systemd/system/update-engine.service.d
```

`/etc/systemd/system/update-engine.service.d/50-proxy.conf` 在该文件中写入以下内容(没有就新建)。

```yaml
[Service]
Environment=HTTP_PROXY=http://your.proxy.address:port
```

```yaml
[Service]
Environment=ALL_PROXY=socks://代理地址
```

# 参考链接

* http://dockone.io/question/155
