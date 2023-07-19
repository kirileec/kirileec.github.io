title: Migrate from GOPATH to Go mod
date: 2019-07-23 17:37:02 +0800
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


GOPATH项目迁移到go mod流程
<!--more-->

## 步骤

1. 把项目目录原封不动移动到任意一个不在`GOPATH`内的目录下, 例如`D:\workspace\projectname`
2. `go mod init projectname`
3. 替换原有的引用路径, `"xxx/xxx/projectname/module" =>  "projectname/module"`, 全局搜索 `xxx/xxx/` 全部替换为空即可
4. `.gitignore` 忽略 `go.sum`
5. `go build`

## 注意
1. 尽量不使用本地包, 像 `xxx/xxx/module` 这样的, 把本地包推送到线上的git仓库里去
2. windows下在powershell或者vscode的终端执行 `$env:GOPROXY="https://goproxy.io"` , 可以让下载包的过程更快, 而当遇到 `gitee.com` 上面的包的时候, 因为 `https://goproxy.io` 没有把`gitee.com`考虑在内, 此时可以 `$env:GOPROXY=""` 临时清除环境变量 `go build` 一次, 毕竟 `github.com` 对我们来说也是很慢的
3. 对于第2点, go版本`>=1.13`的时候, 可以使用
 
```go
go env -w GOPROXY=https://goproxy.io,direct
go env -w GOPRIVATE=gitee.com
```
忽略一些域名, 然而1.13还在beta状态, (─.─|||
