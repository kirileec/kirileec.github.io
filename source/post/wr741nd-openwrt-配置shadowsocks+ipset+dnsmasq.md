title: wr741nd openwrt 配置shadowsocks+ipset+dnsmasq
date: "2015-03-19 09:12:00"
update: ""
author: me
tags:
- OPENWRT
categories:
- OPENWRT
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



由于之前路由器一直处于某种状态

开机，看心情自动重启
插入网线，看心情自动重启
访问192.168.1.1的时候，回车一敲，看心情自动重启
LUCI界面配置wifi，看心情自动重启
随机找个时间，看心情自动重启

PS：看心情的概率>90%
本来觉得是不是路由器硬件的缺陷，毕竟盖着 wr941nd V5 的壳子，但是又只能刷 wr741nd 的固件，不过经过昨天的试验，证明了其实是固件的问题。
昨天刷了 openwrt 官方网站提供的<a href="http://downloads.openwrt.org/latest/ar71xx/generic/openwrt-ar71xx-generic-tl-wr741nd-v2-squashfs-sysupgrade.bin">下载地址</a>，然后发现，只要不在刚开机的时候连接上去，基本不会重启。
关键运行过程中不会突然重启了，而且，不使用WEB访问就不会重启，于是ssh上去很爽，因此，就没有去使用各个软件的LUCI界面了
以下是配置过程：


- 替换`dnsmasq`为`dnsmasq-full`，`opkg update`很慢，应该可以把那几个`Package.7z`手动下载覆盖的，如果安装出现kernel不符的情况，加上`--force-depends`即可
```
opkg update
opkg install kmod-ipt-ipset ipset ipset-dns iptables-mod-nat-extra
opkg remove dnsmasq
opkg install dnsmasq-full
```

- `/etc/dnsmasq.conf` 添加
```
no-resolv
server=114.114.114.114
conf-dir=/etc/dnsmasq.d
```

- `/etc/dnsmasq.d/gfw.conf` 规则
```
server=/.example.com/208.67.222.222#443
ipset=/.example.com/gfw
```

- `/etc/firewall.user` 添加
```
ipset -N gfw iphash
iptables -t nat -A PREROUTING -p tcp -m set --match-set gfw dst -j REDIRECT --to-port 1080
```

- `/etc/config/dhcp` 保持默认，主要是关掉 DNS请求转发和忽略解析文件这两个，因为配置文件已经有了

- 安装shadowsocks，我装了个polarssl版本的，什么版本无所谓，反正我是`aes-256-cfb`

- `/etc/shadowsocks.json`,端口为`1081`
```
{
"server":"VPS IP",

"server_port": ,

"local_port":1081,

"password":"PASSWORD",

"timeout":60,

"method":"aes-256-cfb"

}
```

- /etc/ss-redir.json,端口为1080
```
{

"server":"VPS IP",

"server_port": ,

"local_port":1080,

"password":"PASSWORD",

"timeout":60,

"method":"aes-256-cfb"

}
```

- `/etc/init.d/shadowsocks` 添加
```
service_start /usr/bin/ss-redir -c /etc/ss-redir.json

service_stop /usr/bin/ss-redir
```

不要删掉ss-local

- `/etc/init.d/shadowsocks enable`

- 重启路由器
