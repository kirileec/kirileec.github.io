title: move disk to another on pve
date: 2023-02-10 10:05:45 +0800
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



# pve下移动磁盘到另一台虚拟机

由于开了一台新的虚拟机，但之前有台虚拟机上有点文件。资源有限，两台一起开可能比较卡，于是就打算把虚拟磁盘直接迁移过去


pve虚拟机ID：旧 105  新 106

```
lvrename /dev/pve/vm-105-disk-1 /dev/pve/vm-106-disk-1

vim /etc/pve/nodes/pve-asus/qemu-server/106.conf

# sata1: local-lvm:vm-106-disk-1,size=100G
```

1. 重命名原磁盘
2. 在新虚拟机下添加一个即可
