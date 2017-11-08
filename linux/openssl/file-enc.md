---
title: OpenSSL 加密解密文件
date: 2017-10-09 13:00:00
updated:
comments: true
tags:
- Linux
- OpenSSL
categories:
- Linux
- OpenSSL
---

加密解密文件。

<!--more-->

```bash
# 加密

$ openssl enc -aes-128-cbc -e -a -in ~/.ssh/khs1994-robot -out ~/.ssh/khs1994-robot.enc -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58

# 解密

$ openssl enc -aes-128-cbc -d -a -in ~/.ssh/khs1994-robot.enc -out ~/.ssh/id_rsa -K c286696d887c9aa0611bbb3e2025a45a -iv 562e17996d093d28ddb3ba695a2e6f58
```

`-e` 加密

`-d` 解密

`-a` 加密前/后使用 base64 编码

Key 和 IV 值是 16进制


## More Information

* https://www.cnblogs.com/gordon0918/p/5317701.html
