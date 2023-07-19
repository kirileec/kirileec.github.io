title: 'WNDR4300配置ss kcptun '
date: "2016-12-07 23:19:00"
update: ""
author: me
tags:
- openwrt
- kcptun
- wndr4300
- ss
- chnRoute
- ipset
- dnsmasq-full
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



## 准备工作

> 链接: http://pan.baidu.com/s/1c2f0m1U 密码: xtg3



1. 首先刷入以下的固件

> openwrt-15.05.1-ar71xx-nand-wndr4300-ubi-factory.img
> openwrt-15.05.1-ar71xx-nand-wndr4300-squashfs-sysupgrade.tar

固件刷入方式， 第一个使用tftp刷入
#### A

- 用牙签插入WNDR4300的菊花，断电开机，等黄灯闪烁，松开菊花， 看到所有灯删，再次压住菊花，等到绿灯闪烁即可
- 插上网线， 设置ip地址为 `192.168.1.2` `255.255.255.0` , 网关无需设置
- 打开cmd， 执行 `ping 192.168.1.1 -t` ， 放到一边， 确认一直可以ping通即可
- Windows 7 以上系统直接在 `控制面板\程序\程序和功能`-> `启用或关闭Windows功能`-> 勾上`TFTP客户端`
- 将 `openwrt-15.05.1-ar71xx-nand-wndr4300-ubi-factory.img`放在`D:\`
- 打开cmd, `cd D:\` 回车
- `D:` 回车
- 运行 `tftp -i 192.168.1.1 PUT openwrt-15.05.1-ar71xx-nand-wndr4300-ubi-factory.img`
- 稍等片刻，发现上传完毕，同时路由器在重启，设置ip为自动获取， 等待重新获得ip
- 获得到ip之后，重启WNDR4300的电源， 否则没有5G无线，其实只是多重启一次

#### B
第二个直接在已刷好Openwrt的路由器管理界面里刷入， 不详说， 个人更加喜欢第一种， 因为第二种经常出问题


## 配置软件源和上传文件


运行`hfs.exe`, 将以下文件全部拖到`Virtual File System`处

```
client_linux_mips32
luci-app-kcptun_1.2.0-1_chaos-calmer_all.ipk
luci-app-shadowsocks_1.3.7-1_all.ipk
luci-i18n-kcptun-zh-cn_1.2.0-1_all.ipk
luci-theme-material-fix_0.2.17-1_ar71xx.ipk
luci-app-vlmcsd_1-1_all.ipk
Vlmcsd-KmsAto_svn977-2016-07-13_ar71xx.ipk
shadowsocks-libev_2.5.6-1_ar71xx.ipk
```

ssh到Openwrt上，依次使用wget 将这些文件上传到openwrt的目录下

## 安装和配置kcptun

假设服务器上的ss和kcptun都已配置好， 并且可以使用客户端正常链接

```bash
mkdir /usr/bin/kcptun
mv client_linux_mips32 /usr/bin/kcptun/client 
chmod +x /usr/bin/kcptun/client
opkg install luci-app-kcptun_1.2.0-1_chaos-calmer_all.ipk
opkg install luci-i18n-kcptun-zh-cn_1.2.0-1_all.ipk

```
访问 `192.168.1.1` ， 然后在`kcptun`的配置列表中修改加入自己的配置， 并`保存`
勾上启用进程监控，启用定时重启任务
客户端可执行文件填入 `/usr/bin/kcptun/client`
`Kcptun 客户端`选择刚才加入的配置， `保存并应用`， 然后可以在PC上用ss连接这个kcptun client试试看是否可以使用


## 安装配置 ss

```bash
opkg install shadowsocks-libev_2.5.6-1_ar71xx.ipk
opkg install luci-app-shadowsocks_1.3.7-1_all.ipk
```

同样的， 到ss的服务器管理里添加自己的ss配置， 这里因为要连接到kcptun， 所以是这样的

服务端地址:`127.0.0.1` 服务端端口: `kcptun本地监听端口，我的是7878`
加密方式:`ss的加密方式` 密码：`ss的密码`

`保存`

`基本设置`->`透明代理`

主服务器选择刚才添加的配置， 本地端口填写 `1080`， `其他都不开`


`访问控制`->`内网区域`
勾上 `桥接: "br-lan"`, `代理类型`:`正常代理` `代理自身`:`直接连接`

`访问控制`->`外网区域`

`被忽略IP列表`: `/etc/ignore.list`

这个列表的获取方式为
```bash
wget -O- 'http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest' | awk -F\| '/CN\|ipv4/ { printf("%s/%d\n", $4, 32-log($5)/log(2)) }' > /etc/ignore.list
```
其他暂时先不配置，`保存并应用`

## 配置dnsmasq ipset

我使用的固件已经包括了`dnsmasq-full` 和 `ipset`，因此略过 

```bash
vi /etc/dnsmasq.conf
```
```
server=114.114.114.114
no-resolv
cache-size=1000
dhcp-range=192.168.1.50,192.168.1.200,48h
dhcp-option=3,192.168.1.1
conf-dir=/etc/dnsmasq.d
```

```bash
vi /etc/dnsmasq.d/gfw.conf
```
```
#Google and Youtube
server=/.google.com/208.67.222.222#443
server=/.google.com.hk/208.67.222.222#443
server=/.gstatic.com/208.67.222.222#443
server=/.ggpht.com/208.67.222.222#443
server=/.googleusercontent.com/208.67.222.222#443
server=/.appspot.com/208.67.222.222#443
server=/.googlecode.com/208.67.222.222#443
server=/.googleapis.com/208.67.222.222#443
server=/.gmail.com/208.67.222.222#443
server=/.google-analytics.com/208.67.222.222#443
server=/.youtube.com/208.67.222.222#443
server=/.googlevideo.com/208.67.222.222#443
server=/.youtube-nocookie.com/208.67.222.222#443
server=/.ytimg.com/208.67.222.222#443
server=/.blogspot.com/208.67.222.222#443
server=/.blogger.com/208.67.222.222#443

#FaceBook
server=/.facebook.com/208.67.222.222#443
server=/.thefacebook.com/208.67.222.222#443
server=/.facebook.net/208.67.222.222#443
server=/.fbcdn.net/208.67.222.222#443
server=/.akamaihd.net/208.67.222.222#443

#Twitter
server=/.twitter.com/208.67.222.222#443
server=/.t.co/208.67.222.222#443
server=/.bitly.com/208.67.222.222#443
server=/.twimg.com/208.67.222.222#443
server=/.tinypic.com/208.67.222.222#443
server=/.yfrog.com/208.67.222.222#443

#Dropbox
server=/.dropbox.com/208.67.222.222#443

#1024
server=/.t66y.com/208.67.222.222#443

#shadowsocks.org
server=/.shadowsocks.org/208.67.222.222#443

#btdigg
server=/.btdigg.org/208.67.222.222#443

#sf.net
server=/.sourceforge.net/208.67.222.222#443

#feedly
server=/.feedly.com/208.67.222.222#443

# Here Comes The ipset

#Google and Youtube
ipset=/.google.com/gfw
ipset=/.google.com.hk/gfw
ipset=/.gstatic.com/gfw
ipset=/.ggpht.com/gfw
ipset=/.googleusercontent.com/gfw
ipset=/.appspot.com/gfw
ipset=/.googlecode.com/gfw
ipset=/.googleapis.com/gfw
ipset=/.gmail.com/gfw
ipset=/.google-analytics.com/gfw
ipset=/.youtube.com/gfw
ipset=/.googlevideo.com/gfw
ipset=/.youtube-nocookie.com/gfw
ipset=/.ytimg.com/gfw
ipset=/.blogspot.com/gfw
ipset=/.blogger.com/gfw

#FaceBook
ipset=/.facebook.com/gfw
ipset=/.thefacebook.com/gfw
ipset=/.facebook.net/gfw
ipset=/.fbcdn.net/gfw
ipset=/.akamaihd.net/gfw

#Twitter
ipset=/.twitter.com/gfw
ipset=/.t.co/gfw
ipset=/.bitly.com/gfw
ipset=/.twimg.com/gfw
ipset=/.tinypic.com/gfw
ipset=/.yfrog.com/gfw

#Dropbox
ipset=/.dropbox.com/gfw

#1024
ipset=/.t66y.com/gfw

#shadowsocks.org
ipset=/.shadowsocks.org/gfw

#btdigg
ipset=/.btdigg.org/gfw

#sf.net
ipset=/.sourceforge.net/gfw

#feedly
ipset=/.feedly.com/gfw
#custom
server=/instagram.com/208.67.222.222#443
ipset=/instagram.com/gfw
server=/cdninstagram.com/208.67.222.222#443
ipset=/cdninstagram.com/gfw
```
```bash
ipset -N gfw iphash
iptables -t nat -A PREROUTING -p tcp -m set --match-set gfw dst -j REDIRECT --to-port 1080
```
加入`防火墙自定义规则`
```
ipset -N gfw iphash
iptables -t nat -A PREROUTING -p tcp -m set --match-set gfw dst -j REDIRECT --to-port 1080
```
```bash
/etc/init.d/firewall restart
/etc/init.d/dnsmasq restart
```

## 安装Materialize主题
```bash
opkg install luci-theme-material-fix_0.2.17-1_ar71xx.ipk
```

## 安装KMS服务器

```bash
opkg install Vlmcsd-KmsAto_svn977-2016-07-13_ar71xx.ipk
opkg install luci-app-vlmcsd_1-1_all.ipk
```
`dnsmasq.conf` 加入
```
srv-host=_vlmcs._tcp.lan,openwrt.lan,1688,0,100
```
最后开心地测试吧
