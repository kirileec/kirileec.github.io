title: WPF Binding StringFormat 无效
date: "2016-09-21 16:51:31"
update: ""
author: me
tags:
- CSharp-WPF
- binding
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



当我使用`TextBox`或者`TextBlock`时, `StringFormat`是有效的, 但是使用`Label`时, 就无效了, 比如


```xml
<Label Content="{Binding roomGoods.totalCount,StringFormat=TotalCount: {0:C}}"/>
```
只会显示`totalCount`的内容, 但是不会显示前面的`TotalCount: `部分

经过查询, 加入如下属性

```xml
<Label Content="{Binding roomGoods.totalCount}" ContentStringFormat="TotalCount: {0}"/>

```
