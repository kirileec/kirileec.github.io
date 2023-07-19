title: potplayer配置文件的导入到导出
date: "2013-01-17 22:39:06"
update: ""
author: me
tags:
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




			potplayer支持配置的导出，在程序主界面，按F5，出来的设置菜单的左下角即可找到，在弹出的界面中可以选择保存为ini配置文件，不推荐保存为reg注册表文件，为啥呢
<div><br /></div>
<div>首先potplayer应该没人用安装版的吧，一般都是绿色版的，所以ini文件比较符合绿色（牵强了点哈）</div>
<div><br /></div>
<div>
我的原因是：当我系统换成64位后，本来是32位的potplayer，一直在观望，在纠结要不要也换成64位的potplayer，听说是民间修改版的。
&nbsp;<wbr></wbr></div>
<div><br /></div>
<div>
总算去找了个版本想换，无奈这货的关于硬解的配置项挺多的，懒得再设置一遍，于是想导出配置。想起上次我导出的是reg文件，因为当时只是升级了32位的版本而已，这次是想把32位&gt;64位，就想着同时运行这俩货，测试下。于是问题来了，我这32位的配置项和64位的配置项在注册表的位置肯定不一样的吧（废话，那样我启动64位的不直接就可以使用原来的配置了么），所以导出注册表文件肯定不可行的，然后我试了下ini文件，试着放到了主程序目录下，启动，居然没用。</div>
<div><br /></div>
<div>
最后，原来是ini文件名的问题，需要改成和主程序同样的名字，如PotPlayerMini64.ini，如此就可以使用这个配置文件了。</div>
