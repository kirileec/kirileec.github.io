title: choco 安装 spf13-vim
date: "2016-07-11 00:01:56"
update: ""
author: me
tags:
- windows
categories:
- windows
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



```powershell    
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
```

> https://technet.microsoft.com/zh-CN/library/hh847748.aspx


首先需要设置下powershell的脚本执行策略

然后执行
```powershell
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex
```
进行安装choco
...
安装完成
```bash
choco install spf13-vim
```
