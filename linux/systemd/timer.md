---
title: Linux systemd 定时器 timer
date: 2016-08-13 12:00:00
updated:
comments: true
tags:
- Linux
- systemd
categories:
- Linux
---

用来取代 `crontab`

<!--more-->

> `systemd` 系列文章请查看：https://www.khs1994.com/tags/systemd/

要使用定时器必须编写两个文件：

* `name.timer` 配置时间。

* `name.service` 配置具体执行的命令。

>注意：这两个文件的名称是相同的，只是后缀不同。

# 编写脚本

`/usr/local/bin/name.sh`

```bash
#!/bin/bash
date >> /tmp/name.txt
echo 1 >> /tmp/name.txt
```

在 `/etc/systemd/system` 文件夹内编写下面的两个文件。

# `name.timer`

```yaml
[Unit]
# 描述信息
Description=My systemd timer Demo

[Timer]
# 首次运行要在启动后10分钟后
OnBootSec=10min
# 每次运行间隔时间
OnUnitActiveSec=1h

[Install]
WantedBy=multi-user.target
```

详细信息请查看以下网址：

* http://www.jinbuguo.com/systemd/systemd.timer.html

* https://www.freedesktop.org/software/systemd/man/systemd.timer.html

## 用法举例

```yaml
[Timer]

OnCalendar=*-*-* *:*:00 # 每分钟执行，与 crontab 类似。
#       hourly → *-*-* *:00:00
#        daily → *-*-* 00:00:00
#      monthly → *-*-01 00:00:00
#       weekly → Mon *-*-* 00:00:00
#       yearly → *-01-01 00:00:00
#    quarterly → *-01,04,07,10-01 00:00:00
# semiannually → *-01,07-01 00:00:00
```

# `name.service`

```yaml
[Unit]
# 描述信息
Description=My systemd timer Demo

[Service]
Type=simple
ExecStart=/usr/local/bin/name.sh
```

# 启用定时器

```bash
$ sudo systemctl daemon-reload

$ sudo systemctl enable name.timer

$ sudo systemctl start name.timer
```

# 查看定时器

```bash
$ systemctl list-timer
```

查看日志。

```bash
$ sudo journalctl -u name.service
```
