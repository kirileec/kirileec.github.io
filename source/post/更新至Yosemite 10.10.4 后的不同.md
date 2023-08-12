title: 更新至Yosemite 10.10.4 后的不同
date: "2015-05-23 19:37:00"
update: ""
author: me
tags:
- MAC OS X
categories:
- MAC OS X
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



# 之前(10.10.3)

## 卡,卡粗翔,就是卡

    1. 系统卡，我是覆盖安装，从10.9.5升级到了10.10.2然后直接app store升级至10.10.3。具体表现为Finder、系统偏好设置等一些界面的切换和显示明显比10.9.5要迟钝。
    2. 软件卡，XCODE、MACVIM、CHROME,XCODE用起来感觉是HDD一样，都想骂娘了，从来没有什么系统，换了SSD了之后，还这么卡的，Yosemite是第一个。CHROME上的FLASH完全屎一样，随便开个视频，马上90+的CPU占用，大部分时间是100。打开一个本来应该秒开的网页，居然跟开了迅雷下载的时候一样，10几秒才有反应。MACVIM则打开文件很慢，滚动很慢。
    3. 本来以为是什么透明度啊之类的东西的问题，最近几天的测试，发现跟透明度没有半毛钱关系，甚至我开了透明度特性，跟关了一模一样的感觉，因为windowserver这个进程在我这还是比较正常，没有什么占内存的情况。之前还一度怀疑是不是我的显卡已经无法服役了。

# 之后（10.10.4）

## 一切正常

    虽然响应速度没有windows下那么给力，但是跟之前比起来一个天上一个地下18层。现在MACVIM滚动正常，载入文件也正常。XCODE的启动时间也缩短了N多，CHROME放了几个视频试了试，CPU占用基本在60上下，还需进一步测试啊。另外Chrome如果把flash所在的标签页切到后台，尼玛，( *￣▽￣)o ─═≡※:☆▆▅▄▃▂＿ ，duang一下，CPU占用就下来了，神奇的一B
