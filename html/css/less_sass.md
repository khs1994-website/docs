---
title: CSS 预处理器 Less Cass Stylus
date: 2013-03-10 13:00:00
updated:
comments: true
tags:
- CSS
categories:
- CSS
---

`Sass` `Less` `Stylus`

<!--more-->

# 安装

```bash
$ npm install -g less

$ gem install sass

$ npm install -g stylus
```

# Less

## 导入

```less
@import "main";      // main.less 如果为 less 文件，后缀可省略
@import "typo.css";
```

## 变量

```less
@a: 1;

#header{
  color: @a;
  // comments

 /**
   * comments
  */
}

```

## 混合

## 嵌套

## 运算

```less
@a: 5cm - 1cm;

// + - * /
```

## 内置函数

## 作用域

# Sass

有两种格式的后缀名，这里以 `.scss` 后缀为例

```scss

```
