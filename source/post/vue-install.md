title: Vue Install
date: 2019-05-15 11:51:28 +0800
update: ""
author: me
tags: []
categories: []
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


Vue开发环境搭建
<!--more-->

# node.js 环境搭建（Windows）

1. 安装nvm-windows 
  - 为了方便，先卸载已有的nodejs，并删除 `C:\Program Files\nodejs` 和 `C:\User\<user>\AppData\Roaming\npm`两个目录，当然如果nvm不安装在C盘这个目录，可以不删。这两个目录如果不删除的话，nvm的安装会不成功（无法添加symlink链接）
  - `https://github.com/coreybutler/nvm-windows` 下载安装包，并安装
  - 输入nvm查看是否安装成功
  
2. 安装nodejs 
  - `nvm install 10.15.3` 安装nodejs想要的版本
  - `nvm npm_mirror https://npm.taobao.org/mirrors/npm/` 设置淘宝的镜像

# 安装vue 3

- `npm install -g @vue/cli`
- `vue --version`

# 创建一个element-ui的app

- `vue ui`创建一个typescript支持的vue
- `cd filestore-vue`
- `vue add element`
- `npm i element-ui -S`
- `npm install babel-plugin-component -D`

# 来一发Hello Vue
