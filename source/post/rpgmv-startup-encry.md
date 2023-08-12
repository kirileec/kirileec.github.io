title: RPG MV 验证器简单绕过
date: 2019-06-25 20:16:06 +0800
update: ""
author: linx
tags:
- RPG MV
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


RPG MV 验证器简单绕过
<!--more-->

- 关键字1: system core
- 关键字2: start main
- 关键字3: 启动游戏.exe

验证器的主要作用是加解密 `.\www\data ` 目录下的json数据文件
打开时解密, 退出时加密, 这样可以防止使用 RPG MV 进行二次修改, 
同时, 在没有运行验证器的情况下, 不能直接打开Game.exe, 因为此时的json文件进行过加密.

这就恶心了, 有时候游戏出个bug啥的, 想打开工程自己改改就行, 没想到不能改

解决方法很简单, 运行一次程序, 然后进程里结束system core的那个进程即可, 阻止了其加密过程, 然后在 www目录下放个 Game.rpgproject 即可编辑了, 保存一次后面就可以直接运行Game.exe来跑游戏了

一般带验证器的, 都是解包过的
