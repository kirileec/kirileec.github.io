title: ROS settings
date: 2023-06-18 20:16:34 +0800
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




## PVE 导入安装ROS

- 上传ROS7-6G.ovf、ROS7-6G-disk1.vmdk等文件到PVE目录下
- 执行: `qm importovf {{vmid}} ROS7-6G.ovf local-lvm --format qcow2` 
- `vim /etc/pve/nodes/pve/qemu-server/{{vmid}}.conf`
- ide0那一行末尾增加以下内容

```
,model=VMware%20Virtual%20IDE%20Hard%20Drive,serial=00000000000000000001
```

修改后类似于ide0: local-lvm:vm-777-disk-0,model=VMware%20Virtual%20IDE%20Hard%20Drive,serial=00000000000000000001

- :wq 退出

- PVE页面上设置
    - 硬件->添加efi磁盘
    - 硬件->BIOS 设置为 OVMF (UEFI)
    - 硬件->处理器 类别  host
    - 硬件 添加PCI设备直通网卡, 并且添加网络设备vmbr0

- 如果不能启动卡在EFI-Shell页面, 则 
    - 输入exit进入bios
    - Boot Maintenance Manager -> Boot Options -> Delete Boot Option
    - 除了 UEFI VMware Virtual IDE Hard Drive 0000000000000000001 都按空格选中 [x]
    - Commit Changes and Exit -> Continue

- 还不行就多试几次, 也许是要先添加efi磁盘再设置UEFI

## 初始设置

- 用户名admin 默认密码为空, 然后重新设置一个密码
- 执行 `/system reset-configuration no-defaults=yes skip-backup=yes` 重置下配置
- `/system license print` 查看授权

```
/interface  print
/system reboot
/system shutdown
```

## ROS实现双线网络叠加

### 网络描述
- 线路一: 电信, 动态IP分配, 在路由器下, 不能修改. 接入到 ether1
- 线路二: 移动, 桥接拨号 接入到 ether3
- LAN: pve的虚拟网卡, 接入到ether2

### 网络连接

- IP->DHCP Client. Interface选择ether1, Use Peer DNS 和Use Peer NTP都勾上. Add Default Route yes
- Interfaces -> 添加 PPPOE Client. 名称默认为 pppoe-out1. Interfaces选择ether3. Dial Out页签填写用户名和密码, 其他一般不动, Apply. Status页签能获取到IP即为成功
- IP->Pool, 添加一个 dhcp-pool, 网段为 10.11.0.4-10.11.0.200
- IP->DHCP Server. Interface选择ether2. Lease Time设置为 `1d 00:00:00`. Address Pool选择上面创建的. Networks页签, 添加一个网络. Address: 10.11.0.0./24 Gateway: 10.11.0.254 (我这里把254设置为网关) DNS Servers 随便填一个

- IP->DNS. 添加几个DNS服务器

```
114.114.114.114
223.5.5.5
119.29.29.29
2400:3200::1
2400:3200:baba::1
```
- IPv6-> DHCP Client. Interface选择 pppoe-out1, Request 勾选 prefix. Pool Name 填写ipv6. Length 填 64. 勾上 `Use Peer DNS` `Rapid Commit` `Add Default Route`
- IPv6->Addresses. Address直接填写 ::/64, From Pool选择ipv6. Interface选择ether2. 勾上Advertise
- IPv6->ND. Interface 选择 ether2. 下面四个全勾选
- IP-UPNP, Enabled


### 分流配置

- 参考PCC负载均衡设置
