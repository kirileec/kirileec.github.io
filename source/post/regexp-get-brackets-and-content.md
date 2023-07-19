title: 正则提取括号内容
date: 2020-01-13 15:47:10 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


正则提取括号内容(包括括号本身)
<!--more-->

直接上正则 <kbd>[\(\[【](.*?)[\)\]】]</kbd>

## 解释

- `(.*?)` 匹配任意字符
- `\(\[【` 和 `\)\]】` 匹配三种括号, 需要增加也是在这个位置添加
