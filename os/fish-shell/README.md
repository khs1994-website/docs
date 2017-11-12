---
title: Fish Shell 安装配置
date: 2017-07-24 13:00:00
updated:
comments: true
tags:
- fish shell
categories:
- OS
- fish shell
---

fish-shell GitHub：https://github.com/fish-shell/fish-shell

oh-my-fish GitHub：https://github.com/oh-my-fish/oh-my-fish

<!--more-->

两个都安装，具体编译安装查看项目 `README.md` 文件

# 配置

所有配置建议在 `~/.config/fish/config.fish` 中进行。以下命令中，前边加`$`的在终端中输入命令，不加的写入配置文件中

## 环境变量env

通过 `set -x` 命令设置环境变量  
只对当前 shell 设定环境变量:

```bash
$ set -x VISUAL vim
```

全局生效:

```bash
$ set -Ux VISUAL vim
```

## PATH

我习惯于将`PATH`写入配置文件中

```bash
set -gx fish_user_paths $fish_user_paths /usr/local/sbin /usr/local/bin
```

## 别名

兼容其他Shell`alias`设置方法，例如

```bash
alias nginx="sudo nginx ; php-fpm"
```

使用`abbr`，执行`abbr -h`查看帮助信息。

```bash
$ abbr -a l ls -lhS
```

即可添加 l 为 ls -lhS 的缩写。

## 变量赋值 set

`-l` `-g` `-U` `-x` `-u`

```bash
$ set -xg
# Prints all global, exported variables.

$ set foo hi
# Sets the value of the variable $foo to be 'hi'.
# 将 hi 赋值给变量 $foo

$ set -e smurf
# Removes the variable $smurf
# 删除变量
```

# 相关链接

* 官方文档：http://www.fishshell.com/docs/current/index.html  
* https://zhuanlan.zhihu.com/p/26157081
