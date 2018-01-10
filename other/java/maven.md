---
title: Maven 使用详解
date: 2016-07-03 13:00:00
updated:
comments: true
tags:
- Java
- Maven
categories:
- Other
- Java
- Maven
---

Maven 简单配置说明。

<!--more-->

# 配置

## 镜像、中央仓库

配置文件位于`~/.m2/settings.xml`

```xml
<mirrors>
        <mirror>
            <id>alimaven</id>
            <name>aliyun maven</name>
            <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
            <mirrorOf>central</mirrorOf>
        </mirror>
        <!--
        <mirror>
          <id>google-maven-central</id>
          <name>Google Maven Central</name>
          <url>https://maven-central.storage.googleapis.com
          </url>
          <mirrorOf>central</mirrorOf>
        </mirror>
        -->
</mirrors>
```

项目配置文件位于项目下 `pom.xml`

```xml
<repositories>
    <repository>
        <id>central</id>
        <name>aliyun maven</name>
        <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <releases>
            <enabled>true</enabled>
        </releases>
        <snapshots>
            <enabled>true</enabled>
        </snapshots>
    </repository>
</repositories>
```

# 命令

## 查看版本

```bash
$ mvn -v
```

## 编译

```bash
$ mvn compile
```

## 测试

```bash
$ mvn test
```

## 打包，生成 .jar 文件

```bash
$ mvn package

$ mvn clean
```

## 安装jar包到本地仓库

```bash
$ mvn install
```

## 自动创建目录骨架

### 交互方式

```bash
$ mvn archetype:generate
```

### 命令模式

```bash
$ mvn archetype:generate -DgroupId=com.khs1994.maven -DartifactId=maven-demo -Dversion=1.0-SNAPSHOT \
    -Dpackage=com.khs1994.maven.demo

# groupId com.khs1994.项目名

# artifactId 项目名-模块名
```

# More Information

* Maven仓库：http://mvnrepository.com/
