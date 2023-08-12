title: win7共享闪讯无线法
date: "2012-03-04 10:16:54"
update: ""
author: me
tags:
- win7
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




			首先，先建立一个临时无线网络，各种参数随便设(什么?你不会,那问我啊,问百度去啊)
<div>然后，连接闪讯，成功连接后 ，打开“更改适配器设置”</div>
<div>ChinaNetSNWide 右键》属性，找到“网络”标签页，确认"Microsoft
网络文件与打印机共享"勾上了，最好那四个全勾上了<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=612685570100x0xq&amp;url=http://s11.sinaimg.cn/orignal/61268557gba61d83f1eda" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://s11.sinaimg.cn/middle/61268557gba61d83f1eda&amp;690" width="374" height="425" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></a></div>
<br />
<div>
然后切换到"共享"标签页,先选择"家庭网络连接"下面的,选择为"无线网络连接",有很多个无线的,最好想办法到"控制面板网络和
Internet网络连接"里删掉几个,否则麻烦自负.再然后,勾上"允许其他网络用户通过此计算机的Internet连接来连接"和"一旦网络上的计算机尝试访问Internet则建立一个拨号连接",然后只要没有提示错误信息("无法启用共享啥的")就一直确定.</div>
<div>
启动闪讯终结者,输入帐号密码,连接,退出闪讯,按Ctrl+Shift+Esc打开任务管理器中结束Netkeeper.exe进程</div>
<div>关键步骤:</div>
<div>右键"无线网络连接"&gt;属性&gt;双击"Internet协议版本
4",全部设置为自动获取.然后连接刚才设置的临时网络,用手机或者其他网络设备尝试连接,如果能上网,那恭喜你,尽情享受吧.如果不能上网,请往下看</div>
<div><br /></div>
<div><br /></div>
<div><br /></div>
<div>
尝试连接后不能上网,这时右键"无线网络连接"&gt;状态&gt;"详细信息",<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=612685570100x0xq&amp;url=http://s3.sinaimg.cn/orignal/61268557gba61dd853c62" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://s3.sinaimg.cn/middle/61268557gba61dd853c62&amp;690" width="320" height="217" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></a></div>
<br />
<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=612685570100x0xq&amp;url=http://s16.sinaimg.cn/orignal/61268557gba61ddcf901f" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/61268557gba61ddcf901f.jpg" width="250" height="256" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></a><br />
<br />
<div>记下那个"自动配置的IPv4地址"后面的数字,和下面的那一排数字.<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=612685570100x0xq&amp;url=http://s7.sinaimg.cn/orignal/61268557gba61da690376" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/61268557gba61da690376.jpg" width="679" height="424" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></a></div>
<br />
<div>&nbsp;<wbr> 同样的方法找到ChinaNetSNWide的"详细信息",记下IPv4
DNS服务器,右边的两排数字[很重要]<a href="http://photo.blog.sina.com.cn/showpic.html#blogid=612685570100x0xq&amp;url=http://s11.sinaimg.cn/orignal/61268557gba61dbb2346a" target="_blank"><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://s11.sinaimg.cn/middle/61268557gba61dbb2346a&amp;690" width="545" height="424" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></a></wbr></div>
<div><br /></div>
<div>然后转到手机或其他设备,设置IP为你刚记下的那个IP,并且最后一位不一样,如我记下的是169.254.47.16
那么我就设置 IP为169.254.47.X &nbsp;<wbr> (X=0~255中不等于16的任何值)
子网掩码设置和记下的一样,DNS一定要设置,搬上去即可,IPAD的IP设置方法可以参考"<a href="http://wenku.baidu.com/view/9f64c95c804d2b160b4ec055.html">http://wenku.baidu.com/view/9f64c95c804d2b160b4ec055</a></wbr><wbr>.html"</wbr></div>
<div>,屌丝木有IPad<img type="face" src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/E___6706EN00SIGG.gif" alt="win7共享闪讯无线法" title="win7共享闪讯无线法" /></div>
<div><br /></div>
<br />
