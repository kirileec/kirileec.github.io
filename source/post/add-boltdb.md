title: Add Boltdb
date: 2019-05-31 12:58:59 +0800
update: ""
author: linx
tags:
- qrFileTransfer
- go
categories:
- go
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


加入boltdb
<!--more-->

```go
package db

import (

	"github.com/asdine/storm"
	bolt "go.etcd.io/bbolt"
	"qrcodeTransferBox/config"
	"time"
)

var (
	Db *storm.DB
)

func InitDB() (*storm.DB,error) {
	d,_ := time.ParseDuration(config.Cfg.Db.Timeout)
	return storm.Open(config.Cfg.Db.DbPath, storm.BoltOptions(0600, &bolt.Options{Timeout: d}))
}
```
这里用的是storm这个库, 看起来好像调用方式更"容易看懂"点, 先用着看看. 另外这个库调用的是
[go.etcd.io/bbolt](https://github.com/etcd-io/bbolt)这个版本 

然后main.go里初始化一下

```go
var err error
db.Db, err =  db.InitDB()
if err != nil {
  panic(err)
}  
```

写了一个AccessLog, 测试一下写日志进去

```go
package utils

import (
	"github.com/gin-gonic/gin"
	"qrcodeTransferBox/db"
	"qrcodeTransferBox/model"
	"time"
)

func WriteAccessLog(c *gin.Context) {
	log := model.AccessLog{
		DateTime:time.Now(),
		Path:c.Request.RequestURI,
		Action:c.Request.Method,
	}
	_ = db.Db.Save(&log)
}
```

后面考虑情况, 弄成middleware的方式

测试了之后, 看一下数据, 发现qr.db已经生成, 找了个`https://github.com/br0xen/boltbrowser`工具来查看一下数据(这个工具的预编译下载地址的服务器很慢, 要上代理才行)

---
找了一下对于Db这种全局可能只需要一个实例的情况要如何在golang里处理, 大致有两个

* 一次初始化, 全局调用, 引用一下就行
* 写到context里
* 如果是orm的话, 把db放到model里去

不过第二种, 在用的时候还要写几行代码取到实例才行, 还要处理下错误, 算了算了惹不起
