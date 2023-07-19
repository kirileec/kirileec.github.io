title: lenovo B4360-B015 install ESXI 6.7
date: 2022-07-27 11:44:03 +0800
update: ""
author: linx
tags: []
categories: []
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



## 准备工作

- 检查主板上的网卡型号， 我这里是RTL8111F 和 RTL8169， 两个难搞的螃蟹网卡
    - ESXi 7 不支持螃蟹网卡了，网上注入vib或者offline bundle的方式都不行了
    - ESXi 6.7 也不能注入了，会提示依赖不满足， 原因是ESXi在某个版本开始就把一些依赖库去掉了
    - ESXi 5版本估计可以， 不过肯定不甘心用这么旧的版本
    - 只能去网上找已经集成好驱动的iso，不太好找，两个卡都支持的就更难了（有些是别人自己编译进去的）

- BIOS开启虚拟化、UEFI
- 准备一个PE，也就是最好有两个U盘，一个装ESXI一个PE
- rufus

## 开始

- 下载iso，直接用rufus写入即可，选择MBR， GPT没试过
- 插上U盘启动， 如果驱动集成没问题， 则不会出现 No Network Adapter，一步步操作即可
- 装完拔掉U盘重启，我这个主板会提示Error 1962，不知道是主板问题还是ESXI的版本就这样。原因是安装时没有创建UEFI的启动项
- 插上PE，开机
- 打开Bootice，切换到UEFI页签，进入编辑UEFI启动项页面
- 会发现刚安装ESXI的那块硬盘只有个硬盘名字，还不能修改（保存是灰的）
- ‼️重要：**添加一个启动项**， 名称填写 `Windows Boot Manager`, 路径选择硬盘下的ESP分区里的Bootx64.efi
- 新的启动项上移到顶部
- 重启，搞定
