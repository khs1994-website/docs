---
title: ESLint
date: 2018-10-01 13:00:00
updated: null
comments: true
tags:
  - JavaScript
categories:
  - JavaScript
---

https://eslint.org/docs/user-guide/getting-started

<!--more-->

```bash
$ npm install -g eslint

$ eslint --init
```

`.eslintrc`

```json
{
    "env": {
        "browser": true,
        "es6": true
    },
    "extends": "eslint:recommended",
    "parserOptions": {
        "ecmaVersion": 2015
    },
    "rules": {
        "indent": [
            "error",
            4
        ],
        "linebreak-style": [
            "error",
            "unix"
        ],
        "quotes": [
            "error",
            "single"
        ],
        "semi": [
            "error",
            "never"
        ]
    }
}
```
