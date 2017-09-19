---
title: 树莓派3 开启 WiFi
date: 2017-04-03 13:00:00
updated:
comments: true
tags:
- Raspberry Pi3
categories:
- Raspberry Pi3
---

编辑 `/etc/wpa_supplicant/wpa_supplicant.conf`

<!--more-->

```bash
country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

#network={
#  ssid="WIFINAME"
#  psk="password"
#}

network={
  ssid="CMCC.."
  psk="1320271000"
}
```
