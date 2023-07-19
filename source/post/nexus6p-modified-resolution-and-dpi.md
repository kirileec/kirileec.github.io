title: nexus6p修改分辨率和DPI
date: "2016-04-22 23:06:00"
update: ""
author: me
tags:
- Nexus 6p
categories:
- Nexus 6p
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



注意不是PPI

```
su
wm size 1260x2240  # 乘号是英文字母x
wm density 420
```
`/system/build.prop`
`ro.sf.lcd_density=420` 这里要和上面的一致，否则会出现，微信图片错位，放大的情况


然后重启，这样主界面就可以显示六个图标了，各种爽，图标虽然小了，但是完全正常。
续航方面还不知道会怎么样，字体小可以调大字体。但是需要吐槽的是，设置里调大字体，主界面的字体居然不会受影响，啃爹啊
