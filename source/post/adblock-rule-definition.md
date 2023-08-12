title: Adblock 规则定义
date: "2016-11-08 12:18:00"
update: ""
author: me
tags:
- windows
- adblock
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



from
> https://adblockplus.org/en/filter-cheatsheet

translated by linx

#简单的屏蔽规则

##例子 1: 根据网址的一部分屏蔽
```
/banner/*/img
```
该规则屏蔽:
```
http://example.com/banner/foo/img
http://example.com/banner/foo/bar/img?param
http://example.com/banner//img/foo
```
但不屏蔽:
```
http://example.com/banner/img
http://example.com/banner/foo/imgraph
http://example.com/banner/foo/img.gif
```

##例子 2: 根据域名屏蔽
```
||ads.example.com^
```
该规则屏蔽:
```
http://ads.example.com/foo.gif
http://server1.ads.example.com/foo.gif
https://ads.example.com:8000/
```

但不屏蔽:
```
http://ads.example.com.ua/foo.gif
http://example.com/redirect/http://ads.example.com/
```
##例子3: 屏蔽确定的地址
```
|http://example.com/|
```
该规则屏蔽:
```
http://example.com/
```
但不屏蔽:
```
http://example.com/foo.gif
http://example.info/redirect/http://example.com/
```
#屏蔽规则中的选项
```
||ads.example.com^$script,image,domain=example.com|~foo.example.info
```
该规则仅仅屏蔽 `http://ads.example.com/foo.gif` 但仅当一下条件满足时:

该地址是作为脚本或者图片加载时.
脚本或者图片加载自 `example.com`域名 (例如 `example.com` 自身或者 `子域名.example.com`) 但不是其多级子域名.

#白名单规则
用于在已有规则命中时, 加入一条例外

##例子 1: 特定请求中的例外
```
@@||ads.example.com/notbanner^$~script
```
##例子 2: 整个页面的例外
```
@@||example.com^$document
```
#注释
```
!这是一条注释
```
#过滤选项
```
script
~script
```
包含或者排除JavaScript脚本文件
```
image
~image
```
包含或者排除图像
```
stylesheet
~stylesheet
```
包含或者排除css
```
object
~object
```
包含或者排除由浏览器插件管理的内容,例如flash java
```
object-subrequest
~object-subrequest
```
包含或者排除由浏览器插件加载的文件
```
subdocument
~subdocument
```
包含或者排除页面的嵌入内容(frames)
```
document
```
用于排除页面本身 (e.g. @@||example.com^$document)
```
elemhide
```
用于防止元素规则应用于页面 (e.g. @@||example.com^$elemhide)
```
domain=
```
指定域名列表, 由竖线分隔 (|), 使过滤规则生效. 可以用波浪符号 (~) 来否定之.
```
third-party
~third-party
```
指明一个过滤规则是否应该处理第三方或者第一域

#元素隐藏(由 `Element Hiding Helper for Adblock Plus` 扩展使用)
##域名选择器
`##selector` 占位符.
`###advert` 匹配拥有unique id为 "advert" 的元素
`##.advert` 匹配拥有class id 为 "advert" 的元素
`##table[height="100"][width="100"]` 
`##a[href="http://example.com/"]`
`##div[style="width:300px;height:250px;"]`	`

` ###advert > .link` 匹配元素内部的关闭的`link`标签, 并且id为"advert"
`##a[href^="http://example.com/"]`

`##div[style^="width:300px;height:250px;"]`
`##div[style$="width:300px;height:250px;"]`
`##div[style*="width:300px;height:250px;"]`
