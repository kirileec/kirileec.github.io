title: SQL SERVER 2008 R2 管理工具 SSMS 值不能为空错误+重新安装SQL SERVER 无法安装 SSMS
date: "2014-05-30 12:42:00"
update: ""
author: me
tags:
- SQL SERVER 管理工具 值不能为空 machine.config
- WINDOWS
categories:
- WINDOWS
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



错误一、展开数据库列表时出现值不能为空。参数名`viewinfo(microsoft.sqlserver.management.sqlstudio.explorer)`
这个错误一出，管理工具立马就跪了啊

错误二、鉴于上面的问题很严重，于是重装SQL SERVER 2008 R2，安装时选择管理工具，但是报错：`Failed to open xml file XXXXXXmachine.config`错误一的俩解决方案在`C:\Users\你的用户名\AppData\LocalTemp` 建立1，2，3文件夹的，无效。
坑爹的方法，哪个软件会在临时文件夹放个必须文件的啊打开管理工具`CTRL`+`ALT`+`G` 在“己注册的服务器”重新注册您的服务器，这个更坑了，我的已注册服务器里啥也没有错误二的解决方法报错时会出现一个目录，到这个目录下。我这是这个`C:\Windows\Microsoft\.NETFramework\v2.0.50727\CONFIG` 嘎嘣，我的心啊，这是`.NET2.0`搞的鬼了？ 于是想重新安装`.NET 2.0`，无果，一个是已安装，一个是已有`.NET3.5` 继续搜索，最终解决, 在这个目录下 找 `machine.config.default` 文件，然后获取管理员权限或者更改所有者，把`.default` 去掉，后缀改为 `config` ，然后成功安装了`SQL SERVER 2008 R2`插张图出现了，`d2007litebackup`，看来是这个`machine.config`文件被修改了，但是应该不是`DELPHI 2007 lite`干的，因为之前是正常的，OK搞定了！！
