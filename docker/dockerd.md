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

GitHub：https://github.com/khs1994-docker/dockerd-tls

本机：`macOS`

远程机：使用 `VirtualBox` 虚拟 `CoreOS` (IP `192.168.57.110`)

目标：能在 `macOS` 远程操作 `CoreOS`。（注意不是 SSH 远程登录）。`dockerd` 命令仅能在 `Linux` 下使用。

<!--more-->

官方文档：https://docs.docker.com/edge/engine/reference/commandline/dockerd/

**本文适合有一定 Linux 基础的读者阅读，如果出现错误，请将各种操作之前修改过的文件恢复原状并删除新增的环境变量。**

我们已经知道 Docker 是客户端/服务端架构。一般情况下我们使用的 Docker 客户端/服务端都在本机（macOS、Windows 实际上是在本机启动了一个虚拟机，这里指 Linux）。本文所指的情况是 Docker 客户端与服务端不在同一主机上。

# 非安全的连接方式

先介绍 `非安全` 的连接方式。

## 服务端配置

配置时选择以下两种方法之一

### 通常的配置方法（不推荐）

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

重新启动 Docker。

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl restart docker
```

>注意：我们这里修改了 `docker.service` 文件，而每次 Docker 升级都会重置此文件，大家不想每次升级 Docker 之后再修改 `docker.service`，可以采用下面的方法。

### 借鉴 CoreOS 官方文档提供的方法(推荐)

官方文档：https://coreos.com/os/docs/latest/customizing-docker.html

新建 `/etc/systemd/system/docker-tcp.socket` 文件

```yaml
[Unit]
Description=Docker Socket for the API

[Socket]
# ListenStream=127.0.0.1:2375
ListenStream=2375
BindIPv6Only=both
Service=docker.service

[Install]
WantedBy=sockets.target
```

重新启动服务

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl enable docker-tcp.socket
$ sudo systemctl stop docker
$ sudo systemctl start docker-tcp.socket
$ sudo systemctl start docker
```

>注意：这种方法必须先启动 docker-tcp.socket，再启动 Docker，一定要注意启动顺序！

Systemd socket 详情请查看：http://www.jinbuguo.com/systemd/systemd.socket.html

## 在客户端测试连接

在 `macOS` （下文中 `macOS`一律代指 Docker 客户端）上使用以下命令

```bash
$ docker -H 192.168.57.110:2375 info
```

成功输出信息，证明客户端可以成功连接到远程的服务端。

在 `macOS` 上远程操作 `CoreOS` 上的 `Docker` 每次执行命令时必须加上 `-H` 参数(这样太麻烦，我们可以通过将 Docker 命令 `参数` 配置成 `环境变量` 来简化命令)。

在 `macOS` 上执行如下命令。

```bash
$ export DOCKER_HOST="tcp://0.0.0.0:2375"

$ docker info
```

这里写入的变量是临时生效的，重新登录环境变量就消失了（下文同理，之后不再赘述），让环境变量永久生效请写入 `~/.bashrc`。

### fish shell

本人 `macOS` 上使用的 shell 是 fish，这里记录一下 fish 中的操作，使用 bash 的读者请忽略 fish 相关内容。

```bash
$ set -Ux DOCKER_HOST "tcp://0.0.0.0:2375"

# 以上命令写入的环境变量是永久存在的，通过以下命令删除环境变量

$ set -Ue DOCKER_HOST
```

# 配置安全连接

官方文档：https://docs.docker.com/engine/security/https/

上面我们配置的远程连接是不安全的，只能用于测试环境中。在生产环境中需要配置 `TLS` 安全连接，只有拥有密钥的客户端，才能连接到远程的服务端。

## 服务端配置

只能使用 Linux 下的 `openssl` 生成密钥，macOS 下的不可以。在 `CoreOS` 下执行以下操作

### 手动执行命令生成证书（不推荐）

这一步较复杂，你可以跳过这一方法，使用容器生成证书。此方法来自 Docker 官方文档 https://docs.docker.com/engine/security/https/。

文件总览

```bash
├── ca-key.pem       # 妥善保管，连接时用不到
├── ca.pem           # clent & server
├── ca.srl           # 用不到
├── cert.pem         # client
├── client.csr       # 请求文件
├── extfile.cnf      # 配置文件
├── key.pem          # client
├── server-cert.pem  # server
├── server.csr       # 请求文件
└── server-key.pem   # server
```

```bash
# 生成 CA 私钥

$ openssl genrsa -aes256 -out ca-key.pem 4096

# 需要输入两次密码(自定义)

# 生成 CA 公钥

$ openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem

# 输入上一步中设置的密码，然后需要填写一些信息

# 下面是服务器证书生成

# 生成服务器私钥

$ openssl genrsa -out server-key.pem 4096

# 用私钥生成证书请求文件

$ openssl req -subj "/CN=localhost" -sha256 -new -key server-key.pem -out server.csr

$ echo subjectAltName = DNS:localhost,DNS:www.khs1994.com,DNS:tencent,IP:192.168.199.100,IP:192.168.57.110,IP:127.0.0.1 >> extfile.cnf

# 允许服务端哪些 IP 或 host 能被客户端连接，下文会进行测试。

# DNS 我也不是很理解，这里配置 localhost ，公共 DNS 解析的域名，/etc/hosts 文件中的列表进行测试。

$ echo extendedKeyUsage = serverAuth >> extfile.cnf

# 用 CA 来签署证书

$ openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out server-cert.pem -extfile extfile.cnf

# 再次输入第一步设置的密码

# 下面是客户端证书文件生成

# 生成客户端私钥

$ openssl genrsa -out key.pem 4096

# 用私钥生成证书请求文件  

$ openssl req -subj '/CN=client' -new -key key.pem -out client.csr

$ echo extendedKeyUsage = clientAuth >> extfile.cnf

# 用 CA 来签署证书

$ openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out cert.pem -extfile extfile.cnf

# 再次输入第一步设置的密码

# 删除文件，更改文件权限

$ rm -v client.csr server.csr

$ chmod -v 0400 ca-key.pem key.pem server-key.pem

$ chmod -v 0444 ca.pem server-cert.pem cert.pem
```

把 `ca.pem` `server-cert.pem` `server-key.pem` 三个文件移动到 `/etc/docker/` 文件夹中。

### 使用容器生成证书（推荐）

GitHub：https://github.com/khs1994-docker/dockerd-tls

方法来自 `CoreOS` 官方文档：https://coreos.com/os/docs/latest/generate-self-signed-certificates.html

>既然使用容器那就可以在任何系统运行，只要把对应文件放到客户端和服务端即可

```bash
$ git clone --depth=1 https://github.com/khs1994-docker/dockerd-tls.git
$ cd dockerd-tls
```

在 `./cfssl/*.json` 中配置好 `CN` `hosts`。

```bash
$ docker-compose up cfssl
```

命令执行完毕之后在 `./cfssl/cert` 文件夹中可以看到证书文件，修改文件权限。

```bash
$ chmod -v 0400 ca-key.pem key.pem server-key.pem

$ chmod -v 0444 ca.pem server-cert.pem cert.pem
```

把 `ca.pem` `server-cert.pem` `server-key.pem` 三个文件移动到服务端 `/etc/docker/` 文件夹中。

根据本文第一步选择的方法选择以下对应的方法

### 通常的配置方法（不推荐）

修改 `CoreOS` 上的 `daemon.json` 文件。

>注意：非安全连接使用的是 `2375` 端口，安全连接使用的是 `2376` 端口。当然这是推荐的端口配置，你可以配置任何端口！

```json
{
  "tlsverify": true,
  "tlscert": "/etc/docker/server-cert.pem",
  "tlskey": "/etc/docker/server-key.pem",
  "tlscacert": "/etc/docker/ca.pem",
  "hosts":[
    "unix:///var/run/docker.sock",
    "tcp://0.0.0.0:2376"
  ]
}
```

重新启动 Docker

```bash
$ sudo systemctl restart docker
```

### 借鉴 CoreOS 官方文档的方法（推荐）

首先需要修改 `/etc/systemd/system/docker-tcp.socket` 文件内容

```yaml
ListenStream=2375

# 修改为

ListenStream=2376
```

修改 `CoreOS` 上的 `daemon.json` 文件。

```json
{
  "tlsverify": true,
  "tlscert": "/etc/docker/server-cert.pem",
  "tlskey": "/etc/docker/server-key.pem",
  "tlscacert": "/etc/docker/ca.pem"
}
```

重新启动服务。

```bash
$ sudo systemctl daemon-reload
$ sudo systemctl stop docker
$ sudo systemctl restart docker-tcp.socket
$ sudo systemctl restart docker
```

> 上文已经提到了启动顺序，这里提示一下，不再赘述。

## 客户端远程安全连接

将 `ca.pem` `cert.pem`(或 `client.pem`) `key.pem`(或 `client-key.pem`) 三个文件通过 `scp` 下载到 `macOS`

在 `macOS` 执行以下命令，密钥路径请根据实际情况填写。

```bash
$ docker --tlsverify \
  --tlscacert=~/test/ca.pem \
  --tlscert=~/test/cert.pem \
  --tlskey=~/test/key.pem \
  -H=192.168.57.110:2376 \
  info
```

### 把密钥放入 `~/.docker` 文件夹中

每次操作需要跟那么多参数，太麻烦了。我们可以把 `ca.pem` `cert.pem` `key.pem` 三个文件放入客户端 `~/.docker` 中，然后配置环境变量就可以简化命令了。

```bash
$ export DOCKER_HOST=tcp://192.168.57.110:2376 DOCKER_TLS_VERIFY=1

$ docker info
```

>你也可以选择其他路径，请通过环境变量 `DOCKER_CERT_PATH` 指定。

### 报错详情

#### 不使用安全连接

```bash
$ docker -H 192.168.57.110:2376 info
Get http://192.168.57.110:2376/v1.34/containers/json?all=1: malformed HTTP response "\x15\x03\x01\x00\x02\x02".
* Are you trying to connect to a TLS-enabled daemon without TLS?
```

#### 在非允许列表 IP 中登录

假如远程服务器还有一个 IP `10.141.20.83` ，现在我们尝试使用这个 IP 作为服务端地址，看看客户端能否连接到。

```bash
$ docker -H 10.141.20.83:2376 info
error during connect: Get https://10.141.20.83:2376/v1.34/info: x509: certificate is valid for 192.168.57.110, 192.168.199.100, 127.0.0.1, not 10.141.20.83
```

#### 在非允许列表 Host 中登录

```bash
$ docker -H localhost:2376 info
error during connect: Get https://localhost:2375/v1.34/info: x509: certificate is valid for coreos1, not localhost
```

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

# 测试远程构建 Docker 镜像

在 `macOS` 新建 demo 文件夹并进入。

我们首先建一个文本文件 `test.txt`

```bash
hello!
```

然后新建一个简单的 `Dockerfile` 文件

```docker
FROM busybox

COPY ./test.txt /

CMD cat /test.txt
```

按照前面的方法设置好环境变量，这里不再赘述。

```bash
$ docker -H 192.168.57.110:2375 --tlsverify build -t khs1994/busybox .
```

## 在远程服务端查看

SSH 登录到 `CoreOS`（这里为了便于理解，SSH 到远程服务器操作）。

```bash
$ docker image ls
REPOSITORY                             TAG                 IMAGE ID            CREATED             SIZE
khs1994/busybox                        latest              368d23df8500        10 seconds ago      1.13MB
```

我们已经查看到了镜像。

```bash
$ docker run -it --rm khs1994/busybox
hello!
```

运行成功。

# 客户端恢复原状

你如果想在 `macOS` 操作本地的服务端，请将上面配置的环境变量删除，这里不再赘述。

# More Information

* https://deepzz.com/post/dockerd-and-docker-remote-api.html
