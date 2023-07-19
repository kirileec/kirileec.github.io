title: Goagent 黄字 红字
date: "2014-07-08 10:50:00"
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



```ini
[iplist]
google_cn = 
google_hk = 
google_talk = 
```
这三个位置, 后方的地址如果可以解析到可用的google IP 即可消除黄字,红字 `goodaddr=0`
于是先把后面的全部删除再说, 打开cmd ,
```cmd
nslookup www.google.com #OpenerDNS#
nslookup www.youtube.com #OpenerDNS#
```
两个都可以, `#OpenerDNS#` 表示一个可以解析到 正确IP的 DNS 地址, 相当于把人家DNS里的IP拿来自己用. IP复制的上面的位置即可正常.主要是 OpenerDNS 不能看视频,不得不这么干啊
