title: OmniThread 异步框架实现线程的异常捕获
date: "2016-06-03 23:20:00"
update: ""
author: me
tags:
- Delphi XE8-OmniThreadLibrary
categories:
- Delphi XE8-OmniThreadLibrary
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



线程里的异常会被系统吞噬掉，即使raise出来，在运行的时候也不会出现，而是悄无声息地消失了。而如果线程异常不处理，那么这个线程就会锁死，从而导致严重的后果，例如推出程序时，死在进程里，线程的恐怖啊

现在有两种方式进行捕获其异常并转移到主线程来统一处理

1. 通过其task.FATALException属性，可以在Omni的线程结束时获得其线程中的异常，当然普通的TThread也有一样的方法实现。这种方法是当异常发生时将终止后台异步线程的运行，直接结束，如果有使用try finally接口将一个FINISH的消息发出来的话，那么可以在TaskMessage里处理FINISH消息，从而获得异常信息。
这个方法的缺点很明显，发生异常后，异常后面的代码都不会执行，除了finaly里的代码

2. 在Task内部使用try except结构捕获异常，然后task.comm.send(MSG_ERROR,Exception)将异常发送到TaskMessage里进行处理即可
这种方法的话可以保证即使线程里的一部分代码发生异常，其他剩余的代码仍然可以执行完成，不至于导致很不正常的结构

因此选择第二种方法
