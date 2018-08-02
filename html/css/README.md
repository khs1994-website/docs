---
title: CSS
date: 2013-03-01 13:00:00
updated:
comments: true
tags:
- CSS
categories:
- CSS
---

`CSS` 简要教程

<!--more-->

```html
<style type="text/css">
    /*注释*/
</style>
```

# 位置

* 内联式

  ```html
  <p style="color:red"> </p>
  ```

* 嵌入式

  写在当前 `HTML` 中

* 外部式

  ```html
  <link href="main.css" rel="stylesheet" type="text/css" />
  ```

# 选择器

```css
.类名{

}

/* ID 选择器 */

#id{

}

/* 子选择器 第一代子元素 */

.food>li{

}

/* 包含后代选择器 */

.first span{

}

/* > 作用于元素的第一代后代，空格 作用于元素的所有后代 */

/* 伪类选择器 */

a:hover{

}

/* 通用选择器 */

* {
  color: red!important; /*重要性 具有最高权值*/
}

/* 分组选择符 */

h1,span{

}
```

# CSS 属性

## 字体

`font-family`

`font-size`

`font-weight` 字体粗细

`font-style: italic` 斜体

## 颜色

`color`

## 文字

```css
span {
  text-decoration:underline;    /* 下划线 */
  text-decoration:line-through; /* 删除线 */
}
```

`text-indent` 缩进

`line-height` 行高

`letter-spacing` 文字间隔，英文字母之间的间隔

`word-spacing` 单词间距

`text-align:center` 对齐

# 元素分类 `display`

## 块状元素

`display:block`

`<div>` `<p>`

* 每个块级元素都从新的一行开始，并且其后的元素也另起一行。

* 元素的高度、宽度、行高以及顶和底边距都可设置。

* 元素宽度在不设置的情况下，是它本身父容器的100%（和父元素的宽度一致），除非设定一个宽度。

## 内联元素（行内元素）

`display:inline`

`<a>` `<span>`

和其他元素都在一行上；元素的高度、宽度及顶部和底部边距不可设置；元素的宽度就是它包含的文字或图片的宽度，不可改变。

## 内联块状元素

`display:inline-block`

和其他元素都在一行上；元素的高度、宽度、行高以及顶和底边距都可设置。

`<img>` `<input>`

# 盒模型

`border` 边框

`padding` 填充

`margin` 边界

# 布局模型

## 流动模型

`flow`

网页默认的布局模型。

## 浮动模型

`float`

实现让两个块状元素并排显示。

```css
div{
  float: left;
}
```

## 层模型 `position`

`layer`

`position:absolute` 绝对定位

`position:relative` 相对定位

`position:fixed` 固定定位 例如页面浮动广告
