title: 让Administrator拥有&quot;管理员权限&quot;
date: "2013-04-23 21:13:33"
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




			最近老是在郁闷一件事,为啥我明明已经是内置管理员了,我还是要右键管理员权限运行程序,不然老是保存个配置文件都不行.<br />
<br />
为啥当win8用内置管理员登录时,无法使用应用商店,而<br />
进入到组策略,<strong>计算机配置-Windows设置-安全设置</strong>-<span style="color: rgb(255,0,0)">用户账户控制:用户内置管理员帐号的管理员批准模式<br />
<font color="#000000">这么一搞就可以了.<br />
<br />
<font color="#000000">今天在折腾notepad2的时候,想替换自带的notepad,使用的<font color="#000000">是映像劫持的方法,可是后来我发现,当右键文本文件然后选编辑的时候,提示我需要权限提升<font color="#000000">.在试试的心态下,我用管理员<font color="#000000">身份运行了explorer.exe,再次重复操作,果然可以.<br />
<font color="#000000">这可以说明一件事,我<font color="#000000">不是管理员身份<br />
<br />
<font color="#000000">至此,所谓的"管理员批准模式",也就是一种变相的削权模式,这个模式下,不管你是什么身份的用户,你的身份永远比右键菜单里的"管理员"<font color="#000000">低几个等级,估计<font color="#FE4811">就比Guest高点<br />
<font color="#000000"><br />
<font color="#000000">于是果断关了<font color="#000000">这个模式,反正应用商店里也没装东西</font></font><br /></font></font></font></font></font></font></font></font></font></font></font></span>
