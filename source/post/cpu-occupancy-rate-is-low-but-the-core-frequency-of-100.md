title: CPU占用率低，但是核心频率100
date: "2016-05-11 19:51:44"
update: ""
author: me
tags:
- WINDOWS
categories:
- WINDOWS
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



~~~之前一直都是挺正常的~~~ **不正常**！！！！之前还因为温度到了80度而重新涂了硅脂，今天突然发现，温度居高不下，开AIDA一看，不对劲，风扇满速在狂转，诡异的是CPU频率居然直接是最大频率。
然后搜索了一下， 各种说是软件问题，病毒问题，驱动问题的。一群脑残。。。。。都说了CPU占用几乎没有了，瞎子吗

后来尝试着打开电源计划的高级选项，发现处理器电源的最小状态是100％，我不想说话了。什么鬼，这个看起来很像我自己设置的选项是什么情况，于是果断调成5％,终于正常了
