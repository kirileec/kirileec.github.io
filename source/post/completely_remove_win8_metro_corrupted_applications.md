title: 彻底删除win8 Metro 损坏应用
date: "2012-11-02 22:28:39"
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




			win8的应用有一定的几率会无法更新，显示未安装，是否重试，然后再所有应用里也找不到该应用，只能在应用商店的“你的应用”里看的到，于是。。。。。。蛋疼ing
<div><br /></div>
<div>进入正题：</div>
<div>学习自网上，做个记录。</div>
<div><br /></div>
<div>首先启动Windows PowerShell，有好多方法</div>
<div>
1)鼠标右键左下角&gt;命令提示符（管理员）&gt;在CMD界面输入PowerShell即可进入PowerShell模式，可以看到命令提示符当前行最前面出现了PS字样</div>
<div>2)<span style="line-height: 21px;">鼠标右键左下角&gt;命令提示符（管理员）&gt;在CMD界面输入start
powershell，就会弹出powershell的命令行界面</span></div>
<div><span style="line-height: 21px;">3)打开开始菜单，右键选所有应用，在里面可以找到Windows
PowerShell程序，但是记得用管理员权限运行，原因后面说</span></div>
<div><span style="line-height: 21px;"><br /></span></div>
<div>步骤：</div>
<div>命令一：Get-AppxPackage &nbsp;<wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> ##获取App列表</wbr></div>
<div>命令二：Remove-AppxPackage+空格+PackageFullName &nbsp;<wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr></wbr></div>
<div><span style="line-height: 21px;">PackageFullName需要在上面的列表中找
&nbsp;<wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
##其实这个名称是这个应用在C:Program FilesWindowsApps下的目录名</wbr></span></div>
<div>命令二需要管理员权限，否则会出现卸载失败的情况</div>
