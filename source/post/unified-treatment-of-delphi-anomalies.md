title: Delphi 异常的统一处理
date: "2016-06-03 23:33:06"
update: ""
author: me
tags:
- Delphi XE8
categories:
- Delphi XE8
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



最近在将程序的异常信息进行统一处理，认为这样的方式还不错

首先需要一个ApplicationEvents改控件将捕获Application的异常并统一到一个地方，只要设置其OnException事件即可

之前提到过Omni的异常捕获，目前以这样的方式来简化处理

首先需要一个BaseForm，所有需要使用异步线程的窗体的父类。该窗体上放置OmniEventMonitor，设置其OnTaskMessage。
在这个祖先类里做如下处理
声明FTASK和procedure TASK
在构造和析构的时候处理FTASK的生存，这样可以实现窗体销毁时自动结束线程，当然记得要WaitFor，线程需要等待其结束，就是这么任性，否则就等着遭殃吧

OnTaskMessage里首先处理
IF msg.msgID=MSG_ERROR then

这里可以将传出的Exception直接raise出来给ApplicationEvents来处理，也可以自定义进行处理

我使用这样的方式

在自定义的异常处理类里声明拦截一个自定义消息，同时这个异常类对外提供一个无界面的窗体句柄用于接受消息，那么OnTaskMessage里将消息发送到这个句柄即可，理论上可以使用PostMessage来实现延迟处理异常

如果在报异常的位置加入一些特殊的信息，例如单元名，那么可以做到很方便地定位一个异常
