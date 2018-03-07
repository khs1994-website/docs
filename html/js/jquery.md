---
title: jQuery
date: 2013-04-05 13:00:00
tags:
  - JavaScript
categories:
  - JavaScript
---

```js
$(selector).action(

);
```

<!--more-->

```js
$(this).hide(); 当前元素

// 元素

$("p").show(); 所有 <p> 元素

$("p:first").toggle(); 第一个 <p> 元素 显示被隐藏的元素，并隐藏已显示的元素

$("ul li:first") 选取第一个 <ul> 元素的第一个 <li> 元素

$("ul li:first-child") 选取每个 <ul> 元素的第一个 <li> 元素

// class

$("p.test").hide(); class="test" 的 <p> 元素

// id

$("#test").hide(); id="test" 的元素

// 属性

$("[href]").hide();

$("a[target = '_blank']")

$("a[target != '_blank']")

// 类型

$(":button") 选取所有 type="button" 的 <input> 元素 和 <button> 元素

$("tr:even") 偶数位置的 <tr> 元素

$("tr:odd") 奇数位置的 <tr> 元素

$(document).ready(function(){
    //
});
```

# 事件

* click

* dblclick

* mouseenter 当鼠标指针穿过元素时

* mouseleave 当鼠标指针离开元素时

* mousedown 当鼠标指针移动到元素上方，并按下鼠标按键时

* mouseup 当在元素上松开鼠标按钮时

* hover

* keypress 在键盘上按下一个按键，并产生一个字符时发生

* keydown keyup在键盘上按下某键时发生 用户松开某一个按键时触发

* submit

* change

* focus blur 当元素获得焦点时

* load

* resize

* scroll

* unload

# 淡入淡出

```js
fadeIn() 淡入已隐藏的元素

fadeOut() 淡出可见元素

fadeToggle() 在 fadeIn() 与 fadeOut() 方法之间进行切换

fadeTo() 渐变为给定的不透明度（值介于 0 与 1 之间）。
```

# 滑动

```js
slideDowm() 向下滑动元素

slideUp() 向上滑动元素

slideToggle()
```

# 链

```js
$("#p1").css("color","red").slideUp(2000).slideDown(2000);
```

# 捕获内容

```js
$("#p").html() 所选元素的文本内容

$("#p").text() 所选元素的内容

$("#p").val() 表单字段的值

$("#p").attr() 获取属性值
```

# 添加元素

```js
append() 在被选元素的结尾插入内容

prepend() 开头

after() 之后

before() 之前
```

# 删除元素

```js
remove() 删除被选元素（及其子元素）

empty() 从被选元素中删除子元素
```

# 获取并设置 CSS 类

```js
addClass() 向被选元素添加一个或多个类

removeClass()  从被选元素删除一个或多个类

toggleClass() 对被选元素进行添加/删除类的切换操作

css() 设置或返回样式属性

$("p").css("background-color")
```

# 尺寸

```js
width()

height()

innerWidth()

innerHeight()

outerWidth()

outerWidth(true)

outerHeight()

outerHeight(true)
```
