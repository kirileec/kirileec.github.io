title: win8开机自动打开NumLock
date: "2012-10-17 14:28:00"
update: ""
author: me
tags:
- 小键盘
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




			这个居然没什么人关心，还好我搜索能力还行。唉，到处都是不折腾的傻瓜派，搜到的帖子基本都是“我也有相同问题啊。。。。”“重启啊。。。。”之类的云云，无语了好久。。
<div><br /></div>
<div>我找的方法有四个：</div>
<div>
1.BIOS设置。这真的是坑爹的货，应该是针对最古老的系统和电脑的，你说win7下完全正常的东西，到win8下BIOS还能变了？</div>
<div>PS：台式机可以试试</div>
<div>
2.重启。即在登录界面打开NumLock然后直接重启，我的感觉，直接说吧，没用，win8下没用！！！！！！！其他系统再说吧</div>
<div>3.win+R 〉“sysedit”
〉回车，启用16位程序支持，切换到Config.sys的页面，在Files=40下面加一行，输入“<span style="color: rgb(68, 68, 68); font-family: Tahoma, 'Microsoft Yahei', simsun; line-height: 28px; background-color: rgb(255, 255, 255);">NumLock=ON”，不带引号，保存并关闭。</span></div>
<div><font color="#444444" face="Tahoma, Microsoft Yahei, Simsun"><span style="line-height: 28px;">PS：尚未测试，建议不这么干，除非有经验，sys这种文件还是少操作的好</span></font></div>
<div><font color="#444444" face="Tahoma, Microsoft Yahei, Simsun"><span style="line-height: 28px;">4.注册表。我搜到的文章基本说注册表没用的，其实是他们找的方法有错误吧。真正的注册表位置应该是</span></font></div>
<div>
<div><font color="#444444" face="Tahoma, Microsoft Yahei, Simsun"><span style="line-height: 28px;">[HKEY_USERS.DEFAULTControl
PanelKeyboard]</span></font></div>
<div>"InitialKeyboardIndicator<wbr>s"="2"</wbr></div>
<div><br /></div>
<div>
解释一下，HKEY_USERS代表的是本机上所有用户，可能他们找的是HKEY_CURRENT_USERS，这样就是概念的问题了，前者是所有用户，而后者是当前用户，但是在你还在输入密码的时候，你还不是当前用户，于是必须改前面那个位置，找到</div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">InitialKeyboardIndicator<wbr>s更改其值为2即可，实测成功。有兴趣的可以修改后，导出注册表，备份起来。</wbr></span></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;"><br /></span></div>
<div><font color="#444444">吐槽下win8的图片密码，为啥我键盘输入比拿鼠标划快呢，果然是平板设计的么，</font></div>
<div><font color="#444444">为啥要划三次呢</font></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">啥要划三次呢</span></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">要划三次呢</span></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">划三次呢</span></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">三次呢</span></div>
<div><span style="color: rgb(68, 68, 68); line-height: 21px;">次呢</span></div>
<div><font color="#444444">呢</font></div>
<div><br /></div>
</div>
