title: ubuntu 19.04 source
date: 2022-09-09 11:38:58 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



# ubuntu 19.04 中科大镜像源

由于19.04已经是old release,原先的源已经不能用, 需要修改地址

```
deb https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-updates main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-updates main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-backports main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-backports main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-security main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-security main restricted universe multiverse
deb https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-proposed main restricted universe multiverse
deb-src https://mirrors.ustc.edu.cn/ubuntu-old-releases/ubuntu/ disco-proposed main restricted universe multiverse
```
