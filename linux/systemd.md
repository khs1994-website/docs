---
title: Linux Systemd 详解
date: 2016-08-10 13:00:00
updated:
comments: true
tags:
- Linux
- Systemd
categories:
- Linux
---

目前绝大部分 Linux 发行版已切换到 Systemd。

<!--more-->

```yaml
[Unit]                   服务的说明  
Description=             描述服务  
After=                   描述服务类别  

[Service]                服务运行参数的设置  
Type=forking             是后台运行的形式  
ExecStart=               服务的具体运行命令  
ExecReload=              重启命令  
ExecStop=                停止命令  
PrivateTmp=True          表示给服务分配独立的临时空间  
# [Service]的启动、重启、停止命令全部要求使用绝对路径  

[Install]                运行级别下服务安装的相关设置，可设置为多用户，即系统运行级别为3  
```

# 相关链接：

* http://www.cnblogs.com/piscesLoveCc/p/5867900.html
