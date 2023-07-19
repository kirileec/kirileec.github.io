title: Win8 IE10只能用管理员权限运行的问题解决方案
date: "2012-11-10 14:10:20"
update: ""
author: me
tags:
- ie10
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




			最近一段时间，有很多人都发生了IE10无法运行的问题。
<div>具体表现是：</div>
<div><br /></div>
<div>
不管是点击快捷方式还是点击任务栏图标，或者点击开始菜单，或者到IE的目录下双击运行，全都无法运行，对，是无法运行！！！！！！检测过，任务管理器里都不会出现IE的进程。然后坑爹的是，当你使用管理员权限，IE又能运行了，擦擦擦擦！！！这是多么的蛋疼啊。</div>
<div><br /></div>
<div>
于是无法忍受了，到处搜索，还是老样子，网上都是一些要么没发生这种现象的，要么是解决了还不知道怎么解决的，要么就是人云亦云的。有以下几种方法：</div>
<div><br /></div>
<div>1.迅雷插件引起的，卸载迅雷 &nbsp;<wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr>###蛋啊，怎么可能，迅雷是刚装完系统就装着的，那时候IE怎么不出问题，难道还远程操作么。于是。。。。迅雷不在了，懒得装回去了，先这么着吧，用到再说</wbr></div>
<div><br /></div>
<div>2.新建账户 &nbsp;<wbr>
&nbsp;</wbr><wbr>###没错的确可以解决，我还顺便把超级管理员账户给开了。可是啊，我不乐意这么干，原因很多，不赘述，总之就是不乐意</wbr></div>
<div><br /></div>
<div>3.控制面板程序默认程序 的最后一项，然后是“自定义”，默认WEB浏览器。。。。。 &nbsp;<wbr>
##没用，完全没用！！！我完全无法修改那个WEB浏览器！！！！修改完，点进去还是原来的</wbr></div>
<div><br /></div>
<div>4.魔方 &nbsp;<wbr> &nbsp;</wbr><wbr>
##可以，成功了，现在正常了，下文分析</wbr></div>
<div><br /></div>
<div><br /></div>
<div>分析：</div>
<div>首先使用魔方的修复大师里面的浏览器修复，一运行，切换，乖乖，怎么才四项啊，嘿为啥前两项会是红的呢</div>
<div>1.首页修复</div>
<div>2.搜索引擎修复</div>
<div><br /></div>
<div>于是抱着试试的想法，勾上了这两项，然后修复了一下。。。（修复中。。。）</div>
<div><br /></div>
<div>成功了，居然成功运行了IE，坑爹啊。</div>
<div><br /></div>
<div>
不放松，果断排查原因，顺手把IE主页改了回来，果断必应的主页给力哈，然后还是正常，嘿不错，那么可以推测是搜索引擎的问题（如果魔方没干别的事的话），有兴趣可以自己去修改那个搜索引擎试试看行不行。另外加载项那边在修复完成后flash插件出现了，不知道咋回事</div>
<div><br /></div>
<div><br /></div>
<div><font color="#ED1C24">2013-1-18编辑一个新的方法</font></div>
<div><font color="#ED1C24">打开Regedit，找到HKEY_CURRENT_USERSoftwareMicrosoftInternet
ExplorerMain
&nbsp;<wbr>对Main右键——权限。然后点击“高级”，再点击“启用继承”。&nbsp;</wbr><wbr></wbr></font></div>
<div><br /></div>
<div>问题来源：</div>
<div><br /></div>
<div>
不要听那些人的“最近有没有装优化软件”了，很傻，真的，真心的。你应该排查最近是不是装了什么跟浏览器有直接关系的软件，不一定是工具栏什么的，不管什么软件都有可能，因为有“绑定插件，强制安装”。</div>
<div><br /></div>
<div>至此，又一次折腾结束</div>
