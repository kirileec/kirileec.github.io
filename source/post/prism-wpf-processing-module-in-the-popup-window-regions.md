title: WPF Prism 处理模块中弹出窗口的Regions
date: "2016-11-21 20:44:00"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
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



Prism的项目结构，在使用RegionName设置区域的时候，只是给某个控件设置一个RegionName，而不会把这个区域注册到RegionManager中，这就导致了当在Module中弹出一个窗口时，新窗口的所有区域都不会被注册， 因而无法在新窗口上进行导航的操作。
解决方法如下：

```charp
_container.RegisterType<LoginWindow, LoginWindow>();
var login = _container.Resolve<LoginWindow>();
RegionManager.SetRegionManager(login, _regionManager);
```
这样就可以将这个新的Window中包含的区域注册进系统
