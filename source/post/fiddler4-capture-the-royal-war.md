title: Fiddler4抓包皇室战争
date: "2016-05-21 21:53:51"
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



首先环境是OpenWrt的Shadowsocks，用的是明月永在的固件，里面包含了两种模式，白名单和黑名单

最近Chrome看youku都卡成幻灯片，CPU直逼50啊，我都开始怀疑电脑性能是不是已经不行了，该死的Flash。 另外Chrome的滚动更是越来越卡。

鉴于一直用固件自带的pdnsd和shadowsocks配合的方案，也有怀疑过网络问题。

经过一番测试，发现youku在白名单模式下，打开的速度明显慢一半（隐私模式）。
测试方式很简单，先无线连接到Openwrt的上级路由器（直接拨号），打开网站，目测其加载速度，发现输入网址后按回车，页面内容立马出来了，虽然其中一些图片要等一会才出来（PS：youku一定是穷死了吧，以前可不是这样的，当然也不排除我网络问题，但我可是20M，而且还是白天啊）。 然后在Openwrt下，不断切换shadowsocks的模式，发现黑名单模式下，加载速度和直接连上级路由器的速度基本一致，而白名单模式在回车后，标签页的圈圈要先转几圈才会出现主体页面。
终于得出了结论，看来youku的某些地址应该在Openwrt的转发过程中，被使用VPS进行解析了

然后就出事了，皇室战争开始掉线，那么必须要把其地址加入到黑名单中。刚开始还想用个数据包嗅探软件，然后笔记本发射个无线出来，后来发现复杂了。Fiddler有代理模式，于是下载安装Fiddler
`Tools->Fiddler Options->Connections`

CHECK `Allow remote computers to connect`

`Tools->Fiddler Options->HTTPS `
CHECK `Decrpty HTTPS traffic` 
CHECK `Ignore Server certificate errors(unsafe)`

之后重启Fiddler，取得电脑的IP地址

然后手机设置代理，端口为IP地址:8888，浏览器直接访问这个代理地址，在出来的成功页面里可以安装证书。不过我不需要抓浏览器，所以暂时不需要装证书。

折腾了半天，抓出来的地址为 `service.supercell.net`

然后我不禁开始猜想，部落冲突不会也是这个地址吧

填入到Pdnsd中，正常，不会掉线了
