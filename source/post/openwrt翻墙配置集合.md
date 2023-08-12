title: openwrt翻墙配置集合
date: "2015-04-27 15:03:00"
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



## 安装必要的包


    opkg update
    opkg install kmod-ipt-ipset ipset ipset-dns iptables-mod-nat-extra
    opkg remove dnsmasq
    opkg install dnsmasq-full

## /etc/dnsmasq.conf


    server=112.124.47.27
    no-resolv
    cache-size=1000
    dhcp-range=192.168.1.50,192.168.1.200,48h
    dhcp-option=3,192.168.1.1

## gfw.conf


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

#防火墙自定义规则


    ipset -N gfw iphash
    iptables -t nat -A PREROUTING -p tcp -m set --match-set gfw dst -j REDIRECT --to-port 1080

## shadowsocks开启1080为透明代理端口，1081为socks5端口

PS：ChinaDNS或者pdnsd之类的都是不靠谱的，经常失效，而且是全部国外ip都走代理，不合理。ipset的方法，有两个关键的位置一个是208.67.222.222#443这里也可以换成自己架设的DNS，dnsmasq开启非标准端口监听即可然后绑定到外网ip上。dhcp的选项必须要填上去，我之前没填，反正就只能分配一次ip后面再次连接DHCP就不行了。上游DNS尽量选择响应快的，阿里的不靠谱
