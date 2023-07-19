title: redmi ax6s 刷 Openwrt 流程记录
date: 2022-07-16 21:02:37 +0800
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



PS: 一般是从原厂固件刷openwrt或者从一个作者的openwrt刷到另一个作者的openwrt (比如内核版本不同). 如果是同一个作者的, 则一般直接在openwrt页面下进行刷写即可, 不用下面的流程

PC网线连接LAN口, 插电 开机, 官方固件会自动获得 192.168.31.0/24 的IP, 如果亮黄灯, 工具会处理IP问题

## 刷回测试版ax6s固件 1.2.7

- 如果是官方版的小米固件则直接在后台进行固件

    在小米官方固件后台 (默认为 192.168.31.1) 常用设置->系统状态->手动升级 中 上传 miwifi_rb03_firmware_stable_1.2.7（内测版）.bin 并刷入
- 如果是路由器已经亮黄灯了, 则 使用 MIWIFIRepairTool.x86 直接把内测版固件刷进去, 刷入方法见下文

## 解锁ssh

- 获取路由器的SN码, 可以在路由器背后的标签找到, 路由器后台也会有显示, 一般是 `数字/字母数字` 这样的格式
-  [https://www.oxygen7.cn/miwifi/ ](https://www.oxygen7.cn/miwifi/) 到这个网站, 输入SN, 计算出密码, 这两个都存下来, 以后也不会变了
- telnet 192.168.31.1 , 用户名为root 密码是上面计算出来的密码
- 执行下面三行命令

```shell
nvram set ssh_en=1 & nvram set uart_en=1 & nvram set boot_wait=on & nvram set bootdelay=3 &nvram set flag_try_sys1_failed=0 & nvram set flag_try_sys2_failed=1

nvram set flag_boot_rootfs=0 & nvram set "boot_fw1=run boot_rd_img;bootm"

nvram set flag_boot_success=1 & nvram commit & /etc/init.d/dropbear enable & /etc/init.d/dropbear start

```
此时, ssh已开启

## 刷入openwrt底包 

- 使用scp上传 factory.bin 到 `/tmp/factory.bin` , 可以用命令, 也可以用winscp工具, winscp记得协议选择scp, 默认是SFTP的, 密码还是上面的密码

- 执行写入命令(使用scp命令传输的话还需要ssh连上去), winscp直接一点就进去了

```shell
mtd -r write /tmp/factory.bin firmware
```

## 刷正式固件

本文网盘里的factory.bin的默认ip是 10.0.0.1

进入 10.0.0.1 后台刷写固件, 不保留配置

本文网盘里的 sysupgrade 固件ip为 10.10.0.1, 是从 supes.top 自己定制的

## 小米官方修复工具教程

- 管理员权限运行 MIWIFIRepairTool.x86.exe, 本地上传选择内测版固件
- 下一步选择以太网的网卡
- 下一步, 路由器断电, 捅住reset, 插电, 等橙色的灯闪烁后松开, 然后会自动开始刷机
- 默默等待, 蓝灯闪烁, 拔电, 重启
- 访问 192.168.31.1 

## 工具网盘

- 链接: https://pan.baidu.com/s/1K3VLQ0yEdrq4j5EH8Dk6Ow?pwd=w1g3 提取码: w1g3 复制这段内容后打开百度网盘手机App，操作更方便哦 
--来自百度网盘超级会员v6的分享
