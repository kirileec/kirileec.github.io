title: 编译安装Windows Terminal
date: 2019-05-09 16:47:59 +0800
update: ""
author: me
tags: []
categories: []
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


编译安装Windows Terminal
<!--more-->

## 要求

* Windows 1903 或以上
* Windows 10 SDK 1903 以上 `https://developer.microsoft.com/en-us/windows/downloads/windows-10-sdk`
* VS2017 或以上
* Visual Studio 安装以下组件 :
  - 使用C++的桌面开发
  - 通用Windows平台开发
  - VS2019, 需要另外勾选 "v141 Toolset" 和 "Visual C++ ATL for x86 and x64"，同时VS2019的安装程序可以直接安装 SDK 1903
* 设置里启用开发人员模式.

## 步骤

1. `git clone https://github.com/microsoft/Terminal` 克隆代码下来
2. `git submodule update --init --recursive` 下载必备的文件
3. 打开`OpenConsole.sln`解决方案
4. `dep\nuget\nuget.exe restore OpenConsole.sln` 还原nuget包
5. 尝试生成解决方案
6. 切换运行平台， ARM64-> x64
7. 再次生成
8. 2220错误，找到对应的工程，右键属性，配置属性->C/C++->常规->将警告视为错误， 改为 否（/WX-）
    - Conhost/Host.Tests.Unit
    - Conhost/Interactivity.Win32.Tests.Unit
    - _Tools/VtPipeTerm
    - Shared/Virtual Terminal/TerminalParser.UnitTests
9. 编码问题（提示末尾缺分号什么的）， 我是用VSCode打开，直接复制源字符替换掉 `_Tools/VtPipeTerm/main.cpp`
10. 重新生成解决方案，全部通过之后，右键解决方案->部署， 然后在开始菜单就能看到了
