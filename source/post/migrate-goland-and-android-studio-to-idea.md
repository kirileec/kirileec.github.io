title: Migrate Goland and Android Studio to IDEA
date: 2020-04-20 20:01:18 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


迁移Goland和Android Studio到IDEA
<!--more-->

最近遇到突然要跑一段java代码, 奈何之前安装的idea已经卸载. 还尝试了在线运行代码的工具, 无果. 无奈又装了idea, 陡然想起, 这玩意好像只要装个插件就能跑go. 小小搜索一下立马决定要卸载了Goland和Android Studio, 只留一个idea即可. 

## Goland迁移

问题不大, 需要手动安装`Go插件`和`File Watcher插件`, 安装了这俩就和`goland`一样一样了, 另外2020版本开始可以在插件商城搜索Chinese, 安装一个EAP版本的汉化补丁, 个人感觉比之前第三方的汉化插件要好点



## Android Studio迁移

`IDEA`安装完就自动安装了Android插件, 而如果电脑上已经安装了`Android Studio`, 那基本不需要什么设置就可以打开项目了. 遇到一个问题是: Android Studio由于是google改造版, 其内置了1.8版本的JDK, 而`IDEA`内置的JDK为最新版本, 这将导致可以build但是不能运行于模拟器的问题, 一个ClassNotDefined的报错. 解决方案为在本机安装1.8版本的JDK. 然后右击项目->项目结构->平台设置->SDK, 删掉所有不是1.8版本的条目
