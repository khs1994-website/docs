---
title: Linux systemd 详解
date: 2016-08-12 13:00:00
updated:
comments: true
tags:
- Linux
- systemd
categories:
- Linux
---

目前几乎所有的 Linux 发行版已切换到 `systemd`。

GitHub：https://github.com/systemd/systemd

官方网站：https://www.freedesktop.org/wiki/Software/systemd/

<!--more-->

> `systemd` 系列文章请查看：https://www.khs1994.com/tags/systemd/

# 拼写

`systemd` 均为小写，其他任何写法都不正确。

# 命令

## `systemctl`

`start`

`stop`

`restart`

`kill`

`reload`

`sudo systemctl daemon-reload`

`enable`

`disable`

## `systemd-analyze`

## `hostnamectl`

查看或者设置当前主机信息。

```bash
$ sudo hostnamectl set-hostname NAME
```

## `localectl`

控制系统的本地化与键盘布局。

```bash
$ sudo localectl set-locale LANG=zh_CN.utf8 | LANG=en_US.UTF-8
```

## `timedatectl`

设置时间、时区

```bash
$ timedatectl set-time TIME

$ timedatectl set-timezone ZONE

# 查看时区列表 /usr/share/zoneinfo/

$ timedatectl list-timezones
```

## `loginctl`

查看当前登录用户

# Unit

主要分为以下几种

`Service`

`Target`

`Timer`

## 列出正在运行的 `Unit`

```bash
$ sudo systemctl list-units
```

## 列出所有的 `Unit`

```bash
$ sudo systemctl list-units -all
```

## 查看依赖关系

```bash
$ sudo systemctl list-dependencies docker.service
```

# Unit 配置文件

`/etc/systemd/system`

`/usr/lib/systemd/system`

## 列出所有配置文件

```bash
$ sudo systemctl list-unit-files
```

## 查看 unit 配置文件

```bash
$ sudo systemctl cat docker.service
```

## 状态

`enabled`

`disabled`

`static` 没有 Installl，无法执行，只能作为其他配置文件的依赖。

`masked` 该配置文件被禁止建立启动链接

```yaml
[Unit]                   服务的说明  
Description=             描述服务
Documentation=           文档地址
Requires=                当前 Unit 依赖的其他 Unit
Wants=                   与当前 Unit 配合的其他 Unit
BindsTo=                 与 Requires 类似，其指定的 Unit 如果退出，则当前 Unit 也将停止运行
Before=                  该字段指定的 Unit 要启动，那么必须在当前 Unit 之后启动
After=                   该字段指定的 Unit 要启动，那么必须在当前 Unit 之前启动
Conflicts=               该字段指定的 Unit 不能与当前 Unit 同时启动


[Service]                服务运行参数的设置
Environment=             设置环境变量
Type=forking             是后台运行的形式
ExecStartPre=            启动当前服务之前执行的命令  
ExecStart=               服务的具体运行命令
ExecStartPost=           启动当前服务之后执行的命令
ExecReload=              重启命令
ExecStop=                停止命令
ExecStopPost=            停止当前服务之后执行的命令
RestartSec=              自动重启当前服务间隔的秒数
Restart=                 定义何种情况 systemd 会自动重启当前服务，可能的值包括 always（总是重启）、on-success、on-failure、on-abnormal、on-abort、on-watchdog
TimeoutSec               定义 systemd 停止当前服务之前等待的秒数
# [Service]的启动、重启、停止命令全部要求使用绝对路径  

[Install]
WantedBy=                值为一个或多个 Target，当前 Unit 被 enable 时，符号链接放到 /etc/systemd/system/ 目录下面
#                        以 Target+ .wants 后缀构成的子目录中
RequireBy=
Alias=                   当前 Unit 可用于启动的别名
Also=                    当前 Unit 被 enable 时，激活该字段指定的 Unit
```

# Target

`Target` 是一组 `Unit` 的集合

# 日志管理 `journalctl`

## 查看某个 Unit 的日志

```bash
$ sudo journalctl -u docker.service
```

# 定时器单元 取代 Cron

`*.timer`

# 相关链接

* http://www.jinbuguo.com/systemd/

* http://www.ruanyifeng.com/blog/2016/03/systemd-tutorial-commands.html

* https://www.ibm.com/developerworks/cn/linux/1407_liuming_init3/

* http://blog.jobbole.com/97248/

* http://www.cnblogs.com/piscesLoveCc/p/5867900.html

* [Arch wiki systemd][Arch wiki systemd]

[Arch wiki systemd]:https://wiki.archlinux.org/index.php/systemd_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
