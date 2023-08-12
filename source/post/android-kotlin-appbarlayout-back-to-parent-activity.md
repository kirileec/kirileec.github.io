title: Android Kotlin Appbarlayout Back to Parent Activity
date: 2019-12-07 23:20:01 +0800
update: ""
author: linx
tags:
- AppBarLayout
- Kotlin
- android
categories:
- android
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: true
image: ""
subtitle: ""
config: {}


---


Android Kotlin Appbarlayout Back to Parent Activity
<!--more-->

我原先的写法是这样的

```xml
<androidx.appcompat.widget.Toolbar
    android:layout_width="match_parent"
    android:layout_height="44dp"
    android:onClick="backClick"
```
后来发现这样不行, 倒不是不能返回, 而是如果在旧版本android上运行会直接崩溃, 例如. android 6, 是的, 崩溃, 不会到backClick这个方法里.

所以只好老老实实的用代码处理了

```kotlin
addbindingToolbar.setNavigationOnClickListener {this.finish()}
```
