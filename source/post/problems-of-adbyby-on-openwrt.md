title: adbyby在openwrt上遇到的问题
date: "2015-03-09 05:47:00"
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



因为固件作者说SS和adbyby冲突，而在新版本中去掉了adbyby

我自己装了下，主要俩命令`./adbyby&`和一个iptables命令用于透明代理

我遇到的问题是在防火墙添加了iptables代码，然后adbyby本来是手动运行的，后来不知怎么的关闭了还是怎么，然后就无法上网了，192.168.1.1都访问不了，各种连接超时之类的，后来想到iptables添加了数据到8118端口的转发，而如果adbyby不正常了，自然整个访问过程都被一个空代理给堵死了（8118），于是下connectbot准备连接ssh，但一开始还连不上，又是莫名其妙的原因

最后这么解决

    vi adbyby.sh
    #!/bin/sh
    ./bin/adbyby&
    iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118
    :wq
    chmod +x adbyby.sh
    ./adbyby.sh

另外, 我在想防火墙的自定义规则里面是不是可以添加别的终端命令?
