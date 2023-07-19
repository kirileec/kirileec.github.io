title: 电信光纤居然支持IPv6了
date: "2016-02-08 20:52:17"
update: ""
author: me
tags:
- other
categories:
- other
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



本来是在VPS换系统的同时, 想顺便把VPS的IPv6地址给用起来, 然后各种折腾Openvpn配置, 搞最后连连接上也就那么一次, 经常性地处于重连状态, 然后偶然就看到了原来我这个刚办的光纤宽带(2016光改线路,8M带宽,实际是1.1M/s),居然还有IPv6地址. 

大致设置了一下DNS和IPv6优先级, 就可以看IPv6的IPTV了, 而且很高清, 突然发现我已经好久没有看这么高清的视频了, 那时候还是在学校里.....(省略5000字感慨)

但是我的OpenWrt居然拨号后没有IPv6地址分配, 预计近期就又到了刷固件时期了, 大致准备上 [https://github.com/gygy/gygy.github.io](https://github.com/gygy/gygy.github.io) 这个,看起来还不错, 尝试一下, 如果不行就回到Openwrt BB版本 CC版本感觉不是特别好
