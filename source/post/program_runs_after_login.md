title: 程序登录后运行
date: "2012-06-14 12:58:24"
update: ""
author: me
tags:
- 组策略
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




			以前希望一个程序在登录后运行用的方法是使用计划任务，但是计划任务打开就非常慢，哥瞬间就虚了啊
<div><br /></div>
<div>最近乱翻的时候发现了另一个地方---------组策略</div>
<div><br /></div>
<div>
按WIN+R打开运行，输入“gpedit.msc”，打开本地组策略编辑器，依次展开用户配置，管理模板，系统，登录，找到在用户登录时运行这些程序，双击它，选择已启用，然后根据右下角的帮助的提示操作，输入程序的绝对路径即可。</div>
