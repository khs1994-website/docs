---
title: Vue.js
date: 2013-04-08 13:00:00
updated: null
comments: true
tags:
  - JavaScript
  - Vue.js
categories:
  - JavaScript
---

Vue 简单示例

<!--more-->

```bash
$ npm install --global @vue/cli

$ vue create my-project-name
```

```html
<p>Using mustaches: {{ rawHtml }}</p>
<p>Using v-html directive: <span v-html="rawHtml"></span></p>
```

```html
<div id="app">
  {{ message }}
</div>

<script>
new Vue({
  el: '#app', // 与哪个元素绑定
  data: {
    message: 'Hello Vue!'
  }
})
</script>
```

# v-bind

绑定元素属性

```html
<div id="app-2">
  <span v-bind:title="message">
    鼠标悬停几秒钟查看此处动态绑定的提示信息！
  </span>
</div>

<script>
new Vue({
  el: '#app-2',
  data: {
    message: '页面加载于 ' + new Date().toLocaleString()
  }
})
</script>
```

# v-if

这里，`v-if` 指令将根据表达式 seen 的值的真假来插入/移除 `<p>` 元素。

```html
<div id="app-3">
  <p v-if="seen">现在你看到我了</p>
</div>

<script>
new Vue({
  el: '#app-3',
  data: {
    seen: true
  }
})
</script>
```

# v-for

```html
<div id="app-4">
  <ol>
    <li v-for="todo in todos">
      {{ todo.text }}
    </li>
  </ol>
</div>

<script>
new Vue({
  el: '#app-4',
  data: {
    todos: [
      { text: '学习 JavaScript' },
      { text: '学习 Vue' },
      { text: '整个牛项目' }
    ]
  }
})
</script>
```

# v-on

事件监听器

事件与方法绑定

```html
<div id="app-5">
  <p>{{ message }}</p>
  <button v-on:click="reverseMessage">逆转消息</button>
  <button @clink="reverseMessage">逆转消息</button>
</div>

<script>
new Vue({
  el: '#app-5',
  data: {
    message: 'Hello Vue.js!'
  },
  methods: {
    reverseMessage: function () {
      this.message = this.message.split('').reverse().join('')
    }
  }
})
</script>
```

# v-model

实现表单输入和应用状态之间的双向绑定。

```html
<div id="app-6">
  <p>{{ message }}</p>
  <input v-model="message">
</div>

<script>
new Vue({
  el: '#app-6',
  data: {
    message: 'Hello Vue!'
  }
})
</script>
```

# 组件

```html
<script>
// 定义名为 todo-item 的新组件
Vue.component('todo-item', {
  template: '<li>这是个待办项</li>'
})

Vue.component('todo-item', {
  // todo-item 组件现在接受一个
  // "prop"，类似于一个自定义特性。
  // 这个 prop 名为 todo。
  props: ['todo'],
  template: '<li>{{ todo.text }}</li>'
})
</script>

<ol>
  <!-- 创建一个 todo-item 组件的实例 -->
  <todo-item></todo-item>
</ol>

<div id="app-7">
  <ol>
    <!--
      现在我们为每个 todo-item 提供 todo 对象
      todo 对象是变量，即其内容可以是动态的。
      我们也需要为每个组件提供一个“key”，稍后再
      作详细解释。
    -->
    <todo-item
      v-for="item in groceryList"
      v-bind:todo="item"
      v-bind:key="item.id">
    </todo-item>
  </ol>
</div>

<script>
Vue.component('todo-item', {
  props: ['todo'],
  template: '<li>{{ todo.text }}</li>'
})

var app7 = new Vue({
  el: '#app-7',
  data: {
    groceryList: [
      { id: 0, text: '蔬菜' },
      { id: 1, text: '奶酪' },
      { id: 2, text: '随便其它什么人吃的东西' }
    ]
  }
})
</script>
```
