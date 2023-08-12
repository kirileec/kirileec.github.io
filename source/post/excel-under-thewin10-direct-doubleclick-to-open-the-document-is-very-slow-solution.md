title: '[转]win10下EXCEL直接双击打开文档很慢的解决方案'
date: "2016-02-22 12:49:00"
update: ""
author: me
tags:
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



转自:[win10下EXCEL直接双击打开文档很慢的解决方案](http://bbs.pcbeta.com/viewthread-1653054-1-1.html)

> 1. 打开注册表
> 2. 打开HKEY_CLASSES_ROOT
> 3. 找到`Excel.Sheet.12/shell/Open/command` (这是xlsx的)
> 4. 修改右边默认项值：去掉末尾`/dde`，改成`/n "%1" /o "%"`（2013以前的版本只用加"%1"）
> 5. 修改command项值：也是去掉末尾`/dde`，改成`/n "%1" /o "%u"`（2013以前的版本只用加"%1"）
> 6. 删除open下的`ddeex` 网上很多教程都是漏掉了5、6两步
> 7. 对`Excel.Sheet.8`做一样的操作(这是xls的)，其他类型也同理
