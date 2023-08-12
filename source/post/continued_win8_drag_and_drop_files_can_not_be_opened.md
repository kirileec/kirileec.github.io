title: 续：win8拖拽文件无法打开
date: "2013-01-09 23:08:45"
update: ""
author: me
tags:
- win8
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




			接上一篇，当你的程序和资源管理器处在不同的权限运行时，从资源管理器拖放到程序时，无法进行拖动文件打开。
<div>解决办法有了，比较完美</div>
<div><br /></div>
<div>首先你的程序用管理员权限运行，然后只要能使资源管理器在管理员权限下运行即可</div>
<div><br /></div>
<div>
定位到HKEY_CLASSES_ROOTAppID{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}</div>
<div>
右键〉权限〉高级〉更改（在最上面，有个拥有者的地方），将原来的TrustedInstaller更改为Administrtor<strong><font color="red">s</font></strong></div>
<div>然后将Administrtor<font color="red" style="font-weight: bold;">s</font><font color="#040000">这个用户的权限改为<b>完全控制，</b></font></div>
<div><font color="#040000"><b>最后，把</b></font><span style="line-height: 21px;">{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}右边展开的里面的RunAs项删除或者重命名，即时生效。
&nbsp;<wbr></wbr></span></div>
<div><span style="line-height: 21px;"><br /></span></div>
<div>
然后在C：windows下explorer.exe的右键菜单里就可以看到以管理员权限运行了（当是普通的管理员账户时，explorer.exe右键是没有的）</div>
<div><br /></div>
<div>
以上就解决了任务管理器同时存在普通管理员权限的explorer.exe，和超级管理员权限的explorer.exe(原先未修改注册表时，RunAs的键值是Interactive
User，意为不活动的用户，所以原先是不可能同时存在两种权限的explorer.exe的)</div>
<div><br /></div>
<div>最后，新建一个快捷方式，定义目标位置为%SystemRoot%explorer.exe
,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}，重命名之为“高权限explorer”(或者你喜欢的名字),右键属性里，快捷方式选项卡，高级按钮，选择以管理员权限运行。以后当你需要拖拽文件操作时，运行这个快捷方式方式即可，或者把它固定到任务栏替换原来的那个，因为低权限的explorer.exe基本没什么用了，同时开机自动运行的explorer是普通的权限，于是就实现了既可以管理员权限运行资源管理器同时又不影响Metro应用的运行。</div>
