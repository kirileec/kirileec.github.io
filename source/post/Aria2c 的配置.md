title: Aria2c 的配置
date: "2015-06-22 19:25:00"
update: ""
author: me
tags:
- mac
categories:
- mac
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



### 安装

    brew install aria2
    mkdir .aria2
    cd .aria2
    vi aria2.conf

### 配置

    #允许rpc
    enable-rpc=true
    #允许所有来源, web界面跨域权限需要
    rpc-allow-origin-all=true
    #允许外部访问，false的话只监听本地端口
    rpc-listen-all=true
    #最大同时下载数(任务数), 路由建议值: 3
    max-concurrent-downloads=5
    #断点续传
    continue=true
    #同服务器连接数
    max-connection-per-server=5
    #最小文件分片大小, 下载线程数上限取决于能分出多少片, 对于小文件重要
    min-split-size=10M
    #单文件最大线程数, 路由建议值: 5
    split=10
    #下载速度限制
    max-overall-download-limit=0
    #单文件速度限制
    max-download-limit=0
    #上传速度限制
    max-overall-upload-limit=0
    #单文件速度限制
    max-upload-limit=0
    #文件保存路径, 默认为当前启动位置
    dir=/Volumes/DATA/thunder
            ⬆️文件保存路径
    #文件预分配, 能有效降低文件碎片, 提高磁盘性能. 缺点是预分配时间较长
    #所需时间 none < falloc ? trunc << prealloc, falloc和trunc需要文件系统和内核支持
    file-allocation=prealloc

> :wq

### 运行
- 终端执行



    aria2c -D

- VPS上执行


    cd /var/www
    git clone https://github.com/binux/yaaw

- 访问 [链接](http://kirile.ml/yaaw/index.html)

- 右上角的`Setting` ，改 `JSON-RPC Path` 为 `http://127.0.0.1:6800/jsonrpc`
- [Chrome 插件 包括 迅雷离线/QQ旋风/百度网盘/360云盘等导出下载到 aria2](https://chrome.google.com/webstore/detail/mblmc%E8%BF%85%E9%9B%B7%E7%A6%BB%E7%BA%BFqq%E6%97%8B%E9%A3%8E%E7%99%BE%E5%BA%A6%E7%BD%91%E7%9B%98360%E4%BA%91%E7%9B%98%E7%AD%89ar/iamaphkapjbdhhpdapkalhanifedeged) 
- [115网盘chrome插件](https://chrome.google.com/webstore/detail/115exporter/ojafklbojgenkohhdgdjeaepnbjffdjf)
- [添加到Aria2 接管普通下载](https://chrome.google.com/webstore/detail/%E6%B7%BB%E5%8A%A0%E5%88%B0aria2/nimeojfecmndgolmlmjghjmbpdkhhogl)
- [BaiduExporter 据说可以破百度的限速](https://chrome.google.com/webstore/detail/baiduexporter/mjaenbjdjmgolhoafkohbhhbaiedbkno)
