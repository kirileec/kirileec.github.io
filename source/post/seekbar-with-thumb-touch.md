title: Seekbar With Thumb Touch
date: 2020-05-12 19:45:48 +0800
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

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.Rect
import android.util.AttributeSet
import android.view.MotionEvent


class SeekbarWithThumbTouch @JvmOverloads constructor(
    context: Context, attrs: AttributeSet? = null, defStyleAttr: Int = 0
) : androidx.appcompat.widget.AppCompatSeekBar(context, attrs, defStyleAttr) {
    private var thumbCall: (() -> Unit)? = null

    @SuppressLint("ClickableViewAccessibility")
    override fun onTouchEvent(event: MotionEvent): Boolean {
        when (event.action) {
            MotionEvent.ACTION_DOWN -> {
                super.onTouchEvent(event)
            }
            MotionEvent.ACTION_MOVE -> {
                super.onTouchEvent(event)
            }
            MotionEvent.ACTION_UP -> if (isClickThumb(event, thumb.bounds)) {
                if (thumbCall!=null) {
                    thumbCall!!()
                }
            }
        }
        return true
    }

    /**
     * 设置点击事件只在thumb上有效
     *
     * @param event 点击事件
     * @param rect  thumb
     */
    private fun isClickThumb(event: MotionEvent, rect: Rect): Boolean {
        val x = event.x
        val y = event.y
        //根据左边距和thumb偏移量来确定thumb位置
        val left = rect.left - thumbOffset + paddingLeft.toFloat()
        val right = left + rect.width()
        return x in left..right && y >= rect.top && y <= rect.bottom
    }

    fun setThumbClick(a:() -> Unit) {
        this.thumbCall = a
    }

}
```
