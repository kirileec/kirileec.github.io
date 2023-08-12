title: Http Api Auth
date: 2019-09-09 17:28:46 +0800
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


内部使用的api鉴权方式
<!--more-->

## API Key + API Secret

由于是内部使用, 无需考虑存储成本

基本流程如下

1. 服务端以各种形式颁发 API Key 和 API Secret 给客户端
2. 客户端发起请求时, 将 Query Param 以字母顺序进行排序, 生成类似 `a=1&b=2&c=3&api_key=xxxx` 这样的字符串
3. 在上面这个字符串后拼接上 API Secret 然后hash生成sign 
4. sign拼接到最终的请求地址中, 即 `a=1&b=2&c=3&api_key=xxxx&sign=xxxxxx`
5. 服务端以相同的方式进行hash算出sign值和url中的进行比对即可确定该次请求是否合法

好了, 上面这样就可以确保请求的**参数不被修改**, 因为如果被修改, 签名sign就会不同. 同时因为 API Secret 并没有在传输过程中被中间人知道, 
因此, 通过猜测去进行算sign也是行不通的


完成上面这样之后, 需要阻止重放攻击, 假设当前的请求url `https://example.com/api?a=1&b=2&c=3&api_key=xxxx&sign=xxxxxx` 被拦截了, 
那么攻击者只要原封不动把这个请求再进行一次即可持续不断地向服务器发起请求

于是, 增加 timestamp 和 nonce, 一个是请求发起时的 Unix 时间戳, 另一个是随机数.

服务端拿到timestamp之后, 校验一下, 只允许最近一分钟的请求通过, 或者更短的间隔, 就保证了一个timestamp只有在当次的请求有效.

而服务端对于nonce的处理则是, 在第一次请求完成后, 将之存到redis, 并且为60s后过期, 这样每个nonce也只能使用一次.

除非攻击者获得了 API Key API Secret  以及你使用的加密方式才可以发动攻击.

当然, 服务端需要作一些ban ip之类的策略, 防止恶意的请求消耗资源
