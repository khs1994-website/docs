---
title: HTML DOM
date: 2013-01-02 13:00:00
updated:
comments: true
tags:
- HTML
categories:
- HTML
---

DOM 文档对象模型。

<!--more-->

# 节点

* 元素 `即 标签` Element 1

* 文本 `<a>文本</a>` Text 3

* 属性 `<a href=""></a>` Attr 2

* 注释节点 `Comment` 8

* 文档节点 `Document` 9

* 文档类型节点 `DocumentType` 10 `<!DOCTYPE html>`

* 文档片段节点 `DocumentFragment` 11

# Javascript

```js
obj.nodeName

obj.nodeValue

obj.attributes[0].nodeName | nodeValue  // 获取元素节点值及属性值

obj.childNodes[0].nodeName | nodeValue  // 获取文本节点值及文本值

document.doctype.nodeName | nodeValue   // 获取文档类型节点值及类型
```
