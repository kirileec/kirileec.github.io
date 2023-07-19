title: Git Refusing to Merge Unrelated Histories
date: 2020-03-25 09:01:13 +0800
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


Git Refusing to Merge Unrelated Histories
<!--more-->
常见场景: 线上代码仓库还没有建立, 于是先在本地创建项目, 后面仓库建立好了, 想把代码推上去的时候就会出现这个了.

原因就是本地仓库和线上仓库不被认为是一个仓库, 因为两边都有各自的提交记录.

```bash
git pull origin master --allow-unrelated-histories
```
