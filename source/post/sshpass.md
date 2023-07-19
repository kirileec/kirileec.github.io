title: sshpass
date: "2016-09-19 12:24:50"
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



`sshpass`: 用于解决ssh scp等命令需要手动输入密码的情况

使用方法很简单 只要在原有的命令前面加上
`sshpass -p 密码 ` 即可
例如`sshpass -p password ssh user@xxx.com`
