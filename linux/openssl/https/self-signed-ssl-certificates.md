---
title: 自签名 SSL 网站证书
date: 2018-01-01 13:00:00
updated:
comments: true
tags:
- Linux
- openssl
- https
categories:
- Linux
- openssl
- https
---

GitHub：https://github.com/khs1994-docker/tls

<!--more-->

# 本站其他相关文章

* [Nginx https 配置](https://www.khs1994.com/php/development/nginx-https.html)

* [Let's Encrypt SSL 证书配置详解](https://www.khs1994.com/php/development/nginx-lets-encrypt.html)

* [Https 标签下的文章](https://www.khs1994.com/tags/https/)

## 自签名证书详解

这里假设想要签署 SSL 的网站为 `docker.domain.com`，下面我们介绍使用 `openssl` 自行签发 `docker.domain.com` 的站点 SSL 证书。

### 1. 创建 `CA` 私钥。

```bash
$ openssl genrsa -out "root-ca.key" 4096
```

### 2. 利用私钥创建 `CA` 根证书请求文件。

```bash
$ openssl req \
          -new -key "root-ca.key" \
          -out "root-ca.csr" -sha256 \
          -subj '/C=CN/ST=Shanxi/L=Datong/O=Your Company Name/CN=Your Company Name Docker Registry CA'
```

>以上命令中 `-subj` 参数里的 `/C` 表示国家，如 `CN`；`/ST` 表示省；`/L` 表示城市或者地区；`/O` 表示组织名；`/CN` 通用名称。

### 3. 配置 `CA` 根证书，新建 `root-ca.cnf`。

```bash
[root_ca]
basicConstraints = critical,CA:TRUE,pathlen:1
keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
subjectKeyIdentifier=hash
```

### 4. 签发根证书。

```bash
$ openssl x509 -req  -days 3650  -in "root-ca.csr" \
               -signkey "root-ca.key" -sha256 -out "root-ca.crt" \
               -extfile "root-ca.cnf" -extensions \
               root_ca
```

### 5. 生成站点 `SSL` 私钥。

```bash
$ openssl genrsa -out "docker.domain.com.key" 4096
```

### 6. 使用私钥生成证书请求文件。

```bash
$ openssl req -new -key "docker.domain.com.key" -out "site.csr" -sha256 \
          -subj '/C=CN/ST=Shanxi/L=Datong/O=Your Company Name/CN=docker.domain.com'
```

### 7. 配置证书，新建 `site.cnf` 文件。

```bash
[server]
authorityKeyIdentifier=keyid,issuer
basicConstraints = critical,CA:FALSE
extendedKeyUsage=serverAuth
keyUsage = critical, digitalSignature, keyEncipherment
subjectAltName = DNS:docker.domain.com, IP:127.0.0.1
subjectKeyIdentifier=hash
```

### 8. 签署站点 `SSL` 证书。

```bash
$ openssl x509 -req -days 750 -in "site.csr" -sha256 \
    -CA "root-ca.crt" -CAkey "root-ca.key"  -CAcreateserial \
    -out "docker.domain.com.crt" -extfile "site.cnf" -extensions server
```

这样已经拥有了 `docker.domain.com` 的网站 SSL 私钥 `docker.domain.com.key` 和 SSL 证书 `docker.domain.com.crt`。

将 `root-ca.crt` 导入浏览器中，之后配置好 Web 服务器并重启。
