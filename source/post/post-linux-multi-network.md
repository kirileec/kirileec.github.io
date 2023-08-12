title: linux 多网卡配置
date: 2021-12-23 22:25:46 +0800
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



先停用NetworkManager， 这玩意不是什么好东西，只会让你碰到莫名其妙的问题

```shell
systemctl stop NetworkManager
systemctl disable NetworkManager
```

执行`ifconfig`查看有哪些网卡， 不同的物理机， 网卡命名不同， 有些是eth0 有些是em1 ， 还有些是ens33， 看情况

## 设置 网卡ip
查看有哪些配置文件
```shell
cd /etc/sysconfig/network-scripts/
ls -l
```
默认的配置文件可能是这样的
```
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=dhcp
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=em4
UUID=4e448a53-d540-4980-b30b-8686bd90f766
DEVICE=em4
ONBOOT=no
```
改成这样

```
TYPE=Ethernet
PROXY_METHOD=none
BROWSER_ONLY=no
BOOTPROTO=static # 静态地址
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=yes
IPV6_AUTOCONF=yes
IPV6_DEFROUTE=yes
IPV6_FAILURE_FATAL=no
IPV6_ADDR_GEN_MODE=stable-privacy
NAME=em1
UUID=5179d376-7194-464a-bdfe-d510dabc3106
DEVICE=em1
ONBOOT=yes # 启动
IPADDR=192.168.0.240 #IP地址
NETMASK=255.255.255.0 # 子网掩码
```
加上或修改注释的那几行就够了, `GATEWAY=网关IP`，也可以加上网关地址，对于局域网的情况下不是必要的


重启网络，这玩意重启还挺慢的
```shell
systemctl restart network
```
查看各个网卡是否正常展示ip
```sh
ifconfig
```

## 特定的情况

如果不同网卡的IP段不同，那么默认情况下，你访问一个IP地址，系统可自动根据IP来判断下一跳到哪个网卡。如果你配置的IP和要访问的IP不是在一个段，例如IP是10.9.54.10， 要访问10.2.23.21，那么这时候，系统只会给你选择默认的0.0.0.0对应的路由表。这时候需要添加静态路由来指定， 语法如下

```sh
# ip route add 目标网段 via 要走的网关 dev 网卡名
ip route add 10.0.0.0/8 via 10.9.54.1 dev em3
```
想要静态路由永久生效，在 `/etc/sysconfig/network-scripts/`下新建 `vim route-interface`, 内容如下
```sh
10.0.0.0/8 via 10.9.54.1 dev em3
```
就是去掉前面`ip route add`部分即可。 再次重启网络或者重启机器， 看看路由是否生效 `route -n`
