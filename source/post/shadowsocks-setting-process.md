title: Shadowsocks 服务端的配置过程
date: "2015-02-05 20:43:00"
update: ""
author: me
tags:
- other
categories:
- other
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



之前成功过的，搬瓦工的适用，至于经常会，比如选择 debian 的系统，然后安装的时候总是会出现 can't locate package 之类的问题，相比起来，搬瓦工的ubuntu
比较好，话说还有个整合了 php 环境的系统，但是我不知道 mysql 的密码，也不知道到哪里找。已经第二次装了，⊙﹏⊙b汗，我真2
系统:Ubuntu 12.04 + XShell

1. 准备（从第一次登录开始）

apt-get update
apt-get install python-gevent python-pip
apt-get install python-m2crypto
pip install shadowsocks

2. 编辑
vi /etc/ss.json
a 
{
  "server":"",
  "server_port":,
  "local_port":1080,
  "password":"",
  "timeout":600,
  "method":"aes-256-cfb"
}
ESC --> :wq

3. 运行
nohup ssserver -c /etc/ss.json > log &
4. 开机启动（其实也没啥必要，没事总重启干啥）
vi /etc/init.d/rc.local
do_start() {
         ssserver -c /etc/shadowsocks.json &
       ************************
}
代码从网上摘的，整理（复制粘贴）了一下，之前有很多命令，明明看起来一点问题，但是就是找不到 package，估计是源的问题，按理说官方源不会有问题才对，服务器在国外也没有速度问题，令人费解啊
