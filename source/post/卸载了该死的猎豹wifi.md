title: 卸载了该死的猎豹WIFI
date: "2014-06-04 20:34:00"
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



原因：今日购得一只迷你型无线路由器，准备扩张下家里的wifi信号啊，蛮期待的啊然后出事儿了，任何网卡都不可以手动设置IP，包括本地网卡和无线网卡，只要一双击`Internet 协议版本 4`，或者选中然后点属性，一个样，windows 资源管理器已停止工作，下面详细内容为`comctl32.dll`模块的问题。因为前面几次，出这个事儿之后直接就死机了，于是强制关机了几次。然后最近几次居然不死机了。解决：网上搜得一帖子，也是`comctl32.dll`的问题，然后他的方法是卸载一个叫什么的上网助手，于是，我就想到，肯定有软件对我的网卡进行了处理。右下角45度，猎豹WIFI，这货映入我的眼帘啊。

不管三七二十一啊，直接卸载了之，果然正常了 

PS：没玩过中继模式，我说怎么信号不见了呢
