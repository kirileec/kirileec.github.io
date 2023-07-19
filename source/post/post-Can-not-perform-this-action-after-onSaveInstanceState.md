title: Android can not perform this action after onSaveInstanceState
date: 2021-02-27 23:16:58 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



起因是在使用BottomDialog这个组件时[BottomDialog](https://github.com/shaohui10086/BottomDialog), 发现当多次调用时容易出现标题的报错并且崩溃。 但是我在app的其他地方也有多次使用该组件，都没有出现过类似的错误。

经过比对后发现，报错的场景是在一个BaseActivity的扩展方法中。

而经过各种搜索后发现，最终问题被指向了FragmentManager。

由于该场景下，我调用BottomDialog是在一个回调中使用supportFragmentManager获取的FragmentManager实例， 问题就出在这里。kotlin中使用supportFragmentManager获取FragmentManager实例，其实是this.supportFragmentManager, 但是回调方法中的`this`完全无法预料，甚至当你需要使用它时，它已经被销毁了。

于是最终解决方案就出来了， 
```
    fun CustomFormActivity.addBarScan(
        manager: FragmentManager,
        。。。。
```

在扩展方法中加入参数，由调用方提供FragmentManager即可
