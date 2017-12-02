---
title: Docker 远程连接 -- dockerd 命令详解
date: 2017-10-22 14:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

配置 `TLS` 实现安全的 Docker 远程连接。

本机：`macOS`

远程机：使用 `VirtualBox` 虚拟 `CoreOS` (IP `192.168.57.110`)

目标：能在 `macOS` 远程操作 `CoreOS`。（注意不是 SSH 远程登录）。

<!--more-->

官方文档：https://docs.docker.com/edge/engine/reference/commandline/dockerd/

先介绍 `非安全` 的连接方式。

# 修改配置

## 通常的配置方法

`docker.service` 中 `dockerd` 的参数不能与 `daemon.json` 中的键值对冲突。这里我们删去 `docker.service` 中的 `-H` 参数，在 `daemon.json` 中进行配置。

修改 `/lib/systemd/system/docker.service` （下文统一简称 `docker.service`）文件

>注意：`CoreOS` 上的 `docker.service` 位于 `/var/run/systemd/system/docker.service`。

```yaml
ExecStart=/usr/bin/dockerd -H fd://

# 修改为

ExecStart=/usr/bin/dockerd
```

在 `/etc/docker/daemon.json` （下文统一简称 `daemon.json`）中写入以下内容

```json
{
  "hosts":[
    "unix:///var/run/docker.sock",
    "tcp://0.0.0.0:2375"
  ]
}
```

## 借鉴 CoreOS 官方文档提供的方法

官方文档：https://coreos.com/os/docs/latest/customizing-docker.html

新建 `/etc/systemd/system/docker-tcp.socket` 文件

```yaml
[Unit]
Description=Docker Socket for the API

[Socket]
ListenStream=2375
BindIPv6Only=both
Service=docker.service

[Install]
WantedBy=sockets.target
```

```bash
$ sudo systemctl enable docker-tcp.socket
$ sudo systemctl start docker-tcp.socket
```

Systemd socket 详情请查看：http://www.jinbuguo.com/systemd/systemd.socket.html

## 选择以上两种方法之一

之后重新启动 Docker

```bash
$ sudo systemctl daemon-reload

$ sudo systemctl restart docker

$ sudo systemctl status docker
```

在 `macOS` 上使用以下命令

```bash
$ docker -H 192.168.57.110:2375 info
```

证明可以成功连接到

在 `macOS` 上远程操作 `CoreOS` 上的 `Docker` 每次执行命令时必须加上 `-H` 参数(太麻烦)，或者配置 `环境变量`。

在 `macOS` 上执行如下命令。

```bash
$ docker -H 127.0.0.1 info

$ export DOCKER_HOST="tcp://0.0.0.0:2375"

$ docker info
```

让环境变量永久生效请写入 `~/.bashrc`

## fish shell

本人 `macOS` 上使用的 shell 是 fish，这里记录一下 fish 中的操作，使用 bash 的读者请忽略 fish 相关内容。

```bash
$ set -Ux DOCKER_HOST "tcp://0.0.0.0:2375"

# 以上命令写入的环境变量是永久存在的，通过以下命令删除环境变量

$ set -Ue DOCKER_HOST
```

# 配置安全连接

官方文档：https://docs.docker.com/engine/security/https/

上面我们配置的远程连接是不安全的，只能用于测试环境中。在生产环境需要配置 `TLS` 安全连接，只有拥有密钥的客户端，才能连接到远程的服务端。

只能使用 Linux 下的 `openssl` 生成密钥，macOS 下的不可以。

在 `CoreOS` 下执行以下操作

## Create a CA, server and client keys with OpenSSL

```bash
$ openssl genrsa -aes256 -out ca-key.pem 4096

# 需要输入两次密码

$ openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

$ openssl genrsa -out server-key.pem 4096

$ openssl req -subj "/CN=coreos1" -sha256 -new -key server-key.pem -out server.csr

$ echo subjectAltName = DNS:coreos1,IP:192.168.199.100,IP:192.168.57.110,IP:127.0.0.1 >> extfile.cnf

$ echo extendedKeyUsage = serverAuth >> extfile.cnf

$ openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out server-cert.pem -extfile extfile.cnf

$ openssl genrsa -out key.pem 4096  

$ openssl req -subj '/CN=client' -new -key key.pem -out client.csr

$ echo extendedKeyUsage = clientAuth >> extfile.cnf

$ openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out cert.pem -extfile extfile.cnf

$ rm -v client.csr server.csr

$ chmod -v 0400 ca-key.pem key.pem server-key.pem

$ chmod -v 0444 ca.pem server-cert.pem cert.pem
```

修改 `CoreOS` 上的 `daemon.json` 文件。

## 通常的配置方法

>注意：非安全连接使用的是 `2375` 端口，安全连接使用的是 `2376` 端口。当然这是推荐的，你可以使用任何端口！

```json
{
  "tlsverify": true,
  "tlscert": "/home/core/server-cert.pem",
  "tlskey": "/home/core/server-key.pem",
  "tlscacert": "/home/core/ca.pem",
  "hosts":[
    "unix:///var/run/docker.sock",
    "tcp://0.0.0.0:2376"
  ]
}
```

## 借鉴 CoreOS 官方文档的方法

`/etc/systemd/system/docker-tcp.socket` 文件中

```yaml
ListenStream=2375

# 修改为

ListenStream=2376
```

```json
{
  "tlsverify": true,
  "tlscert": "/home/core/server-cert.pem",
  "tlskey": "/home/core/server-key.pem",
  "tlscacert": "/home/core/ca.pem"
}
```

## 根据本文第一步选择的方法选择对应的方法

重新启动 Docker

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker.socket
$ sudo systemctl restart docker
```

# 客户端远程安全连接

将 `ca.pem` `cert.pem` `key.pem` 三个文件通过 `scp` 下载到 `macOS`

在 `macOS` 执行以下命令，密钥路径请根据实际情况填写。

```bash
$ docker --tlsverify \
  --tlscacert=~/test/ca.pem \
  --tlscert=~/test/cert.pem \
  --tlskey=~/test/key.pem \
  -H=192.168.57.110:2376 \
  info
```

现在如果不使用安全连接会报如下错误

```bash
$ docker -H 192.168.57.110:2376 info
Get http://192.168.57.110:2376/v1.34/containers/json?all=1: malformed HTTP response "\x15\x03\x01\x00\x02\x02".
* Are you trying to connect to a TLS-enabled daemon without TLS?
```

## 把密钥放入 `~/.docker` 文件夹中

每次操作需要跟那么多参数，太麻烦了。

我们可以把 `ca.pem` `cert.pem` `key.pem` 三个文件放入 `~/.docker` 中（没有就新建），然后配置环境变量就可以很简单的输入命令了。

```bash
$ export DOCKER_HOST=tcp://192.168.57.110:2376 DOCKER_TLS_VERIFY=1

$ docker info
```

让环境变量永久生效请写入 `~/.bashrc`

>该文件路径也可以通环境变量 `DOCKER_CERT_PATH` 指定。

### fish shell

```bash
$ set -Ux DOCKER_HOST tcp://192.168.57.110:2376
$ set -Ux DOCKER_TLS_VERIFY 1

# 以上命令写入环境变量是永久存在的，通过以下命令删除环境变量

$ set -Ue DOCKER_HOST ; set -Ue DOCKER_TLS_VERIFY
```

# 服务端验证模式

* `tlsverify`, `tlscacert`, `tlscert`, `tlskey` set: Authenticate clients

* `tls`, `tlscert`, `tlskey`: Do not authenticate clients

# 客户端验证模式

* `tls`: Authenticate server based on public/default CA pool

* `tlsverify`, `tlscacert`: Authenticate server based on given CA

* `tls`, `tlscert`, `tlskey`: Authenticate with client certificate, do not authenticate server based on given CA

* `tlsverify`, `tlscacert`, `tlscert`, `tlskey`: Authenticate with client certificate and authenticate server based on given CA


# More Information

* https://deepzz.com/post/dockerd-and-docker-remote-api.html
