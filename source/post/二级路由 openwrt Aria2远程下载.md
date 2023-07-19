title: 二级路由 openwrt Aria2远程下载
date: "2015-12-11 00:12:24"
update: ""
author: me
tags:
- OPENWRT
categories:
- OPENWRT
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



## 二级路由（OPENWRT）配置 
状态->概览->IPv4 WAN状态的IP地址 记录下来
`网络`->`防火墙`->`通信规则`->`打开路由器端口` 6800->点`添加`
## 一级路由配置

转发规则->虚拟服务器 添加6800端口,ip填 IPv4 WAN状态的IP地址 设置并登陆动态DNS，如果一级路由器长期运行，直接记住ip更省事儿
