title: lenovo b4360-B015 install pve
date: 2022-07-25 20:11:43 +0800
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



## 准备工具
1. rufus  https://rufus.ie/zh/
2. PVE iso镜像 https://www.proxmox.com/en/downloads
3. U盘2个, 一个用于安装PVE 一个装PE。由于我是一块联想的主板，安装完会进不去系统，需要PE来修改启动项名称。如果不是联想主板，那应该PE也不需要了
4. DiskGenius，删除分区啥的

## 流程
1. 插上U盘，DiskGenius删除所有分区，保存分区表，新建一个分区并格式化，关闭之
2. 打开rufus， 选择iso镜像，会提示dd模式写入，直接继续即可，开始写入
3. 插上U盘和网线，从u盘启动，有UEFI就从UEFI启动
4. 按流程进行安装，到设置IP的时候设置一个固定IP即可，如果这里没插网线，那估计后面还要连显示器键盘来改IP，很是烦躁
5. 安装完成后重启，拔掉u盘。联想主板应该会提示1962错误
6. 插入PE，进PE使用Bootice工具，切换到UEFI页签，应该会有个UEFI启动项序列修改的，进去找到pve对应的那一项，名称修改为 `Windows Boot Manager`, 如果有其他可以修改UEFI启动项名称的工具也可以， 点击下方的保存，再次拔掉u盘重启
7. 这回是真进去了

## 安装后

- 关闭订阅提示
```
sed -i.backup -z "s/res === null || res === undefined || \!res || res\n\t\t\t.data.status.toLowerCase() \!== 'active'/false/g" /usr/share/javascript/proxmox-widget-toolkit/proxmoxlib.js && systemctl restart pveproxy.service
```
- pvetools 一键配置

```
echo "nameserver  8.8.8.8" >> /etc/resolv.conf && rm /etc/apt/sources.list.d/pve-enterprise.list && export LC_ALL=en_US.UTF-8 && apt update && apt -y install git && git clone https://github.com/ivanhao/pvetools.git && cd pvetools && ./pvetools.sh
```

- 挂载硬盘 https://wangxingcs.com/2020/0910/1442/
- 导入img格式镜像启动
    - 创建虚拟机 记住虚拟机的ID
    - 分离并删除默认的硬盘
    - 上传img到pve目录下
    - `qm importdisk [虚拟机ID] [img路径] local-lvm`
    - 导入成功后，刚才的虚拟机下就会多一个硬盘，点击编辑，选择SATA即可
    - 选项， 修改启动顺序
