title: GPT分区格式U盘安装Win7
date: "2017-01-18 23:00:56"
update: ""
author: me
tags:
- windows
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



经过多年安装系统的经验积累，目前已经排除以下方式进行系统安装：

- PE解开install.wim
- 光驱安装
- GHOST

首先，第一种并非不好，而是有时候会出问题，例如，整半天装完后发现在系统准备阶段提示没有XXX，其实是驱动问题，而且是USB驱动，那个时候是崩溃的啊。第二种，毕竟现在电脑有光驱的不多，台式机基本不会带这玩意儿，而笔记本的光驱除非你的电脑比较新，否则用久了，光驱有时候会读不出来，而且还要刻录一个光盘，虽然在以前来看是非常炫酷的事情，不过现在么，你装个系统还要随时带着光盘吗。第三种，这种方式下的系统没有 **一个** 是好系统。

目前都采用刻录U盘的方式。不过最近发现想要直接刻录完就安装，还真有点难，主要是现在的电脑很多都是UEFI的BIOS，那么必须要切换到Legacy模式下即传统BIOS下，而且UEFI的速度也是不能忽视的。

而如果硬盘分区是GPT， 那就麻烦了，普通的启动U盘，到了选择分区的时候会提示无法安装，就因为是GPT分区。Win8以上的系统会相对方便很多。但是有时还是需要安装Win7的。

其实很简单， 只需要对刻录好的U盘，做点小动作即可。首先下载 `efi shell x64` 解压到U盘根目录。然后压缩软件打开 `sources\install.wim\4\Windows\Boot\EFI\`找到`bootmgfw.efi`也解压到根目录即可。然后BIOS选择
`Launch EFI Shell from filesystem device`即可进入EFI SHELL，会列出所有设备，随后如果只插了一个U盘，那么 `fs0:`准没错，不然还可以一个个试。然后输入`bootmgfw.efi`就可以进入安装界面了
