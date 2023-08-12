title: 对ASUS Notebook M50Vc做的两件事
date: "2012-09-23 14:36:04"
update: ""
author: me
tags:
- ahci
- windows
categories:
- windows
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




			这本子是在09暑假买的，当时对电脑一窍不通，也没找到懂的人，就这么糊里糊涂地买了。算了老事不谈，进正文
<div><br /></div>
<div>1.</div>
<div>M50Vc AHCI模式启动</div>
<div><br /></div>
<div>看了相关文章，以前感觉很麻烦地事儿，没想到这么简单就搞定了，不知道咋回事，呵呵。</div>
<div><br /></div>
<div>因为情况特殊，就简单讲。</div>
<div><br /></div>
<div>我的情况是</div>
<div>BIOS里已启动AHCI模式，系统内也提示AHCI 1.0。
&nbsp;<wbr>于是，把这个设备的驱动更新下就好。手动选择驱动位置，定位到下载的AHCI驱动文件夹，然后重启一次，开始安装设备。再次重启就显示</wbr></div>
<div>Intel(R) ICH9M-E/M SATA AHCI Controller
&nbsp;<wbr>&nbsp;</wbr><wbr></wbr></div>
<div>原本硬盘还在右下角显示的也不见了。</div>
<div><br /></div>
<div><br /></div>
<div>2.</div>
<div>BIOS刷新</div>
<div><br /></div>
<div>其实本来也早想做了的，一直苦于了解不够，还有那句“有风险”</div>
<div><br /></div>
<div>终于下定决心搞定。</div>
<div><br /></div>
<div>先把软激活卸载了重启查看slic表，提示找不到，系统需要立即激活</div>
<div><br /></div>
<div>直接开机F2进入BIOS，Advanced选项卡里，选择Start Easy
Flash，然后选择事先放在C盘根目录下的BIOS文件（后缀为.212），过程很顺利，刷完就关机了，然后启动，提示要激活，选择稍后询问，选择OEM导入工具导入信息，出现了已激活，和ASUS的商标，至此全部搞定。</div>
<div><br /></div>
<div><br /></div>
<div>其实很想升级显卡、CPU、硬盘、内存，可惜没有米，可惜了解不足，可惜没有技术支持，等以后有精力有能力再折腾吧</div>
