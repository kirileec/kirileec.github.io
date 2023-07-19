title: Android 4.4 开启ART模式
date: "2014-02-18 00:21:00"
update: ""
author: me
tags:
- android
- nexus
categories:
- android
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



之前有使用Xposed框架，于是不能直接开启成功，解决办法是取消各个模块的激活状态，并在Xposed框架中卸载框架（相当于卸载了“驱动”），然后直接“设置-开发者选项-选择运行环境-使用ART”重启，就可以开启成功

启动后会显示Android正在升级，然后根据应用数决定优化的时间


目前支付宝钱包8.0不能兼容这个模式，换到7.7版本即可成功安装，并正常使用

特点：应用开启速度明显上升，各种切换也更流畅了

缺点：安装应用速度很慢，开机时间稍稍变长（反正没感觉，也没见开机快过，能比得上SSD24秒？）
