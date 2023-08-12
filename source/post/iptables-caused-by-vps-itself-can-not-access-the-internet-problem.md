title: iptables 导致的VPS本身无法访问外网问题
date: "2016-02-20 00:04:10"
update: ""
author: me
tags:
- Linux
categories:
- Linux
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



最近遇到个奇怪的问题, 搬瓦工的VPS不是最近有个新节点么,叫什么费洛蒙,正好在重新装了系统后就准备迁移一下看看速度怎么样。

结果就是，过年期间，电信光纤情况下，延迟一直在300ms+，到后来干脆就是400ms+，于是准备迁移回去，然后问题出现了，迁移回洛杉矶数据中心后，出现了其他一切正常，但唯独无法爬梯子，郁闷了好久。后来ssh上去看了下，惊呆了，`VPS本身居然无法ping通任何地址`。但一时又找不到原因，于是只好换回费洛蒙凑活着，憋屈了n久了

今天闲来无事，准备折腾下看看到底啥原因。 一番折腾后，发现是iptables也就是防火墙的原因，关闭了防火墙就正常连通了。  于是就各种查询iptables的用法，但是 `iptables -L`根本看不出什么异常，也就基本的 web ssh 服务的端口，还有个mysql服务的端口是 DROP，我差点就想找这货的茬儿了。

漫长的搜寻总算是到头了，因为发现在`NAT`表里有奇怪，`POSTROUTING`链里有一条，虽然是`ACCEPT`，但是其目标地址不对，和当前ip不吻合

于是

```
iptables -t nat POSTROUTING -D 1
/sbin/service iptables save
/sbin/service iptables restart
```

搞定，至于原因可能是之前装openvpn的残留品
