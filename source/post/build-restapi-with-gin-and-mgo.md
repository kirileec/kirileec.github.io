title: Build Restapi With Gin and Mgo
date: "2018-05-05 16:51:17"
update: ""
author: me
tags:
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



1. 首先安装govendor

```go
go get -u github.com/kardianos/govendor
```
并添加 $GOPATH/bin/ 到环境变量中
这样可以执行 `govendor` 命令来确认已经完成安装

2. 新建目录 例如 `$GOPATH/src/gin-mgo-api` 并创建一个 `main.go`, 然后 `govendor init` 初始化之
3. 使用 `govendor` 来管理依赖

```bash
govendor fetch github.com/gin-gonic/gin
govendor fetch gopkg.in/mgo.v2
``` 

4. 创建MongoDB数据连接

db/connect.go

```go
package db

import (
	"fmt"
	"gopkg.in/mgo.v2"
)

var (
	Session *mgo.Session
	Mongo *mgo.DialInfo
)

const (
	MongoDBUrl = "mongodb://localhost:27017/super"
)

func Connect() {
	uri := MongoDBUrl
	mongo, err := mgo.ParseURL(uri)
	s, err := mgo.Dial(uri)
	if err != nil {
		fmt.Printf("Can't connect to mongo, go error %v\n", err)
		panic(err.Error())
	}
	s.SetSafe(&mgo.Safe{})
	fmt.Println("Connected to", uri)
	Session = s
	Mongo = mongo
}

```

5. 创建数据库连接的中间件

middlewares/middlewares.go

```go
package middlewares

import (
	"fmt"
	"gin-mgo-api/db"
	"github.com/gin-gonic/gin"
)

func Connect(c *gin.Context) {
	fmt.Println("Connect Middleware")
	if db.Session == nil {
		fmt.Println("Error DB Session")
	}
	s := db.Session.Clone()

	defer s.Close()

	c.Set("db", s.DB(db.Mongo.Database))
	c.Next()  //这一句是必须的, 否则数据连接在跑完这个方法之后就被关闭了
}

func Middleware(c *gin.Context) {
	fmt.Println("this is a middleware!")
}
```

6. 建立一个Model

models/super.go

```go
package models

import (
	"gopkg.in/mgo.v2/bson"
)


type Super struct {
	Id    bson.ObjectId `json:"_id,omitempty" bson:"_id,omitempty"`
	Name  string
	Value string
}
```

7. 好了可以开始写点路由啥的了
 
main.go

```go
package main

import (
	"gin-mgo-api/db"
	"gin-mgo-api/middlewares"
	"gin-mgo-api/models"
	"net/http"

	"github.com/gin-gonic/gin"
	mgo "gopkg.in/mgo.v2"
)

//在启动时先建立数据库连接
func init() {
	db.Connect()
}

func main() {
	router := gin.Default()
	gin.SetMode(gin.DebugMode)

	router.Use(middlewares.Connect)
	router.GET("/someGet", func(c *gin.Context) {
        //每个接口都可以用这样的方式获得数据库操作对象
		db := c.MustGet("db").(*mgo.Database)
		supers := []models.Super{}
        //没数据可以先插进去几条, 或者用MongoDB Compass操作
		// super := models.Super{Name: "hhhh", Value: "iiii"}
		// err := db.C("super").Insert(&super)
		err := db.C("super").Find(nil).All(&supers)
		if err != nil {
			c.Error(err)

		}
		c.JSON(http.StatusOK, supers)

	})

    //这里也可以这样 router.Run(":9090") 暂时还不知道有什么区别
    
	http.ListenAndServe(":9090", router)
}

```
