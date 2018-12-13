---
title: TypeScript
date: 2018-12-13 13:00:00
updated: null
comments: true
tags:
  - TypeScript
categories:
  - TypeScript
---

`TypeScript` 几个知识点。

<!--more-->

* 当命令行上 **指定了输入文件** 时，`tsconfig.json` 文件会被忽略。

* TypeScript 与 ECMAScript 2015 一样，**任何包含顶级 import 或者 export 的文件** 都被当成一个模块。相反地，如果一个文件不带有顶级的 import 或者 export 声明，那么它的内容被视为全局可见的（因此对模块也是可见的）。

* 要想描述非 TypeScript 编写的类库的类型，我们需要声明类库所暴露出的 API。我们叫它声明因为它 **不是** `外部程序` 的 **具体实现**

* `type xxx` 类型别名。
