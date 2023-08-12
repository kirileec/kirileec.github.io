title: 'csharp AutoMapper: Update property values without creating a new object'
date: "2016-12-28 00:09:21"
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



Normally, we use AutoMapper to Map object like this:
```c#
Mapper.Initialize(
       (cfg) =>
        {
            cfg.CreateMap<TSource, TTarget>();
        }
    );
target = Mapper.Map<TTarget>(source);
```

however, this will create a new instanse of `TTarget`, then the reference of `target` would be changed. The original object of target will not change in this case. The solution is as follows:
```c#
Mapper.Map(source, target);
```
