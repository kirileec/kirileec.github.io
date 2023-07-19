title: C# Nancy 开启详细错误输出
date: "2016-11-02 15:35:00"
update: ""
author: me
tags:
- CSharp
categories:
- CSharp
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



```csharp
StaticConfiguration.DisableErrorTraces = false
```
StaticConfiguration这是一个静态类,需要`using Nancy;`
