title: 一次解决git clone时提示空间不足的问题
date: 2018-12-10 10:10:08 +0800
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


解决git clone时出现`error:unable to write to file...`
<!--more-->

话说这天一哥们给我发消息问我的BWH有没有被block了, 我就打开博客网址看了一下, 我了个去, 403了. 一想不对啊, 我这个hugo的博客都没有登录功能, 哪来的权限啊.
但当时人在外面, 没有马上看, 而是打开了google, 竟然正常, 那么推断应该是博客nginx这里的问题了.

回去之后连上服务器一看, 好嘛, www路径下空空如也, 于是想到应该是webhook的脚本有问题了, 手动执行了一下就出现了上面的错误, git clone的时候根本就没有完整的文件.

接下来开始猜, 先从权限猜起, 目录在`/tmp`下, 并且之前都是正常的. 再次看了一遍脚本的输出日志, 最后面提示`no space left on device`, 于是检查了一下硬盘空间, 仍有2G左右空闲,
总不会是超售引起的吧, 应该没那么凄惨吧. 然后又想到是不是内存问题, clone的操作需要较多内存, 尝试了一下, 每次报错之后, 内存占用就会跑到很高, 特别是虚拟内存, 不过虚拟内存即使满了也没有
什么关系才对.

最后, 抱着试试的心态, 我执行了 `df -lh`, 好嘛, `/tmp`的大小竟然只有75M, 那就应该是git仓库内容增多导致达到这个挂载位置的上限了. 修改脚本, 把克隆路径放到其他位置, OK
