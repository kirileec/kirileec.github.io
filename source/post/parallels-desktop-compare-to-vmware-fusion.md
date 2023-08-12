title: parallels desktop 性能对比 vmware fusion
date: 2020-05-19 19:13:16 +0800
update: ""
author: linx
tags:
- mac
categories:
- mac
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



主机环境如下

![](/images/peizhi.png)

## 虚拟机设置说明

- CPU都选择4核心
- 内存大小为2G到4G不等, 因为这个大小关系不大
- 各种设置尽量偏向于游戏方面

## Parallels Desktop 安装 win7

![](/images/parallels desktop benchmark win7.jpg)

## VMWare fusion 安装 win10 专业版

![](/images/vmware fusion benchmark win10.jpg)

## Parallels Desktop 安装 win10 专业版

![](/images/parallels desktop benchmark win10.jpg)

## 小结

PD装win7依然在CPU和显卡性能上超越了安装了win10的vmware, 但是磁盘性能真的是难看, 尝试给PD安装win10之后, 终于确定了心中的猜测, mac上虚拟机安装win7的磁盘性能真的垃圾. 原因可能是win7对于SSD的支持并不完善, 毕竟win7刚出那会儿, SSD 120G还要1000+的. 也有可能是win10这些年有特殊优化. 当然也有可能是虚拟机软件对于老的系统没有做特定的优化. 

本来在win7的虚拟机上玩个小游戏都能在加载页面卡住, 一度让我想要去装bootcamp了, 抱着试试的心态用vmware装了win10, 发现情况并不是那么简单. 于是就简单地搞了下对比测试, 并不严谨, 但已经可以让我作出抉择了. PD的体验感还是比较好的.
