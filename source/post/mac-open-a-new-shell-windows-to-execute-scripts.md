title: Mac Open a New Shell Windows to Execute Scripts
date: 2020-02-05 20:08:20 +0800
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


Mac在终端中打开新终端运行代码
<!--more-->

## 背景

- 我有好多个一样的go程序要同时运行
- 很明显一个个打开终端太傻了

## 上代码

```sh
osascript -e 'tell application "Terminal" to do script "cd ~/Desktop/old/6/ &&~/Desktop/old/6/iotCardQuery"'
```
多拷贝几个, 然后修改一下, 保存为sh脚本, 运行之


PS: 记得cd到目录里, 否则找不到会配置文件什么
