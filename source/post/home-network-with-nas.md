title: 家庭网络配置
date: 2022-06-20 14:46:03 +0800
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



这两天把家里的网络重新弄了一下， 记录一下

## 原来

- 百兆移动光猫直接拨号，并提供DHCP服务
- 家里设备不多，台式机通过预留网线直接接在光猫的LAN口， NAS也一样。 
- 因为光猫在弱电柜里，到房间要穿墙，所以房间里放了一个WNDR4300做无线AP，勉强能用，不过之前没搞好，WNDR4300被我刷成了原厂固件，启动很慢
- 光猫是4个百兆口，虽然网上有人说有一个口是千兆的，不过我这个确定全百兆。于是局域网速度堪忧


## 目前

尝试了一下发现光猫可以直接切换为桥接模式。 于是开始了折腾

- 登录光猫管理员账号 CMCCAdmin，密码是网上找的，记录下宽带账号和密码
- 切换为桥接，PC测试拨号，正常，顺便测了个速，没啥问题
- 这一步是后面才发现的。 关闭光猫DHCP服务和WIFI，否则光猫的DHCP和WIFI会抢答
- WNDR4300刷回Openwrt
- 配置LAN段IP为 10.10.0.0/24，顺手修改默认密码
- 固定NAS的IP为 10.10.0.2
- Openwrt配置PPPOE拨号
- 配置Openwrt获得IPv6，参考 https://opssh.cn/luyou/216.html
- 配置可以直接访问光猫的192.168.1.1，参考 https://blog.csdn.net/qwe502763576/article/details/122157562
- 配置自定义DNS为114.114.114.114
- 配置 自定义挟持域名 自己的域名 -> 10.10.0.2, 测试nas上各个服务是否正常
- 配置zerotier，加入到网络中，并勾选 自动允许客户端 NAT， 开启Openwrt ip_forward功能
- zerotier网页增加路由 10.10.0.0/24 -> Openwrt的zerotier 地址
- zerotier网页增加DNS， 自己的域名 > 10.10.0.1 ，此步需要配置自定义挟持域名，后面这个IP需要能够返回DNS的结果，同时需要自动允许客户端 NAT已生效（即已经可以直接通过局域网IP访问局域网其他机器）
- NAS上开启虚拟机，运行x86的Openwrt，并配置OpenClash （后续可以修改为开个docker，貌似我用不到其它功能），参考 https://post.smzdm.com/p/ag82m5km/
- NAS设置代理指向虚拟机的IP，这样省的经常什么镜像拉不下来啊什么的毛病
- 主路由Openwrt关闭不需要的服务

最终效果

不管是在家还是连接了zerotier , 访问nas只需要 使用自己的域名即可，不用去记各种难记的IP
