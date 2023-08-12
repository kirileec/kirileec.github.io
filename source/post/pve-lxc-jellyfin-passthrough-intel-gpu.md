title: pve lxc jellyfin passthrough intel gpu
date: 2022-10-31 16:46:25 +0800
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



# PVE 直通核显搭建jellyfin

由于群晖 dsm 7需要打核显补丁, 而且用不太到群晖的其他功能, 便准备单纯部署jellyfin

## 宿主机操作

首先使用pvetools把基本的换源之类的搞定,另外还需要解决网络问题,我是先跑了个openwrt旁路由虚拟机. **如果之前已经进行了直通核显的操作, 先把屏蔽核显驱动的步骤撤掉**

### 建立LXC容器

CT模板选择 ubuntu 22.04 版本, 22.10被pve提示不支持, 网络问题已解决的话,可以直接在pve下载, 否则可以开始下载后复制地址在本地下载后上传. 这个版本可以直接安装核显驱动, 老版本会比较麻烦. 记住容器的ID, 我这里是102


### 宿主机(PVE)
```
# 安装驱动
ls -l /dev/dri
apt install intel-media-va-driver-non-free
apt install vainfo
vainfo

# 配置核显到对应的容器
vim /etc/pve/lxc/102.conf

lxc.cgroup2.devices.allow: c 226:0 rwm
lxc.cgroup2.devices.allow: c 226:128 rwm
lxc.autodev: 1
lxc.hook.autodev: /var/lib/lxc/102/mount_hook.sh

# 配置挂载命令
vim /var/lib/lxc/102/mount_hook.sh

mkdir -p ${LXC_ROOTFS_MOUNT}/dev/dri
mknod -m 666 ${LXC_ROOTFS_MOUNT}/dev/dri/card0 c 226 0
mknod -m 666 ${LXC_ROOTFS_MOUNT}/dev/dri/renderD128 c 226 128
```

这里的226和128 一般是固定的


### LXC容器内操作


```
# 安装jellyfin
apt-get install software-properties-common -y
apt install apt-transport-https curl -y
add-apt-repository universe

curl -fsSL https://repo.jellyfin.org/ubuntu/jellyfin_team.gpg.key | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/debian-jellyfin.gpg

echo "deb [arch=$( dpkg --print-architecture )] https://repo.jellyfin.org/ubuntu $( lsb_release -c -s ) main" | tee /etc/apt/sources.list.d/jellyfin.list

apt update

apt install jellyfin -y

systemctl restart jellyfin

# 也装一遍驱动
apt install intel-media-va-driver-non-free -y
apt install vainfo -y
vainfo

ls -l /dev/dri
```

### 设置Jellyfin

```
apt install intel-gpu-tools
```
开启硬解, 然后上传一部4k hevc的视频进行播放测试, 确认已经是转码模式. 然后 intel_gpu_top 查看显卡占用情况
