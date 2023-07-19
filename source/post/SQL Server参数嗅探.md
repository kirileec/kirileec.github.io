title: SQL Server参数嗅探
date: "2016-12-24 21:07:06"
update: ""
author: me
tags:
- windows
- sql
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



# SQL Server参数嗅探

没想到我也会有接触到数据库这么深的地方哈哈。

起因是，公司软件的报表打开很慢，查一个月的营业综合报表数据，居然花了10几分钟，简直恶心。然后我拿到数据库之后下断点调试，经过几分钟的折腾后终于定位到了一个表值函数上。

然后为了让结果快点出来，将时间间隔设置为5天，竟然需要一分钟才出结果，然后我尝试将这个函数里面的代码拷贝出来，给参数直接赋值然后执行，天啊 3秒，见鬼了，尝试了几次之后终于确定这个问题很诡异。于是就各种搜“为什么同样的sql语句直接执行和放到存储过程中的效率完全不一样”，百度是肯定没有的了，那么笨的家伙。。。。
于是stackoverflow，在一个票数很高的问题里，

> http://stackoverflow.com/questions/440944/sql-server-query-fast-but-slow-from-procedure

发现了这么个名词
###and prevent parameter sniffing###
然后百度一下，就出来了参数嗅探

> http://www.cnblogs.com/lyhabc/articles/3222179.html

具体是怎么样的原理，我看了一下午也没看出个所以然，不过了解了个大概。
意思就是，`sql server`对于一个语句会有编译然后生成执行计划这么一个过程。

我们一般执行一句sql语句的时候，其实是先编译然后生成执行计划，最后根据执行计划去执行。
那么一个执行过程的效率如何关键就在这个执行计划。如果对于同样的代码，放到`procedure`和直接执行，它们生成的执行计划是不同的。

为什么呢，问题就在`procedure`在`sql server`里会经过优化，它的执行计划不会每次都重新生成，同理也不会每次调用都重新编译
那么如果
```sql
EXEC sp_recompile N'PROCEDURENAME'
```
在一个过程前调用前执行这么一句，就可以保证它生成的执行计划是准确的。

而如果没有进行重新编译，`sql server`就可能使用一个烂的执行计划去干活了，自然就慢了。

下面摘几种方式来处理参数嗅探

|方法|是否修改存储过程|是否每次运行都要重编译|执行计划准确度|
|---|--------------|-------------------|------------|
|用exec()方式运行动态SQL|需要|会|很准确|
|使用本地变量local variable|需要|不会|一般|
|query hint+"recompile" |需要|会|很准确|
|query  hint指定join运算 |需要|不会|很一般|
|query hint optimize for|需要|不会|比较准确|
|Plan Guide|不需要|不会|比较准确|
