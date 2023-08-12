title: BaiduExporter 多RPC地址设置
date: "2015-12-19 11:59:00"
update: ""
author: me
tags:
- OPENWRT
categories:
- OPENWRT
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



 1. 等待初始化
 2. 导出下载，设置
 3. `ADD RPC`添加一个RPC地址
 4. ### 删除下载路径 ###
 5. aria2的配置文件中设置dir参数

PS：本来还想拿github上的源码改改看能不能将RPC地址和下载路径结合在一起的，无奈不知道怎么下手

PS2：Aria2的RPC模式，逻辑应该是这样

1. 用命令行带参数或者加 `--conf-path`带配置文件启动的作用是一样的，
  就是指定在`本次`运行期间，不会变的参数，例如下载路径、线程数
2. 而其他参数则通过往 `http://localhost:6800/jsonrpc`发送POST数据包来指定
3. 如果POST过去的数据包中包含某个参数，则使用数据包中的参数，否则使用命令行参数和配置文件中的参数
