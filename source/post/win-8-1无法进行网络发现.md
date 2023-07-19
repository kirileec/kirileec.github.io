title: win 8.1无法进行网络发现
date: "2013-12-21 12:08:19"
update: ""
author: me
tags:
- other
categories:
- other
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



<div>最近用路由器、旧电脑和打印机构建了一套远程打印的设备</div>1. 无法启用网络发现<div>表现为：选中启用网络发现后，点保存更改，然后再次进去查看，发现根本没有改过来。而在这台电脑/网络里，如果没有开启网络发现，在进入的时候会提示，但是点完“提示”里面的‘启用网络发现和共享’之后，还是无法启用，而且坑爹的是，这货开机只提示一次。</div><div>&nbsp;其实是服务的问题</div><!--more--><div>检查&nbsp;</div><div>Computer Browser &nbsp;</div><div>Function Discovery Resource Publication</div><div>SSDP Discovery</div><div>UPnP Device Host</div><div>这四个服务，全部启用即可</div><div><br></div><div>2.启用网络发现后只能看到自己的电脑和路由器的，看不到打印服务器</div><div>这时需要检查防火墙的状态，最简单的方法是关闭它。</div><div>另一个方法是控制面板系统和安全Windows 防火墙高级设置</div><div>添加入站规则-新建规则-预定义-网络发现，然后选择前四个在右边的远程地址一栏标记为“本地子网”的规则，然后选中允许连接，点完成。</div><div><br></div><div>远程打印需要注意的地方</div><div>其实是注意局域网，只要局域网正常，然后打印服务端共享了打印机，并且设置好了驱动，那么都可以</div><div><br></div><br /><br /><div><a title="来自为知笔记(Wiz)" href="http://www.wiz.cn/i/13dc3a5d">来自为知笔记(Wiz)</a></div><br /><br />
