---
title: Dockerfile 最佳实践 （转载）
date: 2017-06-02 12:00:00
updated:
comments: true
tags:
- Docker
categories:
- Docker
---

本文是 Docker 官方文档中 [Best practices for writing Dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/) 的理解和翻译。

[官方修订历史]( https://github.com/docker/docker.github.io/commits/master/engine/userguide/eng-image/dockerfile_best-practices.md)

翻译：http://blog.csdn.net/candcplusplus/article/details/53366024

`khs1994.com` 对翻译内容进行了修改及更新。

<!--more-->

本文包含了 Docker 官方对编写 `Dockerfile` 的最佳实践和建议。这些建议是为了让你写出高效易用的 `Dockerfile`。Docker 官方强烈建议你遵从这些建议（实际上，如果你是在创建官方镜像，你必须得遵从这些建议）。

阅读该文档需要你已经会通过 `Dockerfile` 构建镜像，并了解 `Dockerfile` 中各条指令的用途。

# 一般性的指南和建议

## 容器应该是短暂的

通过 `Dockerfile` 定义的镜像所产生的容器应该尽可能短暂（生命周期短）。「短暂」意味着可以停止和销毁容器，并且创建一个新容器并部署好所需的设置和配置工作量应该是极小的。

## 使用 `.dockerignore` 文件

一般最好的方法是将 `Dockerfile` 放置在一个单独的空目录下。然后，将构建镜像所需要的文件添加到目录下。为了提高构建的效率，你也可以在目录下创建一个 `.dockerignore` 文件来指定要忽略的文件和目录。`.dockerignore` 文件的排除模式语法和 Git 的 `.gitignore` 文件类似。

## 使用 multi-stage builds

Docker 17.05+

[multi-stage builds](https://docs.docker.com/engine/userguide/eng-image/multistage-build/)

## 避免安装不必要的包

为了降低复杂性、减少依赖、减小文件大小、节约构建时间，你应该避免安装任何不必要的包，不要仅仅为了「锦上添花」而安装某个包。例如，不要在数据库镜像中包含一个文本编辑器。

## 一个容器只运行一个进程

在大多数情况下，你应该保证在一个容器中只运行一个进程。将多个应用解耦到不同容器中，可以保证应用的横向扩展性和重用容器。

如果你一个服务依赖于另一个服务，可以使用 [Docker 容器网络](https://docs.docker.com/engine/userguide/networking/) 来连接容器。

`khs1994.com` 备注：官方建议不再使用 `--link` ，详情参见 [Learn how to connect Docker containers together](https://github.com/docker/docker.github.io/blob/master/engine/userguide/networking/default_network/dockerlinks.md)。

[官方修订详情](https://github.com/docker/docker.github.io/commit/998ad7b90efaa50a1070103f96f8ad3404c05323#diff-d7e76b94fae5bc112139bb1b1e421f99)

## 镜像层数尽可能少

你需要在 Dockerfile 可读性（也包括长期的可维护性）和减少层数之间做一个平衡。明智并谨慎地考虑你所使用的层数。

## 将多行参数排序

将多行参数按字母顺序排序（比如要安装多个包时）。这可以帮助你避免重复包含同一个包，更新包列表时也更容易。也便于 PRs 阅读和审查。建议在反斜杠符号 `\` 之前添加一个空格，以增加可读性。

下面来自 `buildpack-deps` 镜像的例子：

```docker
RUN apt-get update && apt-get install -y \
  bzr \
  cvs \
  git \
  mercurial \
  subversion
```

## 构建缓存

在镜像的构建过程中，Docker 会遍历 `Dockerfile` 文件中的指令，然后按顺序执行。在执行每条指令之前，Docker 都会在缓存中查找是否已经存在可重用的镜像，如果有就使用现存的镜像，不再重复创建。如果你不想在构建过程中使用缓存，你可以在 `docker build` 命令中使用 `--no-cache=true` 选项。

但是，如果你想在构建的过程中使用缓存，你得明白什么时候会，什么时候不会找到匹配的镜像。Docker 遵循的基本规则如下：

* 从一个基础镜像开始（`FROM` 指令指定），下一条指令将和该基础镜像的所有子镜像进行匹配，检查这些子镜像被创建时使用的指令是否和被检查的指令完全一样。如果不是，则缓存失效。
* 在大多数情况下，只需要简单地对比 `Dockerfile` 中的指令和子镜像。然而，有些指令需要更多的检查和解释。
* 对于 `ADD` 和 `COPY` 指令，镜像中对应文件的内容也会被检查，每个文件都会计算出一个校验和。文件的最后修改时间和最后访问时间不会纳入校验。在缓存的查找过程中，会将这些校验和和已存在镜像中的文件校验和进行对比。如果文件有任何改变，比如内容和元数据，缓存失效。
* 除了 `ADD` 和 `COPY` 指令，缓存匹配过程不会查看临时容器中的文件来决定缓存是否匹配。例如，当执行完 `RUN apt-get -y update` 指令后，容器中一些文件被更新，但 Docker 不会检查这些文件。这种情况下，只有指令字符串本身被用来匹配缓存。

一旦缓存失效，所有后续的 `Dockerfile` 指令都将产生新的镜像，缓存不会被使用。

# Dockerfile 指令

下面针对 `Dockerfile` 中各种指令的最佳编写方式给出建议。

## FROM

只要有可能，请使用当前官方仓库作为构建你镜像的基础。我们推荐使用 [Debian image](https://hub.docker.com/_/debian/)，因为它被严格控制并保持最小尺寸（当前小于 150 mb），但仍然是一个完整的发行版。

## LABEL

你可以给镜像添加标签来帮助组织镜像、记录许可信息、辅助自动化构建，或者因为其他的原因。每个标签一行，由 `LABEL` 开头加上一个或多个标签对。下面的示例展示了各种不同的可能格式。注释内容是解释。

>注意：如果你的字符串中包含空格，将字符串放入引号中或者对空格使用转义。如果字符串内容本身就包含引号，必须对引号使用转义。

```docker
# Set one or more individual labels
LABEL com.example.version="0.0.1-beta"

LABEL vendor="ACME Incorporated"

LABEL com.example.release-date="2015-02-12"

LABEL com.example.version.is-production=""

# Set multiple labels on one line
LABEL com.example.version="0.0.1-beta" com.example.release-date="2015-02-12"

# Set multiple labels at once, using line-continuation characters to break long lines
LABEL vendor=ACME\ Incorporated \
      com.example.is-beta= \
      com.example.is-production="" \
      com.example.version="0.0.1-beta" \
      com.example.release-date="2015-02-12"
```

关于标签可以接受的键值对，参考 [Understanding object labels](https://docs.docker.com/engine/userguide/labels-custom-metadata/)。关于查询标签信息，参考 [Managing labels on objects](https://docs.docker.com/engine/userguide/labels-custom-metadata/#managing-labels-on-objects)。

## RUN

一如往常，保持你的 `Dockerfile` 文件更具可读性，可理解性，以及可维护性，将长的或复杂的 `RUN` 声明用反斜杠分割成多行。

### apt-get

也许 `RUN` 指令最常见的用例是安装包用的 `apt-get`。因为 `RUN apt-get` 指令会安装包，所以有几个问题需要注意。

不要使用 `RUN apt-get upgrade` 或 `dist-upgrade`，因为许多基础镜像中的「必须」包不会在一个非特权容器中升级。如果基础镜像中的某个包过时了，你应该联系它的维护者。如果你确定某个特定的包，比如 `foo`，需要升级，使用 `apt-get install -y foo` 就行，该指令会自动升级 foo 包。

永远将 `RUN apt-get update` 和 `apt-get install` 组合成一条 `RUN` 声明，例如：

```docker
RUN apt-get update && apt-get install -y \
        package-bar \
        package-baz \
        package-foo
```

将 `apt-get update` 放在一条单独的 `RUN` 声明中会导致缓存问题以及后续的 `apt-get install` 失败。比如，假设你有一个 `Dockerfile` 文件：

```docker
FROM ubuntu:14.04

RUN apt-get update

RUN apt-get install -y curl
```

构建镜像后，所有的层都在 Docker 的缓存中。假设你后来又修改了其中的 `apt-get install` 添加了一个包：

```docker
FROM ubuntu:14.04

RUN apt-get update

RUN apt-get install -y curl nginx
```

Docker 发现修改后的 `RUN apt-get update` 指令和之前的完全一样。所以，`apt-get update` 不会执行，而是使用之前的缓存镜像。因为 `apt-get update` 没有运行，后面的 `apt-get install` 可能安装的是过时的 `curl` 和 `nginx` 版本。

使用 `RUN apt-get update && apt-get install -y` 可以确保你的 Dockerfiles 每次安装的都是包的最新的版本，而且这个过程不需要进一步的编码或额外干预。这项技术叫作「cache busting」。你也可以显示指定一个包的版本号来达到 cache-busting。这就是所谓的固定版本，例如：

```docker
RUN apt-get update && apt-get install -y \
    package-bar \
    package-baz \
    package-foo=1.3.*
```

固定版本会迫使构建过程检索特定的版本，而不管缓存中有什么。这项技术也可以减少因所需包中未预料到的变化而导致的失败。

下面是一个 `RUN` 指令的示例模板，展示了所有关于 `apt-get` 的建议。

```docker
RUN apt-get update && apt-get install -y \
    aufs-tools \
    automake \
    build-essential \
    curl \
    dpkg-sig \
    libcap-dev \
    libsqlite3-dev \
    mercurial \
    reprepro \
    ruby1.9.1 \
    ruby1.9.1-dev \
    s3cmd=1.1.* \
 && rm -rf /var/lib/apt/lists/*
```

其中 `s3cmd` 指令指定了一个版本号 `1.1.*`。如果之前的镜像使用的是更旧的版本，指定新的版本会导致 `apt-get udpate` 缓存失效并确保安装的是新版本。

另外，清理掉 apt 缓存，删除 `var/lib/apt/lists` 可以减小镜像大小。因为 `RUN` 指令的开头为 `apt-get udpate` ，包缓存总是会在 `apt-get install` 之前刷新。

> 注意：官方的 Debian 和 Ubuntu 镜像会自动运行apt-get clean，所以不需要显示的调用 apt-get clean。

### 使用 pipes

## CMD

`CMD` 指令用于执行目标镜像中包含的软件，可以包含参数。`CMD` 大多数情况下都应该以 `CMD ["executable", "param1", "param2"…]` 的形式使用。因此，如果创建镜像的目的是为了部署某个服务(比如 Apache、Rails…)，你可能会执行类似于 `CMD ["apache2","-DFOREGROUND"]` 形式的命令。实际上，我们建议任何服务镜像都使用这种形式的命令。

多数情况下，`CMD` 都需要一个交互式的 shell(bash,Python,perl,etc)，例如 `CMD ["perl","-de0"]`，或者 `CMD ["PHP","-a"]`。使用这种形式意味着，当你执行类似 `docker run -it python` 时，你会进入一个准备好的 shell 中。`CMD` 应该在极少的情况下才能以 `CMD ["param","param"]` 的形式与 `ENTRYPOINT` 协同使用，除非你和你的预期用户都对 `ENTRYPOINT` 的工作方式十分熟悉。

## EXPOSE

`EXPOSE` 指令用于指定容器将要监听连接的端口。因此，你应该为你的应用程序使用常见熟知的端口。例如，提供 Apache web 服务的镜像将使用 `EXPOSE 80`，而提供 MongoDB 服务的镜像使用 `EXPOSE 27017`，等等。

对于外部访问，镜像用户可以在执行 `docker run` 时使用一个标志来指示如何将指定的端口映射到所选择的端口。对于容器链接，Docker 提供环境变量从接收容器回溯到源容器（例如，`MYSQL_PORT_3306_TCP`）。

## ENV

为了便于新程序运行，你可以使用 `ENV` 来为容器中安装的程序更新 `PATH` 环境变量。例如 `ENV PATH /usr/local/nginx/bin:$PATH` 将确保 `CMD ["nginx"]` 能正确运行。

`ENV` 指令也可用于为你想要容器化的服务提供必要的环境变量，比如 Postgres 需要的 `PGDATA`。

最后，`ENV` 也能用于设置常见的版本号，以便维护 version bumps，参考下面的示例：

```docker
ENV PG_MAJOR 9.3

ENV PG_VERSION 9.3.4

RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && …

ENV PATH /usr/local/postgres-$PG_MAJOR/bin:$PATH
```

类似于程序中的常量（与硬编码的值相对），这种方法可以让你只需改变单条 `ENV` 指令来自动改变容器中的软件版本。

## ADD 和 COPY

虽然 `ADD` 和 `COPY` 功能类似，但一般优先使用 `COPY`。因为它比 `ADD` 更透明。`COPY` 只支持简单将本地文件拷贝到容器中，而 `ADD` 有一些并不明显的功能（比如本地 tar 提取和远程 URL 支持）。因此，`ADD` 的最佳用例是将本地 tar 文件自动提取到镜像中，例如 `ADD rootfs.tar.xz`。

如果你的 `Dockerfile` 有多个步骤需要使用上下文中不同的文件。单独 `COPY` 每个文件，而不是一次性 `COPY` 完。这将保证每个步骤的构建缓存只在特定的文件变化时失效。例如：

```docker
COPY requirements.txt /tmp/

RUN pip install --requirement /tmp/requirements.txt

COPY . /tmp/
```

如果将 `COPY . /tmp/` 放置在 `RUN` 指令之前，只要 `.` 目录中任何一个文件变化，都会导致后续指令的缓存失效。

为了让镜像尽量小，最好不要使用 `ADD` 指令从远程 `URL` 获取包，而是使用 `curl` 和 `wget`。这样你可以在文件提取完之后删掉不再需要的文件，可以避免在镜像中额外添加一层。（译者注：`ADD` 指令不能和其他指令合并，所以前者 `ADD` 指令会单独产生一层镜像。而后者可以将获取、提取、安装、删除合并到同一条 `RUN` 指令中，只有一层镜像。）比如，你应该尽量避免下面这种用法：

```docker
ADD http://example.com/big.tar.xz /usr/src/things/

RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things

RUN make -C /usr/src/things all
```

而是使用下面这种：

```docker
RUN mkdir -p /usr/src/things \
    && curl -SL http://example.com/big.tar.xz \
    | tar -xJC /usr/src/things \
    && make -C /usr/src/things all
```

上面使用的管道操作，所以没有中间文件需要删除。

对于其他不需要 `ADD` 的自动提取（tar）功能的文件或目录，你应该坚持使用 `COPY`。

## ENTRYPOINT

`ENTRYPOINT` 的最佳用处是设置镜像的主命令，允许将镜像当成命令本身来运行（用 `CMD` 提供默认选项）。

例如，下面的示例镜像提供了命令行工具 `s3cmd`:

```docker
ENTRYPOINT ["s3cmd"]

CMD ["--help"]
```

现在该镜像直接这么运行，显示命令帮助：

```bash
$ docker run s3cmd
```

或者提供正确的参数来执行某个命令：

```bash
$ docker run s3cmd ls s3://mybucket
```

这很有用，因为镜像名还可以当成命令行的参考。

`ENTRYPOINT` 指令也可以结合一个辅助脚本使用，和前面命令行风格类似，即使启动工具需要不止一个步骤。

例如，Postgres 官方镜像使用下面的脚本作为 `ENTRYPOINT`：

```bash
#!/bin/bash
set -e

if [ "$1" = 'postgres' ]; then
    chown -R postgres "$PGDATA"

    if [ -z "$(ls -A "$PGDATA")" ]; then
        gosu postgres initdb
    fi

    exec gosu postgres "$@"
fi

exec "$@"
```

>注意：该脚本使用了 Bash 的内置命令 exec，所以最后运行的进程就是容器的 PID 为1的进程。这样，进程就可以接收到任何发送给容器的 Unix 信号了。

该辅助脚本被拷贝到容器，并在容器启动时通过 `ENTRYPOINT` 执行：

```docker
COPY ./docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]
```


该脚本可以让用户用几种不同的方式和 Postgres 交互。

你可以很简单地启动 Postgres：

```bash
$ docker run postgres
```

也可以执行 Postgres 并传递参数：

```bash
$ docker run postgres postgres --help
```

最后，你还可以启动另外一个完全不同的工具，比如 Bash：

```bash
$ docker run --rm -it postgres bash
```

## VOLUME

`VOLUME` 指令用于暴露任何数据库存储区域，配置文件，或容器创建的文件和目录。强烈建议使用 `VOLUME` 来管理镜像中的可变部分和镜像用户可以改变部分。

## USER

如果某个服务不需要特权执行，建议使用 `USER` 指令切换到非 root 用户。先在 `Dockerfile` 中使用类似 `RUN groupadd -r postgres && useradd -r -g postgres postgres` 的指令创建用户和用户组。

>注意：在镜像中，用户和用户组每次被分配的 UID/GID 都是不确定的，下次重新构建镜像时被分配到的 UID/GID 可能会不一样。如果要依赖确定的 UID/GID，你应该显示的指定一个 UID/GID。

你应该避免使用 `sudo`，因为它不可预期的 TTY 和信号转发行为可能造成的问题比解决的还多。如果你真的需要和 `sudo` 类似的功能（例如，以 root 权限初始化某个守护进程，以非 root 权限执行它），你可以使用 [gosu](https://github.com/tianon/gosu)。

最后，为了减少层数和复杂度，避免频繁地使用 `USER` 来回切换用户。

## WORKDIR

为了清晰性和可靠性，你应该总是在 `WORKDIR` 中使用绝对路径。另外，你应该使用 `WORKDIR` 来替代类似于 `RUN cd ... && do-something` 的指令，后者难以阅读、排错和维护。

## ONBUILD

`ONBUILD` 中的命令会在当前镜像的子镜像构建时执行。可以把 `ONBUILD` 命令当成父镜像的 `Dockerfile` 传递给子镜像的 `Dockerfile` 的指令。

在子镜像的构建过程中，Docker 会在执行 `Dockerfile` 中的任何指令之前，先执行父镜像通过 `ONBUILD` 传递的指令。

当从给定镜像构建新镜像时，`ONBUILD` 指令很有用。例如，你可能会在一个语言栈镜像中使用 `ONBUILD`，语言栈镜像用于在 `Dockerfile` 中构建用户使用相应语言编写的任意软件，正如 Ruby 的 `ONBUILD` 变体

使用 `ONBUILD` 构建的镜像应用一个单独的标签，例如：`ruby:1.9-onbuild` 或 `ruby:2.0-onbuild`。

在 `ONBUILD` 中使用 `ADD` 或 `COPY` 时要格外小心。如果新的构建上下文中缺少对应的资源，"onbuild" 镜像会灾难性地失败。添加一个单独的标签，允许 `Dockerfile` 的作者做出选择，将有助于缓解这种情况。

# 官方仓库示例

这些官方仓库的 Dockerfile 都是参考典范：

* [Go](https://hub.docker.com/_/golang/)
* [Perl](https://hub.docker.com/_/perl/)
* [Hy](https://hub.docker.com/_/hylang/)
* [Ruby](https://hub.docker.com/_/ruby/)

# 其他资源

* [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
* [More about Base Images](https://docs.docker.com/engine/userguide/eng-image/baseimages/)
* [More about Automated Builds](https://docs.docker.com/docker-hub/builds/)
* [Guidelines for Creating Official Repositories](https://docs.docker.com/docker-hub/official_repos/)
