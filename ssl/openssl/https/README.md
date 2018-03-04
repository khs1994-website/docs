---
title: NGINX 配置 TLSv1.3
date: 2018-01-02 13:00:00
updated:
comments: true
tags:
- SSL
- OpenSSL
- https
categories:
- SSL
- OpenSSL
- https
---

将 `即将` 发布的 `TLSv1.3` 作为 `https` 系列的开篇。

GitHub：https://github.com/khs1994-website/tls-1.3

<!--more-->

# 一键部署

[khs1994-docker/lnmp](https://github.com/khs1994-docker/lnmp) 原生支持 TLSv1.3。

PHP 开发者可以使用此项目一键部署 `TLSv1.3`。

# 本站其他相关文章

* [NGINX https 配置](https://www.khs1994.com/php/development/nginx/https.html)

* [Let's Encrypt SSL 证书配置详解](https://www.khs1994.com/php/development/nginx/lets-encrypt.html)

* [Https 标签下的文章](https://www.khs1994.com/tags/https/)

# 浏览器环境

> 务必使用最新测试版浏览器测试 `TLSv1.3`，请首先升级浏览器版本，否则后边的做法没有任何意义。

* `Chrome` dev 版本

* `FireFox` beta 版本

* `Chrome Android` dev 版本

# 从 GitHub 克隆 openssl 源码

```bash
$ git clone -b master --depth=1 https://github.com/openssl/openssl /srv/openssl

# 国内镜像

$ git clone -b master --depth=1 https://gitee.com/mirrors/openssl.git /srv/openssl
```

> 你可能查看有的教程克隆了 `tls1.3-draft-18` 分支，注意此草案已经过了很久，[最新草案](https://tools.ietf.org/html/draft-ietf-tls-tls13-24) 已经更新到了 `24` 版本。最新草案已集成到 `master` 分支，我们这里直接克隆 `master` 分支即可。

# 编译安装 NGINX

主要添加以下两项

```bash
--with-openssl=/srv/openssl
--with-openssl-opt='enable-tls1_3'
```

NGINX 编译安装请查看 https://www.khs1994.com/php/development/nginx/build.html

# Docker

本人使用 `Dockerfile` 构建镜像，更多信息请查看这里 https://github.com/khs1994-website/tls-1.3

你可以很方便的 `pull` 我构建好的镜像测试 `TLSv1.3`

# nginx 配置

```nginx
server {
  # 为了测试各浏览器对 TLSv1.3 的支持，这里只保留 TLSv1.3
  ssl_protocols            TLSv1.3;

  ssl_ciphers              TLS13-CHACHA20-POLY1305-SHA256:TLS13-AES-128-GCM-SHA256:TLS13-AES-256-GCM-SHA384:EECDH+CHACHA20:EECDH+CHACHA20-draft:EECDH+AES128:RSA+AES128:EECDH+AES256:RSA+AES256:EECDH+3DES:RSA+3DES:!MD5;
}
```

如果有多个子域名配置，必须保证每个配置项中 (`server{ }`) 都启用了 `TLSv1.3`。

浏览器访问测试。

* Chrome 打开 `Chrome://flags` 搜索 TLS 选择 `Enable ***`，不同 Chrome 版本的选项不同，选一个 Enable 开头的就对了。

* 火狐 我用的 beta 版，默认已打开相关选项，无需配置。

我这里只记录相关操作需要注意的地方，细节等详细信息请查看下面的链接。

# 参考链接

* https://imququ.com/post/enable-tls-1-3.html

* https://www.mf8.biz/nginx-tls1-3-draft/

* [又拍云支持 TLSv1.3](https://tech.upyun.com/article/276/%E5%8F%88%E6%8B%8D%E4%BA%91%20CDN%20%E6%AD%A3%E5%BC%8F%E6%94%AF%E6%8C%81%20TLS%201.3%20%E5%8A%A0%E5%AF%86%E5%8D%8F%E8%AE%AE%EF%BC%8C%E4%B8%80%E9%94%AE%E5%BC%80%E5%90%AF%E6%9E%81%E9%80%9F%20HTTPS%20%E4%BD%93%E9%AA%8C.html)
