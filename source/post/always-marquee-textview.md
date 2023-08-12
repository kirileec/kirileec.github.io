title: 一直走马灯的TextView
date: 2020-05-12 19:37:46 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



```kotlin
package com.zx.xiaohui.helper

import android.content.Context
import android.util.AttributeSet


class AlwaysMarqueeTextView : androidx.appcompat.widget.AppCompatTextView {
    constructor(context: Context?) : super(context) {}
    constructor(context: Context?, attrs: AttributeSet?) : super(context, attrs) {}
    constructor(context: Context?, attrs: AttributeSet?, defStyle: Int) : super(context, attrs, defStyle) {}

    override fun isFocused(): Boolean {
        return true
    }
}
```

使用方法
```xml
<com.zx.xiaohui.helper.AlwaysMarqueeTextView
  ...
  android:singleLine="true"
  android:ellipsize="marquee"
>
</com.zx.xiaohui.helper.AlwaysMarqueeTextView>
```
