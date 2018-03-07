---
title: 使用 PowerShell 操控 Hyper-V
date: 2018-02-05 13:00:00
updated:
comments: true
tags:
- Hyper-V
categories:
- VM
- Hyper-V
---

必须使用系统自带的 `PowerShell`。

<!--more-->

* 获取虚拟机 IP

```bash
$ (( Get-VM vm-name ).networkadapters[0]).ipaddresses[0]
```
