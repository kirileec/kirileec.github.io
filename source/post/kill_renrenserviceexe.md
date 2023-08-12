title: 干掉renrenservice.exe
date: "2012-10-08 21:28:31"
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




			被此程序骚扰已久，难免不舒服，到了win8这种想法更重了。听说win8的应用能拿到的权限是有限的，就连QQ都只做聊天的工作了，我觉得挺好的，于是连UAC也舍不得关了，呵呵<img type="face" src="http://simg.sinajs.cn/blog7style/images/common/sg_trans.gif" real_src="http://localhost/wp-content/uploads/pic/E___6725EN00SIGG.gif" alt="干掉renrenservice.exe" title="干掉renrenservice.exe" />
<div><br /></div>
<div>进入正题：</div>
<div><br /></div>
<div><font color="#454545" face="Microsoft Yahei, 微软雅黑, Tahoma, Arial, Helvetica, STHeiti">在C:Users你的用户名AppDataRoamingrenren.com下找到以下几个文件</font></div>
<div><span style="color: rgb(69, 69, 69); font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; background-color: rgb(255, 255, 255);">
crashrept.exe&nbsp;<wbr></wbr></span></div>
<div><span style="color: rgb(69, 69, 69); font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; background-color: rgb(255, 255, 255);">
RenRenMsg.exe&nbsp;<wbr></wbr></span></div>
<div><span style="color: rgb(69, 69, 69); font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; background-color: rgb(255, 255, 255);">
RenRenService.exe&nbsp;<wbr></wbr></span></div>
<div><span style="color: rgb(69, 69, 69); font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; background-color: rgb(255, 255, 255);">
RenRenUpdate.exe</span></div>
<div><font color="#454545" face="Microsoft Yahei, 微软雅黑, Tahoma, Arial, Helvetica, STHeiti">直接删了，然后新建文件夹并重命名，得到四个名为</font></div>
<div>
<div style="line-height: 21px;"><span style="font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; color: rgb(69, 69, 69); background-color: rgb(255, 255, 255);">
crashrept.exe&nbsp;<wbr></wbr></span></div>
<div style="line-height: 21px;"><span style="font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; color: rgb(69, 69, 69); background-color: rgb(255, 255, 255);">
RenRenMsg.exe&nbsp;<wbr></wbr></span></div>
<div style="line-height: 21px;"><span style="font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; color: rgb(69, 69, 69); background-color: rgb(255, 255, 255);">
RenRenService.exe&nbsp;<wbr></wbr></span></div>
<div style="line-height: 21px;"><span style="font-family: 'Microsoft Yahei', 微软雅黑, Tahoma, Arial, Helvetica, sTHeiti; line-height: 21px; color: rgb(69, 69, 69); background-color: rgb(255, 255, 255);">
RenRenUpdate.exe</span></div>
</div>
<div style="line-height: 21px;">
的文件夹，在你没对win8的权限进行操作之前，这几个文件夹是默认为只读的</div>
<div style="line-height: 21px;"><br /></div>
<div style="line-height: 21px;">但是这样操作后，发现一个更严重的情况，流氓至极</div>
<div style="line-height: 21px;">
客户端自动去网络上下载RenRenServicePackage.zip.tmp，这个包，即自动恢复</div>
<div style="line-height: 21px;">索性删了这个文件，然后新建一个文件夹命名之。</div>
<div style="line-height: 21px;">
不放心，于是用自带的资源监视器，查看网络访问，大致是北京的ip和西安的ip，难以确定。</div>
<div style="line-height: 21px;">
最后，不敢下手，给跪！重新删掉那几个文件夹，卸载好了，折腾不起。。。。</div>
