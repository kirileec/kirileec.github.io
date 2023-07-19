title: Go 1.13 environment setup
date: 2020-02-05 20:03:25 +0800
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


go 1.13 版本环境变量配置
<!--more-->

**必需的配置** 

不然还不如回1.12版本用gopath去

```go
GOPROXY=https://goproxy.cn,direct
GOPRIVATE=*.gitlab.com,*.gitee.com
GOSUMDB=off
```
