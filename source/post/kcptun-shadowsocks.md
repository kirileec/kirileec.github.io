title: kcptun &amp;&amp; shadowsocks
date: "2016-11-07 00:14:00"
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



refer to 
> https://blog.kuoruan.com/110.html

## Server
首先需要一个已经架设好的ss服务, 例如为 `1.1.1.1:9999` 加密方式为`aes-256-cfb` 密码为`password`
```shell
wget --no-check-certificate https://raw.githubusercontent.com/kuoruan/kcptun_installer/master/kcptun.sh
chmod +x ./kcptun.sh
./kcptun.sh
```

执行之后, 会有一个向导过程, 因为没兴趣折腾过多, 因此只做了小小的修改

- 设置一下kcptun的密码
- 指定一个kcptun的端口
- 加速端口填入9999也就是ss的端口
- 加速方式为fast3
- 禁用压缩
- 加密方式为none

上述的最后两项为可选, 我的目的是想要在openwrt路由器上跑kcptun客户端, 因为如果这两项开起来的话, 那基本上几秒钟进程就挂了, 禁用压缩和不加密可以减少资源的占用. 然而..... 并没有什么卵用, TP-LINK 841ND 改装版, 这个基本跑不动, 虽然可以开起来但是会无法访问

## Client
客户端选用 kcptun_gclient, 虽然界面比较大了 
需要配置以下

- 本地监听端口
- 禁用压缩
- 通讯密钥
- 加密方式
- 模式
- 过期时间

除了本地监听端口, 其他都在kcptun.sh执行的时候给出了. 

## ss
新建一条服务器, 地址是127.0.0.1, 端口填写上面的本地监听端口, 加密方式以及密码为ss服务器的加密方式和密码,
PS: 之前用了一段时间的rc4-md5, 本以为加密强度下降了可以性能更好的, 没想到反之啊, 换回aes-256-cfb, 之后好多了


## 测试

- shadowsocks开启系统代理, 模式为PAC模式, 然后git克隆一个github上的项目, 终于可以摆脱那个3kb/s的情况了
- youtube 开个4K视频. 然后看connection, 爽
