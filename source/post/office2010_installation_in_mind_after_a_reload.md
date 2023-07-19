title: 记一次重装后的office2010安装
date: "2011-10-22 14:14:00"
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



继上次中毒后，选择了重装这条路，幸好系统盘里除了软件什么都没有，省去了很多步骤，采用方法

[链接][1]

只备份了utorrent的记录文件【运行`%Appdata%`即可找到】和桌面上的文件，开始重装......

尝试了一下那个传说中的win7精简版，使用GHOST安装，安装过程一切正常，装完后，关闭UAC，激活，还原桌面，安装显卡驱动，设置环境变量等等，突然看到桌面上一堆office文件，想起要装office。本来安装一切顺利，但因为采用了，一种特别的激活方式（删除文件，删除注册表），导致打开文件时提示许可证什么的，郁闷，只好重新安装，然而新问题出来了：每次安装到最后，总会提示安装过程中出错，我想难道是卸载未完全，于是拿出了office2010完全卸载工具，清理......重启，安装.....汗，再次出现了。没办法，我可不想重装系统，搜索.....终于发现了一篇  
[文章][2]

，帮了大忙，果然是其中一个组件的问题，于是尝试之，成功！哈哈！


同时想分享一个技巧，即自定义工具，运行cmd后，cd到office2010的虚拟光驱的盘符，然后输入setup.exe
/admin回车可以打开，在里面配置各种安装选项，可以使你的后续安装过程更加简化（无需设置了），重点是里面有一项是“删除以前的office”而这一项在直接启动setup.exe是无法设置的。同时这个方法保存的配置文件可以留着下次安装用或者给别人用，很好。
据说原文地址是
[原文地址][3]
反正我卡得打不开
[链接][4]
这个打得开



  [1]: http://blog.sina.com.cn/s/blog_612685570100u9w7.html
  [2]: http://wenku.baidu.com/view/48df653b580216fc700afd65.html
  [3]: http://www.sxqisheng.com/jishuinfo.asp?id=59
  [4]: http://blog.pconline.com.cn/article/2240473.html
