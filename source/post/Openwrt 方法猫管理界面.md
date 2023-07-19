title: Openwrt 方法猫管理界面
date: "2015-07-06 13:42:00"
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



猫的型号为：ZXDSL 831 网上查了下，管理IP为192.168.1.1

Openwrt WAN口对应的网卡为eth1 

ifconfig eth1 192.168.1.2 netmask 255.255.255.0
iptables -t nat -A POSTROUTING -d 192.168.1.1 -j MASQUERADE
