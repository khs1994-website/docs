---
title: VirtualBox Ubuntu EFI 模式配置
date: 2017-02-02 13:00:00
updated:
comments: true
tags:
- Ubuntu
- EFI
categories:
- VM
---

以 `UEFI` 模式启动虚拟机，首次启动会出现错误。 

<!--more-->

```bash
Shell> FS0:
FS0:\> cd EFI
FS0:\EFI> mkdir boot
FS0:\EFI> cp ubuntu\grubx64.efi boot\bootx64.efi
```
