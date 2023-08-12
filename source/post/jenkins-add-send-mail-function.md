title: Jenkins 添加发送邮件功能
date: "2016-09-13 22:11:00"
update: ""
author: me
tags:
- CSharp-CI
categories:
- CSharp-CI
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



首先必须要配置 `Jenkins Location` 下的管理员邮箱地址, 用于发送邮件, 我这里使用yeah.net的网易邮箱

安装插件`Email Extension Plugin`

`SMTP SERVER`: `smtp.yeah.net`
`Default User E-mail suffix`: `@yeah.net`
`Default Recipients`: `邮箱地址`


邮件通知下的配置
和上面类似

使用SMTP认证并且勾上SSL, 用户名和密码分别为邮箱地址和密码(管理员的发件邮箱)

然后底下可以填写一个测试邮箱地址进行发送测试
