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

CSS

<!--more-->

```html
<style type="text/css">

</style>
```

注释

`/*注释*/`

内联式

```html
<p style="color:red"> </p>
```

嵌入式

外部式

```html
<link href="main.css" rel="stylesheet" type="text/css" />
```

类选择器

```css
.类名{

}
```

ID 选择器

```css
#id{

}
```

子选择器 第一代子元素

```html
.food>li{

}
```

包含后代选择器

```html
.first span{

}
```

` > 作用于元素的第一代后代，空格 作用于元素的所有后代`

伪类选择器

```html
a:hover{

}
```

分组选择符

```html
h1,span{

}
```

# CSS 属性

`font-family`

`font-size`

`color`

`font-weight`

`font-style`

`text-decoration`

`text-indent`

`line-height`

`letter-spacing`

`word-spacing`

`text-align:center`

# 元素分类

## 块状元素

`display:block`

## 内联元素（行内元素）

`display:inline`

和其他元素都在一行上；元素的高度、宽度及顶部和底部边距不可设置；元素的宽度就是它包含的文字或图片的宽度，不可改变。

## 内联块状元素

`display:inline-block`

和其他元素都在一行上；元素的高度、宽度、行高以及顶和底边距都可设置。

# 盒模型

`border` 边框

`podding` 填充

`margin` 边界

# 布局模型

`flow` 流动模型

`float` 浮动模型

```css
div{
  float: left;
}
```

`layer` 层模型

## 层模型

`position:absolute` 绝对定位

`position:relative` 相对定位

`position:fixed` 固定定位
