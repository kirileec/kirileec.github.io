title: Golang 模块代理协议
date: 2020-03-04 12:01:41 +0800
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


Golang 模块代理协议
<!--more-->

A Go module proxy is any web server that can respond to GET requests 
for URLs of a specified form. The requests have no query parameters, 
so even a site serving from a fixed file system (including a file:/// URL) 
can be a module proxy.

Go模块代理是一个提供特定格式GET请求服务的Web服务器. 
该请求没有查询参数, 因此一个基于固定文件系统的网页服务(包括 file:/// 链接)也可以成为模块代理.

The GET requests sent to a Go module proxy are:

发送到模块代理的 GET 请求是这样的:

GET $GOPROXY/<module>/@v/list returns a list of known versions of the given module, one per line.

`GET $GOPROXY/<module>/@v/list` 返回指定模块已有版本的列表, 一行一条

GET $GOPROXY/<module>/@v/<version>.info returns JSON-formatted metadata about that version of the given module.

`GET $GOPROXY/<module>/@v/<version>.info` 返回模块特定版本的JSON格式的版本信息

GET $GOPROXY/<module>/@v/<version>.mod returns the go.mod file for that version of the given module.

`GET $GOPROXY/<module>/@v/<version>.mod` 返回模块特定版本的`go.mod`文件内容

GET $GOPROXY/<module>/@v/<version>.zip returns the zip archive for that version of the given module.

`GET $GOPROXY/<module>/@v/<version>.zip` 返回模块特定版本的zip压缩包

GET $GOPROXY/<module>/@latest returns JSON-formatted metadata about the latest known version of the given module in the same format as <module>/@v/<version>.info. 
The latest version should be the version of the module the go command may use if <module>/@v/list is empty or no listed version is suitable. <module>/@latest is optional and may not be implemented by a module proxy.

`GET $GOPROXY/<module>/@latest`  返回最新版本的JSON元数据, 格式同 `<module>/@v/<version>.info`.
当 `<module>/@v/list` 为空或者列出的版本不适合时, 使用本接口.
`<module>/@latest` 为可选接口, 模块代理可以不实现.

When resolving the latest version of a module, the go command will request <module>/@v/list, then, if no suitable versions are found, <module>/@latest.
The go command prefers, in order: the semantically highest release version, the semantically highest pre-release version, and the chronologically most recent pseudo-version. 
In Go 1.12 and earlier, the go command considered pseudo-versions in <module>/@v/list to be pre-release versions, but this is no longer true since Go 1.13.

当解析最新版本模块时, go命令会请求 `<module>/@v/list`, 然后, 如果没找到合适的版本, 则请求 `<module>/@latest`.
go命令会按顺序: 语义化的最高发布版本, 语义化最高的预发布版本, 以及时间最新的伪版本.
Go 1.12和之前的版本, go命令在`<module>/@v/list`会将伪版本当做预发布版本, Go 1.13以后将不进行这种处理

To avoid problems when serving from case-sensitive file systems, the <module> and <version> elements are case-encoded, replacing every uppercase letter with an exclamation mark followed by the corresponding lower-case letter: github.com/Azure encodes as github.com/!azure.

为防止在大小写敏感的文件系统中出现问题, `<module>` 和 `<version>` 全部转为小写, 并在大写字母前加上英文感叹号(!)来标记. 例如, `github.com/Azure` 需要编码成 `github.com/!azure`

The JSON-formatted metadata about a given module corresponds to this Go data structure, which may be expanded in the future:

一个模块的JSON数据的格式如下, 未来可能会扩展:
```go
type Info struct {
    Version string    // 版本
    Time    time.Time // 提交时间
}
```

The zip archive for a specific version of a given module is a standard zip file that contains the file tree corresponding to the module's source code and related files. 
The archive uses slash-separated paths, and every file path in the archive must begin with <module>@<version>/, where the module and version are substituted directly, not case-encoded. 
The root of the module file tree corresponds to the <module>@<version>/ prefix in the archive.

指定版本的zip压缩包是一个标准的zip文件, 包含了指定模块的代码文件树和相关文件(即模块的所有代码). 
该归档文件使用斜杠(/)表示路径, 并且每个文件路径需要以`<module>@<version>/`开始, 这里的模块和版本不进行大小写编码(感叹号)
模块文件树的根以`<module>@<version>/`为前缀

Even when downloading directly from version control systems, the go command synthesizes explicit info, mod, and zip files and stores them in its local cache, $GOPATH/pkg/mod/cache/download, the same as if it had downloaded them directly from a proxy. 
The cache layout is the same as the proxy URL space, so serving $GOPATH/pkg/mod/cache/download at (or copying it to) https://example.com/proxy would let other users access those cached module versions with GOPROXY=https://example.com/proxy.

即使从版本控制系统直接下载模块, go命令会整合模块信息, mod文件和压缩包, 并将其存储到本地缓存 `$GOPATH/pkg/mod/cache/download`, 和从模块代理处下载是一样的效果.
缓存的布局和代理URL的格式一致, 所以, 在 `$GOPATH/pkg/mod/cache/download` 目录开启这样的Web服务(https://example.com/proxy)就可以让其他人访问你缓存的模块版本了.
