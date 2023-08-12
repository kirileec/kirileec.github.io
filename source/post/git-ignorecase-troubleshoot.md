title: git 忽略大小写导致的文章找不到
date: 2020-05-20 20:28:38 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---




下午在我新的博客上进行搜索的时候发现有一篇文章能够搜索到, 但是点击之后打不开, 提示404.



回来之后, 一顿查找猛如虎, 在经过了无数次 `./ink publish` 之后, 差点都要放弃了, 到github上和本地的public目录进行对比之后发现, 两者的目录结构完全不一样. 本地的android目录在github上显示的却是Android. `git config core.ignorecase false` 之后好像并没有用.

只好使用了暴力处理方法, 直接删除掉public目录推送一次, 然后再次进行publish, 总算回复了正常
