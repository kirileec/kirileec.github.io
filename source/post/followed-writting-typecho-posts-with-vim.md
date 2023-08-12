title: 「续」vim发 Typecho 博客
date: "2015-02-13 09:33:51"
update: ""
author: me
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---




经过一晚上的研究，主要看了 Typecho 的 xmlrpc.php 和发布文章相关的函数调用，一点头绪都没有，得到的信息如下，
1. 对博客文章进行的操作，主要是依靠 xmlrpc 协议中的 mwEditPost 函数
2. 在 vimpress 中发现的mwEditPost 其实是 Typecho 的 xmlrpc 中声明的
3. 第二点所说的实现方式为xmlrpclib.ServerProxy(blog_url).metaWeblog，mw 是 metaWeblog 的缩写，ServerProxy 方法用于连接 xmlrpc 以远程调用函数

其实这些都没啥用，今天早上起来，不死心，一个机灵，去查看了下数据库，于是只要在`Content`下的第一行加入一行``，完成，可以解析了
