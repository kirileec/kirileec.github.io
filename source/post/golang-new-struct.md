title: Golang Create Struct
date: 2019-09-29 17:07:03 +0800
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



Golang 创建对象的方式

<!--more-->
```go
type Struct struct {

}
```


1. `s := new(Struct)`

等同于 
```go
var s *Struct = new(Struct)
```


2. `s := &Struct{}`

3. `var s Struct`

```go
c.Bind(&s)
```
