title: VPS换系统 Ubuntu-&gt;CentOS
date: "2016-02-07 14:52:00"
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



 > 原系统: Ubuntu 12.04
 > 目标系统: CentOS 6

###准备
- Snapshots 建立快照
- 备份数据库
- 备份主题和插件
- 备份nginx配置和php配置

###流程

- 更换系统Install New OS
- 使用lnmp安装环境,虽然这个比较慢,但总归少了很多弯路
- `/usr/local/nginx/conf/nginx.conf` 的 `server` 段的 `include` 修改为
    
```
    include enable-php-pathinfo.conf;  ##开启pathinfo功能
    include typecho.conf;              ##typecho的伪静态    
```
- 创建mysql数据库
- 安装Typecho,还原数据库
- 恢复插件和主题
