title: Windows下GCC编译环境和VC编译环境的搭建
date: "2014-03-06 18:50:00"
update: ""
author: me
tags:
- other
categories:
- other
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



### GCC

- 安装MinGW，并下载相关包, 默认安装在`C:\MinGW`
- 设置环境变量

```bat
C_INCLUDEDE_PATH=C:\MinGW\include
CPLUS_INCLUDE_PATH=C:\MinGW\include
LIBRARY_PATH=C:\MinGW\lib
Path=C:\MinGW\bin（添加）
```

如果是单用户，即这台计算机只有你一个人用，可以把这个放到上面的用户变量表里，如果多用户，则放到下面。

到这里可以在CMD中使用

```cmd
gcc –o first first.c
```

来进行编译了。不过这样编译出来的是DEBUG版的，如果要编译出Release版的，则使用 `–s` 参数

### VC

安装Visual Studio 2013

默认的安装路径为`C:\Program Files (x86)\Microsoft Visual Studio 12.0\`

设置环境变量

```dos
INCLUDE=C:\Program Files (x86)Microsoft Visual Studio 12.0\VC\include;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Include

LIB=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\lib;C:\Program Files (x86)\Microsoft SDKs\Windows\v7.1A\Lib

Path=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin（添加）

VCINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\

VS\120\
COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\Tools\

VSINSTALLDIR=C:\Program Files (x86)\Microsoft Visual Studio 12.0\
```

特别是`INCLUDE`和`LIB`一定要同时设置好两个位置，即一个VC目录下的，一个`Microsoft SDKs`目录下的，缺一不可。否则在命令行下输入`cl first.c` 会出现`stdio.h 不包含程序集（含义明显就是说找不到文件）`，就只能在Visual Studio 2013提供的自带的命令行工具中编译了。

同理，在cl命令后加上` /MD /O2`选项即可编译出Release版本了，虽然没有其他参数，但是这样的程序已经够小了。

比如一个只有十来行代码的，并且只有包含`stdio.h`和`stdlib.h`两个头文件的C程序

GCC的Debug版占用92K，Release版占用20K

CL的Debug版占用80K，Release版占用8K

居然都相差12K的大小，到底多了什么呢，看一下区段就知道了。

GCC为什么多了那么多区段，而且查壳还显示UpolyX，坑爹！
