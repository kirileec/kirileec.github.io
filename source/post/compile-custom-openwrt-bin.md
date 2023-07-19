title: 自己编译Openwrt(LEDE)固件
date: 2019-05-13 11:23:05 +0800
update: ""
author: me
tags:
- OpenWrt
- Ubuntu
categories:
- OpenWrt
- Ubuntu
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


自己编译Openwrt(LEDE)固件 WNDR4300
<!--more-->

# 准备工作

- 下载镜像， 安装Ubuntu 18.04.2 虚拟机
- 设置好ss代理
- 更新软件源

  ```bash
  sudo apt-get update
  ```
- 由于是从英文官网下载的镜像，安装中文语言
- 安装curl（后面编译用）
- 安装git，并clone代码，使用lean的

  ```bash
  git clone https://github.com/coolsnowwolf/lede
  ```

# 配置编译环境

- 安装必须的包

  ```bash
  sudo apt-get -o Acquire::http::proxy="http://127.0.0.1:1080/" -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx autoconf automake libtool autopoint
  ```

- 下载一个主题过来 

  ```bash
  cd lede/package
  git clone https://github.com/rosywrt/luci-theme-rosy
  ```  


# 开始编译 


- 回到上一层执行

  ```
  cd ..
  ./scripts/feeds update -a 
  ./scripts/feeds install -a 
  ```
 
- 配置

  ```
  make menuconfig
  ```

  - 选一下CPU，Generic NAND FLASH， 不能选默认的Generic，那样会只能看到WNDR3800而看不到WNDR4300
  - 选一下机型，WNDR4300
  - 进入LUCI，选择一些Application，并到Themes把刚才的主题选上
  - 退出即可


- 下载， 其实直接开始编译也是可以的，不过如果下载失败的话，重新执行这个操作会快一点（编译还有其他事情的）

  ```
  make download V=s
  ```

  这里有些包是必然失败的，或者即使挂proxy也下的很慢，需要特殊处理

  > - e2fsprogs-1.44.5.tar.xz
  > - libelf-0.8.13.tar.gz
  > - linux-4.9.171.tar.xz
  > - openssl-1.0.2p.tar.gz

  我这里遇到是这么几个， 其中openssl可以到 [http://distfiles.macports.org/openssl/](http://distfiles.macports.org/openssl/) 这里去下载， libelf 由于编译脚本里的域名跳转有问题了， 去这里下载 [https://github.com/coolsnowwolf/lede/issues/1124](https://github.com/coolsnowwolf/lede/issues/1124)

  另外需要注意的是，设置代理的时候如果是用export的形式，注意要和ss的设置对应（shadowsocks-qt5）, 区分HTTP和SOCKS5。主要之前没怎么玩过，所以我是乱设的，又是全局又是export的

  下载下来之后原样放置到 lede/dl 目录即可（下载过程中出现的`.hash`文件不要删掉）。根据情况，在下载卡住了之后再去下载，不挂proxy估计是猴年马月都下不完的，因此尽量选个速度快的



- 编译
  
  ```
  make -j5 V=s
  ```

  祈祷吧， 祈祷别中途崩了

  另外由于前面已经把该下载的都下载了，这里开始就可以去吃个饭睡个觉了^_^

# PS
- `apt-get -o Acquire::http::proxy="http://127.0.0.1:1080/"` 这样可以为apt-get使用代理，设置系统代理好像没啥用，应该是不能用于Console， 而proxychains在对于apt-get的时候经常报错，目前来说这种方式最稳了

- 在使用较新的源码编译时（例如，Lean's LEDE），由于使用的是snapshot的代码，可能会出现官方的仓库里的包版本和编译出的固件版本不匹配。官方那边仓库的ipk内核版本已经到4.14.115，而lean这个仓库里的还在4.14.114。鉴于这种情况，所有需要用到的包建议全部都编译进固件里，不要使用opkg去安装了
