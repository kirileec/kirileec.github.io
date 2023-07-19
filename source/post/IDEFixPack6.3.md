title: IDEFixPack6.3
date: 2018-10-31 12:27:47 +0800
update: ""
author: me
tags:
- IDEFixPack
- Delphi
categories:
- Delphi
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


IDE Fix Pack 6.3 更新日志
<!--more-->

From [Here](https://andy.jgknet.de/blog/2018/06/ide-fix-pack-6-3-released/)

The new IDE Fix Pack 6.3 adds some IDE fixes and makes DFM reading a little bit faster due to the usage of buffers on the stack instead of the TBytes heap allocations with unnecessary FillChar calls that were introduced with XE3.

新的 `IDE Fix Pack 6.3` 增加了一些IDE问题修复, 让DFM文件的读取变快了一点点, 使用 **栈** 上的缓存替代了**TBytes堆**上的多余的FillChar调用(XE3)

The compiler option extension `-x-fpr` also got a new feature. If a function has stack variables that exceed 4096 bytes, the function prolog that is generated will be up to 3 times faster than the original compiler generated code (RSP-19826).

编译器选项 `-x-fpr` 也增加了新的特性. 如果一个`function` 声明了栈上的超过4096字节的变量, 该`function`生成的代码将比原编译器快3倍(RSP-19826)

Furthermore the compiler option extensions are now combined into -x-On options what makes it easier to specify the options because you don’t need to remember all the option names anymore.

另外编译器扩展选项合并到了一个 `-x-On` 选项中, 这样就不需要去记了.

> - -x-O1     启用选项 `-x-fvs`   `-x-fpr`
> - -x-O2     启用选项 `-x-fvs`   `-x-fpr` `-x-orc`
> - -x-O3     启用选项 `-x-fvs=2` `-x-fpr` `-x-orc`
> - -x-Ox     启用ABI更改优化: `-x-fvs=2` `-x-fpr` `-x-orc=2` `-x-ff`

All options are listed in the Readme.txt and can be specified under `Project Options`/`Delphi Compiler`/`Compiling`/`Other options`/`Additional options` to pass to the compiler.

所有选项都在`Readme.txt`中可以看到.

Changelog

- Added: Patch to remove IDE flickering when WM_SETTINGCHANGE is broadcasted
- Added: Fix for RSP-20700: Tooltip Help Insight is blinking if Structure View is scrolled
- Added: Undo XE3+ TFiler/TReader/TParser/TStream TBytes usage, replace SetLength with SetLengthUninit for special cases
- Added: -x-fpr generates 3 times faster stack memory page probing code (RSP-19826)
- Added: Options -x-O1, -x-O2, -x-O3, -x-Ox that enable other optimization options

更新日志

- Added: 移除了当消息 `WM_SETTINGCHANGE` 被广播时的IDE闪烁
- Added: 修复 RSP-20700: 修复当 `Structure View` 滚动时的帮助信息气泡闪烁
- Added: 撤消XE3 + `TFiler` / `TReader` / `TParser` / `TStream TBytes`用法, 将`SetLength`替换为`SetLengthUninit`用于特殊情况
- Added: -x-fpr 生成3倍快的堆栈内存页探测代码 (RSP-19826)
- Added: 选项 `-x-O1`, `-x-O2`, `-x-O3`, `-x-Ox` 用于启用一些特性
