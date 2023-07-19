title: Dlogger
date: "2016-06-03 22:48:33"
update: ""
author: me
tags:
- delphi
- Delphi
categories:
- Delphi
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



地址是 [https://github.com/fabriciocolombo/DelphiLogger][1]

代码很简单，已经把它放到了项目里使用了，总的来说还是很不错的，但是仍然需要很多的完善，吐槽如下吧

首先两个核心单元
`DLogger.Log.pas`
`DLogger.Log.Logger.pas`

第一个单元, 是基本单元，声明了ILogger和ILoggerFactory两个接口，并且实现了ILoggerFactory这个工厂接口，而前者相当于工厂里的工人

工厂接口中主要做的就是 GetLogger 和 AddAppender
通俗地讲就是 找到工人，添加设备

前者用于在工厂实例中取得可以使用的Logger，工厂实例是自己管理生存周期的
以这种形式 
```pascal
function LoggerFactory: ILoggerFactory;
begin
  Result := TLoggerFactory.GetInstance;
end;
```
很类似于TClipbrd这个类，用到的时候才会去创建，第二次就不需要创建了，即单实例
然后GetLogger，可以根据提供的Logger名称取得唯一的实例，同时也可以传入一个类，当然最终都是一个字符串来对应一个Logger，如果对应名称的Logger未存在，则创建一个，可以存在多个Logger，也就是说，可以为程序里的每个类都创建一个Logger，这样就可以在输出日志的时候进行区分。Logger在进行写日志的时候，使用FLoggerNotifyAppenders通知实现它的对象，最终将调用Appender的Append方法进行实际的内容写入。
appender可以由自己来进行自定义，那么可以实现，输出不同颜色的日志内容（根据不同的日志等级）

以下不足需要进行二次修改

1. 一旦将Appender注册到工厂中就不能将其移除，这样当某个时间想要将某一种日志输出形式关闭则无法做到，那么就会引起不必要的麻烦，比如Console输出，如果用函数FreeConsole关掉终端，则继续写入会报错

2. 所有注册到工厂的Appender都是同步输出日志的，而工厂是单实例的，如此一来，无法实现一个程序中有多个地方要输出日志，但是不同位置输出的日志并不相同，所以这个日志框架有一定的局限性，比较适合用于输出异常日志

针对以上的缺陷，我认为可以改造成下面这个样子

LoggerFactory保留，但是Appender将其不归属于工厂，而是归属于Logger，即工厂不拥有设备，而是工人去管理设备，这样只要在程序初始化时将工人和设备进行绑定，应该可以实现工人之间相互独立，各干各的事儿，那么就可以实现输出多种类型的日志  









  [1]: https://github.com/fabriciocolombo/DelphiLogger
