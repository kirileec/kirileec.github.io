title: '[强迫症结果]Mavericks10.9.5无损升级至Yosemite10.10.2'
date: "2015-04-14 14:42:00"
update: ""
author: me
tags:
- voodoops2controller
- iohidfamily
- 黑苹果
- mac
- 五国
- 覆盖升级
categories:
- mac
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



直接APPSTORE升级至10.10.3
问题：
1. 卡顿，windowserver这个进程很恶心，关掉了透明效果，仅仅好转一点，app启动过程感觉变慢了（各种）
2. CLOVER的问题，我明明设置了timeout，但是开机的时候会停在选择界面（即 wait for response），不知道见什么鬼
3. 变色龙引导时会卡在 CPU 信息那一行，莫名其妙的问题，另外，新版本系统的mach_kernel改名成了kernel，估计要手动处理
4. Genymotion启动明显变慢了，半天都没进入
5. PD10无法运行，新安装了10.2的版本后恢复，但是虚拟机启动也很慢
6. ExpressCard的驱动无法加载，总感觉CLOVER有问题，但又找不到
7. 开机启动也很慢啊，进度条要走半天，之前一进桌面就可以打开程序干事的，现在等状态栏加载就要10来秒
-----------UPDATE--------------

关于昨天遇到的问题

引导U盘进入Yosemite安装界面的过程中出现五国：

最后几行出现类似
1. backtrace
2. IOHIDFamily
3. VoodooPS2Controller
4. PS2TrackPad

搜索无果。 解决办法为
> 设置Clover的Boot_arg为 dart=0  或者  关闭BIOS的Intel VT-D（即CPU虚拟化）

然后一个问题是Clover不加载EFI/Clover/kext中的驱动，即使我使用WithKexts也不行，另外每次使用-f或者NoCache或者选择Withou Cache仍然使用老的的kexts，手动删除缓存还是一样，总之就是我想要加载的驱动没加载上。最后使用Kext Utility,总算是搞定了电池的显示，但是ExpressCard的驱动仍然无法加载，不知道是不是驱动本身的问题。Kext Wizard不行，总之它的修复权限功能和重建缓存跟没有一样。以前我好像就出过这类问题，因此差不多可以卸载一个了。

# 正文

## 需要的组件

1. 8G或以上的U盘一个（移动硬盘或者高速的U盘更佳，可以更快地加载）
2. 懒人版Yosemite cdr镜像（dmg更佳）
3. Carbon Copy Cloner（CCC）
4. 可用的MAC系统
5. Clover最新版本&Clover Configurator

## 制作系统安装U盘

1. 插入U盘，使用系统自带的磁盘工具，分一个区为MAC 日志式，命名为OSX
2. 将cdr镜像修改名称&后缀为Yosemite.dmg，并装载
3. 打开CCC，源磁盘选择装载的Yosemite，目标磁盘选择装载的U盘，等待恢复
4. 安装Clover到U盘，勾上
    > BootLoader boot0af
    > CloverEFI 64位 SATA
    > 勾上 Driver是64
    > `安装 RC scripts到目标磁区`
    > `选择安装 RC Scripts`  勾上
5. Clover Configurator配置`Boot`页
    > Verbose(-v)
    > dart=0
    > kext-dev-mode=1
其他选项都使用默认
6. OSX/EFI/Clover/kext/Other放入需要的驱动，我放入了Natit（驱动9300mgs），ACPIBatteryManager，FakeSMC，VOODOOPS2Controller，这么几个就差不多了，主要是FakeSMC，然后电源的，然PS2的，显卡如果有解决方案了就直接加入，否则的话删除 NV开头的驱动，然后慢慢折腾吧
7. 重启选择U盘启动，我的机子使用了dart=0之后就可以进入安装了。直接选择安装到当前的系统盘，无需抹盘，然后大概需要30分钟，再次重启进入配置界面
8. 全部搞定后将需要的kext使用kext Utility安装并重建缓存


9. 修改 /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist 使得Apple账号可以登录

10. 原先Mavericks的驱动有一部分保留了下来，并不是完全覆盖了
