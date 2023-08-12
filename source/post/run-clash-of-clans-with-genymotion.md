title: Genymotion 虚拟机 Clash of Clans
date: "2015-03-04 15:12:00"
update: ""
author: me
tags:
- MAC OS X
categories:
- MAC OS X
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



 安装流程:
 1. VirtualBox
 2. Genymotion 虚拟机
 3. 新建 Genymotion 虚拟机, 我选择Google Nexus 7的镜像, 因为是黑苹果, 所以不选择过高分辨率的 ROM, 等待完成
 4. [ARM Translation V1.1](http://pan.baidu.com/s/1o68yMGM) 拖入虚拟机中即可,会自动提示安装,重启
 5. 上面的链接包含一个 gapps for 4.3的, 不建议, 总是 play service 什么停止工作之类的错误, 建议去下谷歌安装器进行安装, 重启一下
 6. 4和5的顺序不能错, 可能会导致 COC 停止工作
 7. COC 下载慢, 可以去手机中提取 apk, 或者用 APK downloader 之类的服务进行下载, 百度到的是旧版本, 无意义还是要更新
 8. 翻 wall 有多种方案,一个是影梭, 或者HOSTS 文件, 或者在 mac 下使用 dnsmasq 进行泛解析, HOSTS 文件不长久
 > [https://cloudmonitor.ca.com/zh_cn/ping.php](https://cloudmonitor.ca.com/zh_cn/ping.php) 用于查询 Google 可用 ip
 
 
	  #dnsmasq 解析规则
	  address=/google.com/64.233.185.139
	  address=/ggpht.com/64.233.185.139
	  address=/googleusercontent.com/64.233.185.139
	  address=/gstatic.com/64.233.185.139
	  address=/googleapis.com/64.233.185.139
	  address=/appspot.com/64.233.185.139
	  address=/googlecode.com/64.233.185.139
	  address=/googlevideo.com/64.233.185.139
	  address=/youtube.com/64.233.185.139
	  address=/google.com.hk/64.233.185.139
	  address=/ytimg.com/64.233.185.139
	  address=/googlesource.com/64.233.185.139
	  address=/blogspot.com/64.233.185.139
	  address=/googlehosted.com/64.233.185.139
	  address=/googlelabs.com/64.233.185.139
	  address=/googlesource.com/64.233.185.139
	  address=/blogger.com/64.233.185.139
	  address=/goo.gl/64.233.185.139
	  address=/g.co/64.233.185.139
	  address=/googlemail.com/64.233.185.139
	  address=/gmail.com/64.233.185.139
	  address=/googlesource.com/64.233.185.139
	  
 > dnsmasq 不一定每次都可以, 可能可以打开 Google 但是又不能关联 COC 设备(登陆 g+ 时然后就没反应了, 无法跳出load village, 这个就看人品了, 也许是上面规则的不完善)
 > 影梭也看人品, 我之前试过几次, 但是经常无效, 不过我先安装 arm 翻译器再安装 Google 服务好像就可以用了,可能是这些原因,也可能和 arm 翻译器的版本有关,老版本可能会提示"刷入失败", 此处一定要刷入    成功才行, 如果影梭可用,那么都不是问题了
