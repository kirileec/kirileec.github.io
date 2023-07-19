title: win8 pagefile.sys文件过大
date: "2013-03-24 23:13:01"
update: ""
author: me
tags:
- windows8
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




			pagefile是虚拟内存的页面文件，默认存放在C根目录，隐藏，系统属性。<br />
<br />
今天突然发现C盘红了，前两天还有10G空余的呢，于是祭出神器SpaceSniffer<br />
<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=61268557010169zc&amp;url=http://s14.sinaimg.cn/orignal/612685574d8ad1ed64dfd&amp;690" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/612685574d8ad1ed64dfd.jpg" height="58" width="279" alt="win8&nbsp;&lt;wbr&gt;pagefile.sys文件过大" /><wbr>pagefile.sys文件过大"  TITLE="win8&nbsp;</wbr><wbr>pagefile.sys文件过大" /></wbr></a><br />
<br />
<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=61268557010169zc&amp;url=http://s14.sinaimg.cn/orignal/612685574d8ad1f00918d&amp;690" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/612685574d8ad1f00918d.jpg" name="image_operate_7311364138730379" alt="win8&nbsp;&lt;wbr&gt;pagefile.sys文件过大" /><wbr>pagefile.sys文件过大"  TITLE="win8&nbsp;</wbr><wbr>pagefile.sys文件过大" /></wbr></a><br />
瞬间被吓出翔了，怎么这么大，说好的1.5倍呢<br />
<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=61268557010169zc&amp;url=http://s6.sinaimg.cn/orignal/612685574d8ad1edc0b45&amp;690" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/612685574d8ad1edc0b45.jpg" name="image_operate_43881364139094789" alt="win8&nbsp;&lt;wbr&gt;pagefile.sys文件过大" /><wbr>pagefile.sys文件过大"  TITLE="win8&nbsp;</wbr><wbr>pagefile.sys文件过大" /></wbr></a><br />
<br />
百般思索查找，终于明白了原因，原来是好久没重启的原因，不重启的话，win8的很多东西都不会改变，比如这个虚拟内存，以前win7
XP会在关机后自动释放内存，包括虚拟内存的内容。而win8的快速启动，把部分内存内容保存在硬盘中也就是这个pagefile.sys中。我又想起来，昨晚刚好玩了个使命召唤，怪不得突然空间不足了。<br />

同时，我觉得一些游戏的资源读取后可能都是保存在这个文件中，所以游戏关闭后再次启动，读取地图的速度也会比较快，估计就是这个原因。<br />

有时候，关闭游戏后，会有一段时间非常的卡，这坑爹的设置。<br />
于是我想我知道为什么需要大内存了，2G 4G哪里够啊。以后配电脑果断就如下配置了：<br />
<br />
CPU：这么说来个四核的，以不成为瓶颈为准<br />
显卡：别的不管，N卡，显卡排名怎么说要在50名左右，最好再两张卡SLI<br />
硬盘：固态的，整个系统全搞进去，软件能放的也放进去，然后再装个7200的机械硬盘<br />
内存：果断8G双通道，关了该死的虚拟内存<br />
<br />
