title: golang mgo 连接池问题
date: "2017-04-11 21:58:10"
update: ""
author: me
tags:
- GO
categories:
- GO
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



最近在使用beego开发一个小工具，主要干两件事，一边和`RabbitMQ`进行消息投递和通讯，另一边使用`mongodb`然后提供rest api用于外部调用。

在经过几天的测试后，发现，每天早上起来，外部发起请求必然会超时，然后console里还能够正常输出日志，一开始我还在想是不是线程死锁之类的问题，然而并不是。后面经过测试发现，不是beego这边问题，而是mongodb这边问题，因为在进行消息的压力测试投递下，必死，后面将mgo的连接池大小改小，发现死的更快了。于是终于确定了问题的根源所在，其实就是连接池资源耗尽，导致新的请求无法获得连接请求数据库了。
进一步研究发现，其实是我在`Service.Prepare()`之后取得了数据连接，后面并没有释放之。我本以为`Service`自动释放的时候应该会把连接释放掉的，然而，呵呵。那个连接还在，系统可不敢释放它。不过beego的controller在方法调用完后，会自动调用`BaseController`的`Finish`方法来处理数据连接，这边就是正常的。

找到了问题所在，现在消息处理速度杠杠的☺
