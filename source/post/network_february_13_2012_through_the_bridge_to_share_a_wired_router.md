title: 2012年02月13日通过桥接共享有线路由器的网络
date: "2012-02-13 20:02:01"
update: ""
author: me
tags:
- 路由器
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




<p>
<strong>其实不是什么新的方法，也是刚网上看到的，主要针对一种特殊情况了。当然你也可以这么设置，我想是共通的，说不定这个还好点。</strong></p>
<p>
<strong>以前用win7的共享功能，一般上网方式都是，宽带连接，VPN连接，或者闪讯+“chinanet共享破解工具”（名字很多，我这么叫），其实本质都一样，一个活动的、可共享的Internet连接。</strong></p>
<p><strong>接
下来我讲讲特殊情况：路由器。可能有些人没有无线路由器，但是有有线路由器。这时就需要对本地连接做共享处理。我正好遇到了这种情况，尝试后我发
现，Windows提示我要把本地连接的ip设置为192.168.137.1，这就纠结了，我想如果本地连接ip变了，那路由器ip不是也得改，于是打
开了192.168.1.1，疼啊，DHCP项里根本只能修改最后一位啊，再试试改个子网掩码，还是不行...</strong></p>
<p><strong>索性不试了，搜索之....</strong></p>
<p><strong>终于在一个小地方瞄到了这么个东西：网桥。</strong></p>
<p><strong>动手，</strong></p>
<p><strong>首先转到”控制面板网络和 Internet网络连接“，然后按住Ctrl
&nbsp;<wbr>选中本地连接和无线网络连接，右键“桥接”，等待网桥建立完成</wbr></strong></p>
<p><strong><br /></strong></p>
<p><strong><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_jW2R_2b3800007be9125b.jpg" data-mce-src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_jW2R_2b3800007be9125b.jpg" border="0" name="image_operate_34721330830796713" alt="2012年02月13日通过桥接共享有线路由器的网络" title="2012年02月13日通过桥接共享有线路由器的网络" /><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_cczb_1ae300001109125b.jpg" data-mce-src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_cczb_1ae300001109125b.jpg" border="0" alt="2012年02月13日通过桥接共享有线路由器的网络" title="2012年02月13日通过桥接共享有线路由器的网络" /><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_Aqjp_6a7a00005456125b.jpg" data-mce-src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_Aqjp_6a7a00005456125b.jpg" border="0" name="image_operate_63281330830796801" alt="2012年02月13日通过桥接共享有线路由器的网络" title="2012年02月13日通过桥接共享有线路由器的网络" /></strong></p>
<p><strong>出现这么三个东西就成功了，然后右键网桥“属性”，验证ip是否是自动获取。ok</strong></p>
<p><strong>然后就在无线网络里添加个临时网络，具体设置可根据个人需求填写，比如</strong></p>
<p><strong><img src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_LreT_2181000005e8125d.jpg" data-mce-src="http://localhost/wp-content/uploads/pic/other_site/fmn_b_large_LreT_2181000005e8125d.jpg" border="0" name="image_operate_25421330830796897" alt="2012年02月13日通过桥接共享有线路由器的网络" title="2012年02月13日通过桥接共享有线路由器的网络" /></strong></p>
<p><strong>建议WEP加密，密码输个10位数字即可</strong></p>
<p><strong>移动设备这边呢，比如Nokia的只需添加个接入点即可</strong></p>
<p><strong><br /></strong></p>
<p>
<strong>优点：很大的优点，可以解决某些移动设备必须电脑端和设备端都要手动设置ip的问题（几千块的高级货无视这句话吧，渣手机自动获取ip能力有限....渣电脑自动分配ip能力有限....），此方法不用设ip。</strong></p>
<p><strong><br /></strong></p>
