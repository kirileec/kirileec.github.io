title: Nexus 4 Enable Google Play Complete Edition &amp; Google Now in China
date: "2014-03-03 12:41:00"
update: ""
author: me
tags:
- Nexus 4
categories:
- Nexus 4
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



依次按照http://www.i7086.com/jiesuoplaystore所讲的办法进行操作

以下为电脑端操作

A、挂上美国V.P.N

B、打开美版Play找一本需要付费的Book，点击`Buy`按钮，出现`Google Wallet`支付界面，默认勾选的是`Credit or debit card`，现在你将其切换到`Google Play Gift Card or Promo Code`，然后填写信息， `HOME LOCATION`默认是`United States`不要改，在`NAME`栏输入你的姓名英文，不一定是真名，并输入`ZIP code`，就填的`97224`，可以随便填一个美国的合法`ZIP code`，下面重点来了，你要输入`Gift Card code`，乱输的Code是无法过关的，你要输入20位的Code而且不能是纯数字但是纯字母可以，例如我输入的是`ABCDABCDABCDABCDABCD`，然后点`Accept and continue`就进入下一页面了，页面会提示
> “The Gift Card code you entered is invalid. Please try entering again or contact the support team”

也就是我们输入的`Gift Card code`是无效的，不用管它，可以关掉此页面了

C、用美国V.P.N重新打开一个Play页面，找一本免费的Book，点击Free按钮，这时候你会发现付费页面的默认支付方式变成了`Google Play balance $0.00`，点击`Accept and Buy`可以顺利购买，会弹出页面

> “Congratulations!XXXhas been added to your library”

说明付费成功，接下来把免费的`Magazine、Music、Movie`都买一遍，再买一个Play Store没有的免费App，例如`Pandora® internet radio`。

D、这时候你们把V.P.N关掉，刷新试试看，即使不用任何FQ手段你们也能使用美版Play Store，这时候你也可以打开你的手机和平板看看，你所有的设备都解锁了美版Play Store，只要你帐号登录的设备都是美版Play Store

接下来是手机端了

操作后发现在C步时不会出现`Google Play balance`，因此没有后续

然后开启`fqrouter2`，进入设置，“清理后打开”，找一本免费的图书，选`Add To My Library`，后面选第二个选项，第一个是信用卡，暂时没卡。

然后随意填入20位数字，然后继续操作即，提示`Code Invalid` 这样就成功了，可以测试下把`fqrouter2`关掉试试看能不能直接进完整版



接下来按照`http://www.inexus.co/article-1376-1.html`的方法

适用于已经正常开机, 而且安装好了各种软件, 不想清空自己的数据的人
先把"fqrouter2和Market Unlocker Pro"下载并安装好,不用打开.

a.修改系统语言为`English(US)`, 进入手机的设置-应用程序-所有应用程序, 找到`"Google Play Services"`选择`"Clear cache"`, 接着依次找到"Google Play Store","Google Search"进行同样的" "操作[no need to clear data]</span>
b.打开`Market Unlocker Pro`,向右边滑动一下,打开市场界面,选择`USA(T-Mobile)`, 切换到美国的Play市场. 软件会提示你是否打开Play商店, 选择不打开</span>. (注意: 这步很重要,即使你已经解锁市场也需要进行此步骤的操作, 包括通过购买应用解锁的也是同样!)[我的情况并没有提示是否打开Play商店，所以无所谓了]
c.进入`系统设置`-`Location`, 把开关关掉. 打开`fqrouter2`,加载完成后, 选择 开机自动启动软件 (十分重要!)
d.关机, 拔出sim卡
e.开机进入桌面,确认`fqrouter2`是否正常启动, 此步骤中稍微等等无线网络, 不要一进入桌面就着急设置,等十几秒左右吧.[由于在4.4.2下，这个软件开机自启动的过程比较慢，要挺久的。又由于我的无线是要经过网页验证的，所以等这个软件启动完成之后，再连验证无线]
f.从底端向上滑打开`Google Now`,按照步骤就OK了!
g.如果没有看到`Google Now`说明步骤有错, 请重试!
