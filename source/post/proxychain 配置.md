title: proxychain 配置
date: "2015-06-23 21:14:00"
update: ""
author: me
tags:
- MAC OS X
categories:
- MAC OS X
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

    brew install proxychains-ng
### 配置    
    
    cd /usr/local/etc
    vi proxychains.conf
`[ProxyList]`段修改为`socks5  192.168.10.1 1081`

### 个性化

    cd /usr/local/Cellar/proxychains-ng/4.8.1/bin/
    //重命名原二进制文件名
    mv proxychains4 pc
    //建立新的链接
    ln -s pc /usr/local/bin/pc
    //移除原链接
    rm proxychains
    
### 使用

    pc curl twitter.com
