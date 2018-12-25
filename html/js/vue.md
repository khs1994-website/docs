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
let vm = new Vue({
  el: '#app', // 与哪个元素绑定
  data: {
    message: 'Hello Vue!'
  }
});

vm.message = 'Hello World';

vm.$data;
vm.$el;

</script>
```

# v-bind

绑定元素属性

```html
<span v-bind:title="message">
<!-- 简写 -->
<a :href="url">url</a>

<!-- 上面的语法表示 active 这个 class 存在与否将取决于数据属性 isActive 的值 -->
<span v-bind:class="{ active: isActive, 'text-danger': hasError}"></span>
```

# v-if

这里，`v-if` 指令将根据表达式 seen 的值的真假来插入/移除 `<p>` 元素。

```html
<p v-if="seen">现在你看到我了</p>
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
<button v-on:click="reverseMessage">逆转消息</button>
<!-- 简写 -->
<button @clink="reverseMessage">逆转消息</button>
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

```js
Vue.component('todo-item',{
  props: ['todo']
  template: '<li>{{todo.text}}</li>'
});
```

# 计算属性

```js
<p>{{prop}}</p>

new Vue({
  computed: {
    prop(){
      return '';
    },
    // getter setter
    prop2: {
      get(){

      },
      set(newValue){

      }
    }
  },
  methods: {
    prop(){
      return '';
    }
  }
});
```

与 `methods` 区别

> 计算属性是基于它们的依赖进行缓存的。只在相关依赖发生改变时它们才会重新求值。

> 相比之下，每当触发重新渲染时，调用方法将总会再次执行函数。

# 侦听属性

> 观察和响应 Vue 实例上的数据变动

```js
new Vue({
  watch: {
    // 当 first 值变动时，执行
    firstName(val){
      this.fullName = val + '111';
    }
  }
})
```
