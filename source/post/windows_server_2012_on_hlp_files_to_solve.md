title: Windows Server 2012关于.hlp文件的解决
date: "2013-04-12 23:56:28"
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




激动,太激动了,我又相信Server 2012了.
详情如下:

小道消息,服务器系统具有很好的定制性和能更好地发挥硬件的性能,于是越发向往.对于我这个从来没装过server的小菜鸟来说,无疑是经过强烈的思想斗争的.终于,在一次系统无法启动和尝试多种修复无果的情况下,果断祭出"珍藏多年"的Windows
Server 2012的原版ISO(早准备好了啊喂!!!).
安装过程比win8更加简单,因为没有所谓的个性化,也就少了许多设置,而且默认是超级管理员账户登录,爽.
装完后,用网上的方法,成功添加了桌面功能,实现了桌面化,装完各种软件,可怜的C盘又减小了,很紧张的啊.

最近在折腾Delphi7,因为有Win8系统中的经验,我知道从某个版本起,.hlp已经不被支持了(不能直接打开),于是我熟门熟路去了这里`http://support.microsoft.com/kb/917607`
传说中的可以提供某个版本起.hlp文件的支持,主体是一个更新包.可是令人蛋疼的是注意 Windows 8 Server Beta 不支持 Windows
帮助程序，且不提供适用于此 Windows 版本的下载。

啊啊啊啊啊,我不信,明明win8都支持的,我不信啊,于是果断下了win8版本的更新包,可是我发现,我太笨了,这两个系统的版本号本身就不同,于是,直接就安装不上,各种报错.

然后我就开始各方打听,希望有哪位大侠遇到这个问题并解决它了,然后又凑巧地发出来了,那该多好,可惜,我错了.

为了delphi中那么多个的hlp文件,不能放弃啊,于是去搜索第三方打开工具,无果,我甚至还尝试了把所有hlp文件反编译然后转成chm,可是啊,虽然能转,但是delphi又不会去使用chm文件,F1废了,我可不会没事就去看chm文件啊.

后来还尝试过修改MSU更新包里面的一些内容,试图让更新包能够强制装上,可惜啊,我根本不能打包MSU文件啊,坑爹啊.

惯例吧,解决办法.

方法就是去找老版的`winhlp32.exe`单文件.具体是什么时代的不知道了,可以附上版本信息
`5.1.2600.5512`大小为264kb,而hlp文件是无法修改关联的,估计被锁定为`C:\windows\winhlp32.exe`,所以只能替换,替换之前我发现一个问题,就是未替换的情况下,原来的`winhlp32.exe`大小只有10kb,你觉得10kb能干啥,只能起到跳转到windows的联机帮助窗口上,这就是为什么不能打开hlp的原因了.

本来都因为这问题想换回win8去的,这下好了,安逸了.