title: beego 加入跨域访问支持
date: "2017-03-21 09:02:40"
update: ""
author: me
tags:
- go
- beego
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



## 跨域
跨域, 对于个人目前的接触的项目来说, 我知道的出现最多的就是使用`rxjs`访问后端API时发生. 跨域发生时, 如果没有了解过, 那么很可能回去`rxjs`那边去找问题, 因为毕竟是这货报出的错嘛. 

跨域的请求流程, 首先`rxjs`内部向服务器端发出`OPTIONS`类型的请求, 如果服务器端没有响应, 那么就会出现跨域了.
而 `OPTIONS` 请求的结果就是返回一个带有`Access-Control-Allow-Origin`头的Response, `rxjs`得知这个头之后就允许了后续的跨域访问. 

beego的跨域访问支持其实在官方的仓库里以插件形式存在的

> https://github.com/astaxie/beego/blob/master/plugins/cors/cors.go


只要在`beego.Run()` 之前加入
```go
	beego.InsertFilter("*", beego.BeforeRouter, cors.Allow(&cors.Options{
		AllowAllOrigins: true,
		AllowMethods:    []string{"GET", "POST", "PUT", "DELETE", "OPTIONS"},
		AllowHeaders:    []string{"Origin", "Authorization", "Access-Control-Allow-Origin", "Content-Type"},
		ExposeHeaders:   []string{"Content-Length", "Access-Control-Allow-Origin"},
	}))
```

即可
