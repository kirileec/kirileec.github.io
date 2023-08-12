title: XShell Sock5代理
date: "2015-09-13 12:05:00"
update: ""
author: me
tags:
- windows
- xshell
categories:
- windows
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



- SSH连接到服务器
- 查看-隧道窗格-转移规则
- 右键->添加...  
> 类型:Dynamic(SOCKS4/5)
> 侦听端口: 1080
- 一路确定即可
- 设定浏览器代理

PS：
# IE的SOCKS5代理设置
Internet选项-连接-局域网设置-代理服务器-高级-设置“套接字” `127.0.0.1` `1080`
