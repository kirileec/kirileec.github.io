title: beego 在Windows下输出带有颜色的日志
date: "2017-04-11 21:47:27"
update: ""
author: me
tags:
- go
- beego
categories:
- go
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



> "github.com/nevernet/logger"

首先这个库，属于一种对于beego自带日志的扩展， 然而封装的不是特别详细， 因此目前来说还是自己修改其代码以达到自己的目的。

beego的日志模块在unix系统的Terminal支持颜色输出的情况下应该是好， 不过在Windows下，我看了下代码的实现，默认自带的`ConsoleWriter`，在判断到系统是`windows`的时候会默认将`colorable`设置成`false`。然后我去官方仓库翻了翻`issue`，翻到了一个加入颜色支持的`issue`，不过并没有后续的对`windows`进行支持的。然而官方的`bee`工具里的日志输出就非常(๑•̀ㅂ•́)و✧， 其实我现在是想要一个日志输出像 `bee run`那样的输出，例如 `SUCCESS` 标签为绿色，非常漂亮。但后来经过尝试发现，其实`windows`的命令行或者`powershell` 如果不进行相关的修改，即使加上颜色，还是很难看，主要还是那个字体，并不能像`vscode`里的`powershell`那样。于是暂时先搞个带颜色的出来就好。

在研读
> https://github.com/mattn/go-colorable

这个库的实现方式之后，了解到，只要给日志模块一个可以比较好支持颜色输出的Writer即可了。 后来发现其实beego的内部已经加入了支持，只不过目前的1.8版本还没有正式实现之，需要用户自己实现

```go

func NewColorConsole() Logger {
	cw := &consoleWriter{
		lg:       newLogWriter(NewAnsiColorWriter(os.Stdout)),
		Level:    LevelDebug,
		Colorful: true,
	}
	return cw
}

func init() {
	Register(AdapterConsole, NewColorConsole)
}
```

由于我对go还不是很熟悉，因此暂时就先这样直接修改代码先用着了
