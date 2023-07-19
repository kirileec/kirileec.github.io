title: Live on Thousands of Http Request
date: 2020-02-08 15:56:54 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


面对成千上万次的http请求如何存活
<!--more-->

## 背景

- 大概有3w张物联卡, 需要通过api请求的方式获取其流量使用情况
- 服务端有客户端白名单和请求频率的限制(频率具体是多少不清楚)

## 问题

1. 如果在一个协程中一张张跑完所有卡, 那么3w张卡从获取数据到写入到数据库可能需要消耗...额, 很长时间, 那么这种情况每次定时任务的跨度太长容易导致不方便调试等问题, 会大量拉伸开发周期
2. 如果开多个协程去跑所有卡, 理论上可以把时间缩短到 t/x x为协程数, 但是使用协程时, 即使只使用2个协程, 依然会导致触发服务端的规则导致本该返回正常数据的, 最后只拿到个其它错误. 同时协程数越多, 出现其它错误的几率也更大
3. 需要在白名单的机子上跑方可调用api

## 解决思路

- 针对第三点, 可以使用代理服务器, 可以完美伪装, 然而api调用的效率就会下降很多. 比如我现在的情况是java的服务端, 那么去搜java判断远程ip的方法, 可能会有很多种, 一个个拿到postman里试, 运气不错, `x-forwarded-for`可用
- 针对另外两点, 重试就行了. 目前所用的方式为, 开一个协程池, 容量为30个, 在协程的事件中判断是否发生了限流或超时的情况, 如果发生了, 则添加到重试队列, 让它一只重试即可

## 具体代码

```
defer ants.Release()
var wg sync.WaitGroup
invokeChan := xchan.NewXChan(10000, func(i interface{}) {
			wg.Add(1)
			p.Invoke(i)
		})
p, _ = ants.NewPoolWithFunc(poolCount, func(i interface{}) {
			handleCard(i, alarmchan, insertChan, invokeChan)
			wg.Done()
		})
for _, cardid := range CardList {
    wg.Add(1)
    p.Invoke(string(cardid))
}
defer p.Release()
isPoolRunning = true
wg.Wait()
isPoolRunning = false
```

在handleCard方法中, 如果需要重试, `invokeChan.Add(cardid)`即可, 而isPoolRunning用于防止某一次任务无限重试下去, 让后面的定时任务一直堆积. xchan是一个简单的队列, 感觉用来异步进行**顺序**操作挺合适的

## 引用

- 协程池 `"github.com/panjf2000/ants/v2"`
- 自己封装的cmiot v2版本的SDK, `"github.com/linxlib/cmiot_v2"`
