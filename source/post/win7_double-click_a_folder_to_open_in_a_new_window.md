title: win7双击文件夹在新窗口打开
date: "2012-08-14 20:17:21"
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




<font style="font-size: 16px;"><b>症状：双击盘符，双击文件夹，会在新窗口中打开</b></font>
<div><font style="font-size: 16px;"><b>处理：在文件夹选项中设置在同一个窗口中打开----失效</b></font></div>
<div><font style="font-size: 16px;"><b>&nbsp;<wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> 删除注册表
&nbsp;</wbr><wbr>或者导入注册表方式-----失效</wbr></b></font></div>
<div><font style="font-size: 16px;"><b>&nbsp;<wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr> 运行以下代码</wbr></b></font></div>
<div><font style="font-size: 16px;"><b><span style="background-color: rgb(255, 255, 255); font-family: Tahoma, 微软雅黑; line-height: 18px;">
&nbsp;<wbr> &nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr> &nbsp;</wbr><wbr>
&nbsp;</wbr><wbr>&nbsp;</wbr><wbr></wbr></span><span style="background-color: rgb(255, 255, 255); font-family: Tahoma, 微软雅黑; line-height: 18px;">regsvr32
"%SystemRoot%System32actxprxy.dll"</span></b></font></div>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>&nbsp;<wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>&nbsp;</wbr><wbr>
regsvr32 "%ProgramFiles%Internet
Explorerieproxy.dll"</wbr></b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>发现后者无法运行，会报错。</b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>经过询问，妹子说把IE9卸载了，坑爹！</b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>于是重新下载并安装，重启。一看，哇，Internet
Explorer文件夹里面只有一个signup文件夹，根本没装上啊，再装一次，坑爹，说已经有更新得版本了，日，于是去修改注册表，发现行不通，天啊。</b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>最后，我发明了一个办法，把自己的IE目录下的ieproxy.dll和Internet
Explorer.exe拷贝过去，再次运行，成功！</b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b><br /></b></font></p>
<p style="font-family: Tahoma, 微软雅黑; margin: 5px auto; line-height: 18px; background-color: rgb(255, 255, 255);">
<font style="font-size: 16px;"><b>这个故事告诉我们，不要试图卸载微软自带的软件，特别是用360这种软件卸载，否则你会哭得很有节奏！</b></font></p>
