title: Delphi 做二次开发(基于C的动态库)
date: "2016-07-07 18:44:21"
update: ""
author: me
tags:
- delphi
- c
categories:
- delphi
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



首先，第三方提供DEMO在使用动态库时，都是静态引用而不是动态加载。
如果想要自己在其库的基础上封装一层，应该有以下几个方面要注意下，对后续的开发和使用会有好处：

> 1. 不要使用string类型，如果仅仅是用于Delphi程序调用，那么需要添加引用共享内存单元
> 2. 建议在主程序加载这个自定义库之前先检查其依赖的其他文件是否齐全,某些情况下, 在正式环境下缺少文件, 会无法得知缺少了什么文件
> 3. 在dll中使用线程进行开发的时候,首先要注意线程的释放, 另外一个重要的方面是, 线程中可能出现的异常都应该谨慎对待, 如果不对这些异常进行妥善的处理, 将会出现致命的问题. 例如,异常可能导致线程锁死, 同理也适用于其他使用线程的场景
> 4. 变量的使用应考虑同一个EXE多次调用(多开)
> 5. 记录详细的日志, 毕竟Dll的调试相当的不容易

类型对应关系:

1. `Char*` <==> `PAnsiChar` 很多情况下不会是 PWideChar
2. `BOOL` <==> `Boolean` 可以直接使用, Delphi已经对这种类型进行了兼容
3. 指针 <==> `Pointer` 如果有特别说明是什么类型的指针, 那么使用对应的指针,例如 `int*` 对应 `PInteger`
4. struct指针 <==> record的指针,如下声明


```pascal
    TRECORD = record
     {成员声明}
    end;
    PRECORD = ^TRECORD;
```

调用的时候, 先声明 `RECORD:TRECORD` 类型的局部变量, 对成员赋值后, 传入 `@RECORD` 即可, 同样的 C的库调用时会要求传入结构体的Size 那么 `SizeOf(RECORD)`

5. 对于返回或者参数为整数的. 应该声明常量进行调用, 防止后续开发中第三方库的接口变化的情况
6. 返回的`ErrorCode`最好自己写一个方法进行处理
7. C库的参数传入传出无需考虑, 因为核心的传递都是指针,不需要表明某个指针是out的
8. 一个结构体如果没有用, 那么可以传入nil
