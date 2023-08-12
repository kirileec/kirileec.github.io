title: openwrt zerotier 配置
date: 2022-07-16 21:32:52 +0800
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



## 安装zerotier

- 系统->软件包, 查找 luci-app-zerotier 安装即可, 会自动安装需要的包
- 安装完成后, 在VPN->Zerotier可以看到
- 填写Network ID, 可能需要点一下+号, 勾选启用和自动允许客户端NAT, 保存应用
- 切换到接口信息页签, 记下虚拟网卡名 比如 ztks5wrzww

## 创建zerotier接口和防火墙区域

- 网络->接口, 添加新接口
- 接口名称填 zerotier, 协议选不配置, 设备选择 ztks5wrzww 的那个
- 防火墙设置, 输入 zerotier 创建一个新的防火墙区域

## 允许防火墙区域转发
即需要允许zerotier->wan的转发

- 网络->防火墙, 找到`zerotier`的那个区域, 编辑
- 允许转发到目标区域 选择 `wan`, 设置`转发`为接受
- 涵盖的网络 选择 zerotier
- 最终 会有一个zerotier => wan 的区域设置, 且转发为 接受

- 自定义规则中增加三行后保存
```shell
iptables -I FORWARD -i ztks5wrzww -j ACCEPT
iptables -I FORWARD -o ztks5wrzww -j ACCEPT
iptables -t nat -I POSTROUTING -o ztks5wrzww -j MASQUERADE
```
注意替换自己的虚拟网卡名

## 重启网络或者路由器


## 配置zerotier规则

PS: 这里使用的是自定义网段, 嫌麻烦的可以用Easy模式, 挑一个就行, 我只想装个逼让IP好记点


- 打开 https://my.zerotier.com/, 进入到创建的网络中
- IPv4 Auto-Assign 选择 Advanced, Range Start: 10.10.1.1 Range End: 10.10.1.254
- Members里的设备如果已经分配了其他网段的IP, 则删掉, 让它重新分配, 也可以自己写一个, 勾上左边的Auth
- Members里给刚连上的路由器设置名称, 并记下它的Managed IPs
- Managed Routes 增加以下
 
```
10.10.0.0/24 via 路由器的虚拟网卡IP
10.10.1.0/24 via 10.10.1.255 (这个是这个网段的网关)
```

## 使用不在当前局域网的设备测试下

- 笔记本连手机热点, 运行zerotier, 加入到网络中, 并 Auth
- 分别 ping 10.10.0.1  ping 10.10.1.1, 都通则表示配置完成
