title: 安卓桌面残留图标清理（绿色机器人）
date: "2016-02-11 16:57:16"
update: ""
author: me
tags:
- android
categories:
- android
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



方法：

> 1. Root Explorer在手机存储的 `/data/data/` 目录下搜索`launcher.db`, 因为有时候不一定是`com.android.launcher`,特别是山寨机
> 2. win下随便下一个SqlLite数据库可视化工具,然后打开`launcher.db`,定位到`favorites`表, 删除不需要的条目
> 3. 把文件传回去覆盖
> PS: 当然需要ROOT权限,没ROOT也不至于会出现残留啥的
