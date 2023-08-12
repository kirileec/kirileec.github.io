title: md 和 rd 命令，建立相同文件名的错乱文件夹
date: "2015-02-14 20:39:00"
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




`md "文件夹名 "`，引号外加空格即可创建成功

删除的话先使用`dir /x`,找到需要删除的文件的短文件名一般是 `XXX~1`
然后 `rd /S XXX~1`
