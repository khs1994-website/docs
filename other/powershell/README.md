---
title: PowerShell 资源
date: 2018-03-01 13:00:00
updated:
comments: true
tags:
- PowerShell
categories:
- PowerShell
---

GitHub：https://github.com/PowerShell

GitHub：https://github.com/PowerShell/powerShell-Docs.zh-cn

文档：https://docs.microsoft.com/zh-cn/powershell/scripting/powershell-scripting?view=powershell-6

<!--more-->

# 读取系统环境变量

```bash
$ echo $env:Temp
```

## 永久生效

就像我们在图形界面设置的一样

```bash
$ [environment]::SetEnvironmentvariable("a", "1", "User")
```

* https://www.pstips.net/powershell-environment-variables.html
