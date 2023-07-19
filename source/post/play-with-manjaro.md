title: Play With Manjaro
date: 2019-12-01 10:31:18 +0800
update: ""
author: linx
tags:
- linux
categories:
- linux
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


在Manjaro下玩耍
<!--more-->

最近打算把自己的10年老笔记本换个linux的系统, 反正每天也就是看看视频, 还能找到事情折腾一下. 有一点不太好的是, 没有多台电脑, 所以有的时候就很惨


## 系统选择

其实选哪个不重要, 重要的是你对哪个比较熟悉, 例如之前都是用ubuntu的那么选gnome, 而种草KDE的漂亮就选KDE版本, 当然也可以选arch版本, 这样就随便选了. 

## 安装

我选择的是arch版本, 其实也就是多了很多自选的选择, 但是基本上那些自选的选项对于想搞个系统来用的人来说, 无伤大雅的. 比如磁盘分区选什么格式啦, 一般都会去选ext4, 其它的大部分都不认识. 反而另外的指定好的版本更好, 语言包啥的都给装好了. 而arch版本语言包还要自己装. 这种必要的没装起来, 那种libre之类的内置软件倒是装了一大堆. 反正我后来是跟着别人的图片装的.

特别注意, 在开始的时候, 用manjaro登录后, 在setup之前, 先这样

```shell
sudo pacman-mirrors -i -c China -m rank
```

不然你会后悔的

## 配置

#### 换源

安装完进系统第一步先

```shell
sudo pacman-mirrors -i -c China -m rank
sudo pacman -Syy
```

然后

```shell
vi /etc/pacman.d/mirrorlist
sudo pacman -Syy
```
根据具体情况删掉几个, 我是留下了中科大和清华的(移动宽带)

#### 代理
再就是代理了, 刚装完肯定是没有的, 不是路由器翻的情况, 就比较困难了.

1. 设置git
```shell
git config --global http.proxy http://ip:port
git config --global https.proxy http://ip:port
```
代理可以通过手机开出, 当然这个速度会比较惨, 最好事先把节点先选好

2. 开启AUR, 打开自带的软件包管理器, 点右上角的三个点. 进入首选项, 有个AUR页签, 勾选启用AUR支持即可
3. `sudo pacman -S yay` 然后 `yay --aururl “https://aur.tuna.tsinghua.edu.cn” --save`

4. 安装v2raya, `yay -S v2raya`, 我测试了好多个可以在linux运行的GUI, 最终觉得还是这个比较好.
   
   - 全局透明代理
   - go版本, 依赖少, 构建不会很久
   - 前端页面最好还是自己build一份留着, 万一啥时候不能访问呢, 不就凉了
   - 
5. 
   ```shell 
   sudo pacman -S yarn
   cd ~/V2RayA/gui
   yarn install
   yarn build
   cd ../web
   ```
   将该目录下的所有文件拷贝到`/src/http`, 然后 `sudo systemctl start httpd`, 访问`localhost`就行了



#### 预告

- shell美化
- 常用软件安装
