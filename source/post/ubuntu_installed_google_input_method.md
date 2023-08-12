title: ubuntu下安装google输入法
date: "2012-03-18 19:52:53"
update: ""
author: me
tags:
- 杂谈
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




			学习自网上，做个记录<br />
谷歌拼音输入法安装步骤(需要编译)：<br />
1. sudo apt-get install autotools-dev libgtk2.0-dev libscim-dev
libtool automake (编译环境安装)<br />
或者 aptitude install autotools-dev libgtk2.0-dev libscim-dev libtool
automake可自动安装<br />
2. sudo apt-get install git<br />
3. git clone git://github.com/tchaikov/scim-googlepinyin.git
(编译文件下载)<br />
4. sudo apt-get install scim （安装scim，必须的）<br />
<br />
进入下载文件目录然后开始编译：[这个目录其实并不在下载目录里，而是它的上一级，即主文件夹，我这是这样的]<br />
&nbsp;<wbr>./autogen.sh<br />
make<br />
sudo make install<br />
<br />
开始运行谷歌输入法：<br />
scim -d<br />
系统设置--》语言支持：输入法，选择scim作为默认输入法就OK了。<br />
这输入法很好用，至少比自带的好啊，不我以后都不准备换了啊。就是有一点，每次重启后都要重新调整候选框的位置，也就是候选词框不跟随输入位置，郁闷得很。<br />
<br />
<br />
参考：http://forum.ubuntu.org.cn/viewtopic.php?f=8&amp;t=273683&amp;start=105<br />
<br />
</wbr>
