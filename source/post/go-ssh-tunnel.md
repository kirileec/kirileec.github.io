title: Go Ssh Tunnel 妙用
date: 2020-04-03 10:34:02 +0800
update: ""
author: linx
tags: []
categories: []
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


Go Ssh Tunnel 妙用
<!--more-->

**这个库不稳定** 一会就连不上了, 不要用


在开发测试的时候, 如果内网没有完整的测试环境, 测试环境为一台公网的机子, 那么对于本地调试来说, 容易有很多麻烦.

就比如开发时连接的redis服务和线上测试环境连接的redis不一样时, 对于用户验证这一块就很难受了. 

由于redis的安全性很垃圾, 绝对不能开放到公网, 否则分分钟变成挖矿机器. 所以必须迂回一下, 曲线救国

```go
package main

import (
	"github.com/elliotchance/sshtunnel"
	"log"
	"os"
	"time"
)

func main() {
	//测试服务器上的redis隧道
	tunnel := sshtunnel.NewSSHTunnel(
		"<用户名>@<服务器ip>",
		sshtunnel.PrivateKeyFile("<私钥路径>"), // 1. private key
		"127.0.0.1:6379",
		"6379",
	)
	tunnel.Log = log.New(os.Stdout, "", log.Ldate|log.Lmicroseconds)
	go tunnel.Start()
	
	select {}
}

```

这个私钥是OpenSSH的, 如果已有的私钥是ppk格式, 那就用PuttyGen转换一下.

1. Conversion->Import Key
2. Conversion->Export OpenSSH Key 保存成 key.pem

放置 `key.pem` 到代码目录下

之后编译运行, 就可以用 127.0.0.1:6379 来连接**连接只有测试服务器可以访问的redis服务** 了
