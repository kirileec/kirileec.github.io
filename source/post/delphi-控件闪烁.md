title: Delphi 控件闪烁
date: "2014-04-09 10:31:00"
update: ""
author: me
tags:
- delphi
categories:
- delphi
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



比如说「 Panel 」 组件，如果有好多个，那么在调整窗口大小的时候，就疯狂地闪烁了

方案：

TForm 和 TPanel 都有一个属性`doublebuffered`，设为`True`即可
