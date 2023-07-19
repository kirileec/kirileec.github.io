title: Win10 无法访问局域网共享 提示 windows找不到 “\192.168.1.205”
date: "2017-04-01 21:19:44"
update: ""
author: me
tags:
- WINDOWS
categories:
- WINDOWS
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



这将是一个历史性的时刻。。。。哈哈， 虽然今天是愚人节，但不是开玩笑
首先讲讲我遇到的问题

本来我在局域网有一台服务器 192.168.1.205, 该服务器主要用于文件的共享, 平时的时候一般都可以使用`\\192.168.1.205`访问这台机子上的共享内容。突然有一天，我无法使用这种方式访问了，提示：windows找不到 “\\192.168.1.205” 请检查路径是否正确，当时由于旁边还有`别的机子`，所以就先想办法解决了眼前的事情。但是无法访问必然带来很多的不便，于是我想要想办法解决这个问题。

后来我发现，可以先进入`网络`找到那台机子之后以双击的形式访问共享，这让我看到了希望。于是我尝试使用机器名来访问，但是结果非常让我失望☹

这种情况持续了很久，直到后来，各种其他问题导致我渐渐对这个系统产生了抛弃的情绪，于是打算要重装系统了，正巧最近有Server 2016的发布，于是就打算换这个。然后这天晚上，不知怎么的，突然想起来要整理一下现在的桌面。然后，无聊着就又去搜了下那个情况了。

我本来已经不抱什么希望了，因为我已经基本上尝试了所有和共享有关的设置，没有什么是网上的帖子没有提到的了

。。

但是，哈哈哈 祭上链接了

> https://answers.microsoft.com/zh-hans/windows/forum/windows_7-networking/windows/18b23bc0-642e-444b-bd9e-b1727f2435c0


在这个问答第一页的最后一个回答，一位叫 kingofhill 的网友的回答，以下摘抄他回答作为备忘
```
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{F02C1A0D-BE21-4350-88B0-7367FC96EF3C}]
@="Computers and Devices"
```
抱着试试的态度，我打开注册表编辑器，导航到了这个`NameSpace`，惊喜地发现，真的没有这个项，于是加入这个项。 

当然，这里还需要重启一下资源管理器，居然神奇的恢复正常了
