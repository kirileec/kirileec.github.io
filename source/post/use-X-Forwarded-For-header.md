title: use X-Forwarded-For http header
date: 2019-10-10 16:59:23 +0800
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


使用 `X-Forwarded-For` 
<!--more-->

有一个api需要IP地址鉴权, 即只有外网IP在其白名单中方可调用(下文称为"白名单机", 其IP为x.x.x.x), 开发机不能直接调用, 不方便调试

### 最简单的方法

例如我使用golang开发, 那么http.Client可以自定义Proxy, 只要在白名单机上架设一个CCProxy, 然后客户端调用时设置下代理即可

PS: CCProxy 需要注意做好鉴权, 比如把当前的外网ip添加到CCProxy中. 若不作这种处理, 第二天你就会发现一堆连接上来的客户端了


### 伪装

java的服务端在判断客户端IP时, 一般都是从Header中取, 于是搜索一番, 把可能的几个header都加上, 排除法即可. 使用了这个后就无需经过一层代理转发了.
