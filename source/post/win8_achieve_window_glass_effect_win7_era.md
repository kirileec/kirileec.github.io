title: win8实现win7时代的窗口玻璃效果
date: "2013-04-05 13:18:39"
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




			windows8取消了玻璃效果，虽然有些地方仍然可以看出一些“残留物”，比如，鼠标放在右下角可以AEROPEEK预览桌面，但其实窗口边框的效果已经没了，记得有个帖子就是吐槽win8的风格不统一的，METRO和AERO混搭，按钮也是乱七八糟，幸好RTM版本一些很明显的“不合群”，没那么明星了。<br />
<br />
win7时代各种软件都追求透明玻璃效果，像是一种潮流一样。存在的有两种实现方式，一个是调用系统本身的透明功能，比如QQ，也有一些是使用软件自身的API，比如迅雷7。于是到了win8，调用系统的那些软件，开不了透明了。<br />
<br />
最近找到一个小程序，原理是在载入桌面环境时加载作者写的DWMGlass.dll到桌面进程中，实现AERO效果，使用HKEY_LOCAL_MACHINESOFTWAREMicrosoftWindows
NTCurrentVersionWindows这个位置的一个系统自动的进程注入模块，在这个AppInit_DLLs键值下填入DLL路径即可加载。<br />
<br />
于是开始研究，无奈基础不扎实，又系统中已经加载了MACTYPE的dll，不知道如何同时加载两个dll，各种纠结。经多次试验，得出方法：<br />

AppInit_DLLs下如此填写"D:DWMDWMGlass.dll",MacType.dll。<br />
具体方法为先清空键值，然后填入第一个"D:DWMDWMGlass.dll"，即DWMGlass.dll的放置的路径（或者使用该程序自带的reg文件导入，需要修改reg文件中相关路径），然后启动MACTYPE的程序，先切换到不加载，再切换为注册表加载，程序会自动在键值中增加一个，如此即可实现双dll加载。<br />
<br />
重启看效果，QQ的透明也可以开了，具体性能相关问题有待测试。<br />
