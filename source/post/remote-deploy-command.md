title: 远程部署相关命令
date: 2019-07-31 11:54:43 +0800
update: ""
author: linx
tags:
- linux
- shell
categories:
- linux
- shell
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


远程部署相关命令
<!--more-->

# Windows版

## 必需软件

- [zip.exe](http://www.stahlworks.com/dev/index.php?tool=zipunzip) 
- [git-scm](https://git-scm.com/)

## 须知

- git-bash下可以调用exe
- git-bash下的路径对应关系为 `C:\ <=> /c/`  `D:\ <=> /d/`
- windows下的sh脚本, 顶部可以写成这样
  ```
  #!/bin/bash
  ```
  or
  ```
  #!"C:\Program Files\Git\bin\bash.exe"
  ```

  前者的写法, 可以直接双击运行sh脚本, 或者在powershell里调用
  后者主要用于jenkins这种, 特别是windows上的jenkins, jenkins是无法识别`/bin/bash` 这个路径的, 而git-bash应该是直接关联了 .sh文件的打开方式了(意思是 `#!/bin/bash` 这行不写也可以)

## 压缩命令

```
zip -q -r name.zip /c/name
```
- `-q` 静默, 不输出详细日志

- `-r` 迭代目录

## scp 传输文件
```
scp -i $PPKFILE $LOCALNAME $LOGINUSERNAME@$SERVERIP:$REMOTEEXECTEMP
```
`PPKFILE` 的内容应该是 `BEGIN RSA PRIVATE KEY`, 来源是可以用Puttygen转换ppk密钥, 必需为OPENSSH的格式

## ssh 执行远程命令
```
ssh -i $PPKFILE $LOGINUSERNAME@$SERVERIP << remotessh
remotessh
```
目前暂不知道如何在两个remotessh之间使用变量
