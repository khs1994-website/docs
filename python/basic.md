---
title: Python3 基本语法
date: 2015-01-02 13:00:00
updated:
comments: true
tags:
- Python
categories:
- Python
---

本文介绍了 Python3 的基本语法

```python
print('Hello World!')
```

<!--more-->

# 定义变量

```python
a = 1

b = 'a' + 'b'

c = True # False

d = "{a}".format(a=a) # 字符串内包含变量

del a

'''
注释
'''

"""
注释
"""

print('''
多
行
''')

print('\n') # 输出 空行

print(r'\n') # 原样输出 \n

print('1', end=" ") # 默认输出自动换行，加上 end=" " 表示不换行

```

# 获取用户输入

```python
a = input('please input : ')
```

# 获取脚本参数

```python
sys.argv[0] # 脚本名称

sys.argv[1] # 第一个参数

len(sys.argv)-1 # 参数个数
```

# 函数

```python
def fun_name(a=1, b=2):
    print(a)
    pass
```

## 匿名函数

```python
sum = lambda arg1, arg2: arg1+arg2
```

# 流程控制

```python
if True:
  print('')
elif a = 1:
  print('')
else:
  print('')  
```

```python
while True:
  print('1')
```

```python
for in
```

# 数据类型

* List [1, 2, 3]

* Tuple (1, 2, 3) 元组的元素不能修改

* Set {1, 2, 3} 无序不重复元素

* Direct {'name':'tom', 'age':18}

# 错误与异常

```python
try:
    print(a)
except NameError as e:
    print(e)
else:
    print('没有错误发生')     
```
