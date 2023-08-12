title: 'Linux在root用户下删除文件提示,Operation not permitted '
date: "2016-02-08 14:09:00"
update: ""
author: me
tags:
- Linux
categories:
- Linux
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



```    
lsattr -a
chattr -i

```

第一个命令查看文件是否带有 i 属性
第二个命令去除文件的 i 属性
