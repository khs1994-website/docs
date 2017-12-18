---
title: Python 安装配置
date: 2015-01-01 13:00:00
tags:
- Python
categories:
- Python
---

本文介绍了 Python 的编译安装方法以及 pip 的使用。

<!--more-->

# 安装

```bash
$ wget https://www.python.org/ftp/python/3.6.2/Python-3.6.2.tgz
$ cd
$ ./configure --prefix=/usr/local/python
$ make
$ make install
```

# pip

pip 是 Python 包管理工具，安装 Python 包非常方便

# pip 下载安装

## 配置

```bash
$ mkdir ~/.pip
$ vi ~/.pip/pip.conf

[global]
index-url = https://pypi.douban.com/simple
[list]  
format=columns
```

## 安装

```bash
# 安装 setuptools

$ wget "url" --no-check-certificate

$ tar -xzvf default.tar.gz

$ cd setuptools* # 依据你的解压目录名而定

$ python setup.py install

# 安装 pip

$ wget "url" --no-check-certificate

$ tar -xzvf pip-1.5.4.tar.gz

$ cd pip-1.5.4

$ python setup.py install
```

# pip 使用

>注意，现在可能更常用的是 `Python3`，为了与 `Python2` 区分，你可能需要将以下命令中的 `pip` 换为 `pip3`。

## 搜索包

```bash
$ pip search SomePackage
```

## 安装包

```bash
$ pip install SomePackage
```

## 查看包详情

```bash
$ pip show SomePackage
```

## 查看已安装的包

```bash
$ pip list
```

## 检查哪些包有可用的更新

 ```bash
$ pip list --outdated
```

## 升级包

```bash
$ pip install --upgrade SomePackage
```

## 卸载包

```bash
$ pip uninstall SomePackage
```

更多的用法请通过 `pip --help` 查看。

# 相关链接

* http://blog.csdn.net/u013066730/article/details/54580948
