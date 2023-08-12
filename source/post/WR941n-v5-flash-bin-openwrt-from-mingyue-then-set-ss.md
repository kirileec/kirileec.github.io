title: WR941N V5 刷 OpenWRT 明月永在版, 并配置中继和翻墙
date: "2015-03-07 22:21:00"
update: ""
author: me
tags:
- openwrt
categories:
- openwrt
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



前些天, 花66买了个二手的 WR941N V5, 自带了 uboot 和 OpenWRT 明月永在圣诞版.

发现的问题:
- 开机之后，需要等待很长时间(0~+∞)，原因是，每次在开机之后，我插入网线使之与电脑连接，或者通过无线与之连接，路由器就重启了, 表现为全部指示灯亮起并灭掉，然后过一会，图标为齿轮的那个灯闪烁，我推测为又再次进入了 OPENWRT 的开机初始化过程，但是恶心的是，使用安卓手机连接则不会出现重启现象，但是我的 MAC 系统和 Win Server 2012 连接上去都会如此。以至于，每次都需要等很久, 等待无线指示灯稳定后，才敢插上网线。有时候会在连上无线之后几秒钟后重启，简直是莫名其妙的问题，uboot 里就不会出现，因此推测为固件原因
- 开启了 Shadowsocks 和 ChinaDNS-C，并且设置了 DNS 转发后, 仅仅 Google 的相关网站可以访问，Youtube、Twitter、Facebook、t66y、v2ex等网站无法访问。开始的时候推测为关键词屏蔽的原因，毕竟 ChinaDNS 只能解决 DNS 污染的问题，而且是基于 IP 进行的判断，于是开始寻找基于域名的解决方案（管 TM DNS 污染干啥呢），但是结果让我傻了眼，根本没人出现这个问题，都 TM 正常，唯独我不正常，日。基于域名的解决方案的帖子倒是有找到，但回帖中根本没有我要的答案，比如 PAC 这种就毫无意义啊，本身搞 OpenWRT 不就是为了透明代理么，客户端需要设置的话，那不是白搞了。再吐槽下，妈蛋怎么那些教程都是命令行模式的操作啊，有界面不玩偏偏用命令，只能说明教程都过时了，他们都没见过 Luci。再吐槽下，为什么我总感觉，把 DNS 解析的过程进行加密不如直接使用代理进行访问好呢（不是很懂，我印象中即使我拿到了正确的网站ip，那么也还是会因为关键词而被截杀的）。  
- 在换了 pdnsd 进行抗污染后，twitter 和 facebook 可以访问了，但是不完美（有些网站不行），那么肯定是 ChinaDNS 的问题，看了下版本，应该就是过于老旧了，新版本肯定进行过处理了
- 我下了两个固件，都是 sysupgrade 的，一个 WR941N，另一个 WR741N，因为机身上是 WR941N V5, 但是 openwrt 界面上显示的是 wr741N。都试着在 uboot 里刷了下，也在 openwrt 的备份升级处试了下。结果是openwrt 里面不能升级，会报错，uboot 常规固件里也不行，上传几 k/s，比乌龟还慢，花大半个小时传完了，然后报错 `服务当前不可用`，搜索无果。然后今天实在受不了重启，又试了试，发现又正常了，上传有个400k/s 的样子了，结果是 WR941N 的 bin 传上去后就卡在重启那一步，没反应，强制重启也一样，开机只有个 LAN 灯亮着。而 WR741N 则可以正常重启，真™见鬼了啊，莫名其妙的问题。

目前，明月永在春节版，shadowsocks+pdnsd + 中继，正常使用，但愿别再重启了。

- Shadowsocks
1. 阿里云 haproxy 跳板
2. 代理方式`忽略列表`
3. UDP 转发`启用`
4. 其他默认
- pdnsd
1. 默认选项
- 桥接
1. Clinet 模式连接主路由, wwan, 表示从主路由接收信号并作为 WAN 口, wwan 意为 WLAN WAN, 其他默认配置
2. 接入点AP 模式(Master), lan, 表示将本路由器的 NAT 网络共享至 4个LAN口和无线网络(组成局域网的接口), ESSID Openwrt 高大上, 无需重启接口产生一个无线信号
- adbyby
1. 更新到春节版后发现 adbyby 没了, 据作者所说是和 Shadowsocks 有冲突, 不过我没发现, 所以还是手动装上用着先.
2. wget tar -xvf then chmod then ./bin/adbyby&
3. 懒得搞开机重启
4. `iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8118`
  用于实现透明去广告, 这里重启下, 重新./adbyby& 一下即可
