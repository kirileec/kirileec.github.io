title: 高德地图平滑移动（跟踪进度）
date: 2020-05-10 21:42:37 +0800
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

import android.animation.Animator
import android.animation.AnimatorListenerAdapter
import android.animation.TypeEvaluator
import android.animation.ValueAnimator
import android.content.Context
import android.view.View
import android.view.animation.LinearInterpolator
import android.widget.LinearLayout
import com.amap.api.maps.AMap
import com.amap.api.maps.AMapUtils
import com.amap.api.maps.model.*
import com.zx.xiaohui.R
import kotlin.collections.ArrayList
import kotlin.math.atan2

class SmoothMarker(private val context:Context,private val mAMap: AMap) : AMap.InfoWindowAdapter {
    class LngLat(val lng: Double, val lat: Double) {
        override fun toString(): String {
            return "LngLat{" +
                    "lng=" + lng +
                    ", lat=" + lat +
                    '}'
        }
    }

    class LngLatEvaluator : TypeEvaluator<Any?> {
        override fun evaluate(fraction: Float, startValue: Any?, endValue: Any?): Any? {
            val startLnglat = startValue as LngLat?
            val endLnglat = endValue as LngLat?
            val lng = startLnglat!!.lng + fraction * (endLnglat!!.lng - startLnglat.lng)
            val lat = startLnglat.lat + fraction * (endLnglat.lat - startLnglat.lat)
            return LngLat(lng, lat)
        }
    }
    /**
     * 实现此接口来监听平滑移动的过程
     */
    interface SmoothMarkerMoveListener {
        fun move(curIndex:Int)
        fun stop()
    }


    private var moveListener: SmoothMarkerMoveListener? = null

    //每段点的队列，第一个点为起点
    private val points: ArrayList<LatLng?> = arrayListOf()

    //每段距离 队列  大小为points.size() - 1
    //使用ArrayList而不是LinkedList, 方可实现拖拽进度条来从任意位置继续平滑移动
    private val eachDistance : ArrayList<Double> = arrayListOf()

    private var totalDistance = 0.0 //总距离
    private var remainDistance = 0.0 // 剩余距离
    private var endPoint: LatLng? = null
    private var lastEndPoint: LatLng? = null

    //移动的marker
    var marker: Marker? = null
        private set
    /**
     * 平滑移动的速度，单位km/h
     */
    var speed = 0f

    //marker动画
    private var markerAnimator: ValueAnimator? = null

    //是否暂停动画
    private var animStop = true
    //当前位置所对应的经纬度
    private var currentLatLng: LatLng? = null
    //下一个位置
    private var nextPos: LatLng? = null
    //一段动画被中断
    private var animCancel = false
    //本次动画移动的距离
    private var currentPlayDistance = 0.0
    //本次动画剩余距离
    private var currentRemainDistance = 0.0
    //悬浮跟随的窗口(移动的头像)
    private var infoWindowLayout: LinearLayout? = null
    //当前进行动画的那一段的索引
    private var curIndex:Int = 0

    /**
     * 总段数, 用于进度条显示
     */
    var totalCount :Int = 0

    /**
     * 设置平滑移动的经纬度数组
     *
     * 将同时创建marker和跟随悬浮的图标
     * @param points
     */
    fun setPoints(points: List<LatLng>) {
        this.points.clear()
        for (latLng in points) {
            this.points.add(latLng)
        }
        if (points.size > 1) {
            endPoint = points[points.size - 1]
            lastEndPoint = points[points.size - 2]
        }
        eachDistance.clear()
        totalDistance = 0.0
        curIndex = 0
        totalCount = 0

        //逐段计算距离
        for (i in 0 until points.size - 1) {
            val distance = AMapUtils.calculateLineDistance(points[i], points[i + 1]).toDouble()
            eachDistance.add(distance)
            totalDistance += distance
            totalCount ++
        }
        remainDistance = totalDistance

        val markerPoint: LatLng? = this.points.first()
        if (marker != null) {
            marker!!.position = markerPoint
        } else {
            marker = mAMap.addMarker(
                MarkerOptions().anchor(
                    0.5f,
                    0.5f
                ).icon(BitmapDescriptorFactory.fromResource(R.mipmap.baby))
                    .alpha(0f)
                    .setInfoWindowOffset(0,130)
            )
            infoWindowLayout = LinearLayout(context)
            infoWindowLayout!!.orientation = LinearLayout.VERTICAL
            infoWindowLayout!!.setBackgroundResource(R.mipmap.baby)
            marker!!.position = markerPoint
        }
    }


    /**
     * 开始平滑移动
     */
    fun startSmoothMove() {
        if (points.size < 1) {
            return
        }
        animStop = false

        mAMap.setInfoWindowAdapter(this)

        marker!!.showInfoWindow()
        startRun()
    }

    /**
     * 开始动画
     *
     * 递归调用
     */
    private fun startRun() {
        if (curIndex>=totalCount-1) {
            setEndRotate()
            return
        }
        val dis = eachDistance[curIndex]
        val time = (dis / speed * 60 * 60).toLong()
        //计算旋转
        val curPos: LatLng = marker!!.position
        nextPos = points[curIndex+1]

        val rotate = getRotate(curPos, nextPos)
        marker!!.rotateAngle = 360 - rotate + mAMap.cameraPosition.bearing
        val curLngLat = LngLat(curPos.longitude, curPos.latitude)
        val nextLngLat = LngLat(nextPos!!.longitude, nextPos!!.latitude)

        markerAnimator = ValueAnimator.ofObject(LngLatEvaluator(), curLngLat, nextLngLat)
        markerAnimator!!.duration = time //本段动画总时间
        markerAnimator!!.interpolator = LinearInterpolator() //线性的动画

        //动画更新marker的位置
        markerAnimator!!.addUpdateListener { animation ->
            val lngLat: LngLat = animation.animatedValue as LngLat
            currentLatLng = LatLng(lngLat.lat, lngLat.lng)

            marker!!.position = currentLatLng
            //当前段运动的距离
            currentPlayDistance = dis * animation.currentPlayTime / time
            //当前段剩下的距离
            currentRemainDistance = remainDistance - currentPlayDistance
            if (currentRemainDistance < 0)
                currentRemainDistance = 0.0

        }
        markerAnimator!!.addListener(object : AnimatorListenerAdapter() {
            override fun onAnimationEnd(animation: Animator?) {
                 if (!animCancel) {
                     if (dis.isNaN()) {
                         remainDistance -= 0
                     } else {
                         remainDistance -= dis
                     }

                } else {
                     if (currentPlayDistance.isNaN()) {
                         remainDistance -= 0
                     } else {
                         remainDistance -= currentPlayDistance
                     }
                }
                //每一段动画结束后 回调索引
                if (moveListener != null) {
                    moveListener!!.move(curIndex)
                }
                //增加索引, 开始下一段
                curIndex++

                //如果不是最后一段
                if (!animStop) {
                    startRun()
                    animCancel = false
                }
            }

            override fun onAnimationCancel(animation: Animator?) {
                animCancel = true
            }
        })
        markerAnimator!!.start()
    }

    /**
     * 设置运行时间过短导致的 终点及角度问题
     */
    private fun setEndRotate() {
        val rotate = getRotate(lastEndPoint, endPoint)
        marker!!.rotateAngle = 360 - rotate + mAMap.cameraPosition.bearing
        marker!!.position = endPoint

        marker!!.hideInfoWindow()
        if (moveListener != null) {
            moveListener!!.stop()
        }
    }

    /**
     * 根据经纬度计算需要偏转的角度
     */
    private fun getRotate(curPos: LatLng?, nextPos: LatLng?): Float {
        val x1: Double = curPos!!.latitude
        val x2: Double = nextPos!!.latitude
        val y1: Double = curPos.longitude
        val y2: Double = nextPos.longitude
        return (atan2(y2 - y1, x2 - x1) / Math.PI * 180).toFloat()
    }

    /**
     * 停止平滑移动
     */
    fun stopMove() {
        if (animStop) {
            return
        }
        animStop = true
        markerAnimator!!.cancel()
    }

    /**
     * 暂停动画
     */
    fun pauseMove() {
        if (animStop) {
            return
        }
        animStop = true
        markerAnimator!!.cancel()
    }

    /**
     * 即时修改移动速度
     * @param speed Float 单位 km/h
     */
    fun changeSpeed(speed: Float) {
        pauseMove()
        this.speed = speed
        resumeMove()
    }

    /**
     * 恢复动画
     */
    fun resumeMove() {
        if (!animStop) {
            return
        }
        animStop = false
        startRun()
    }

    /**
     * 获取当前marker位置
     */
    val position: LatLng?
        get() = if (marker == null) null else marker!!.position

    /**
     * 销毁
     */
    fun destroy() {
        stopMove()
        if (marker != null) {
            marker!!.destroy()
            marker = null
        }
        points.clear()
        eachDistance.clear()
    }

    /**
     * 开始进度拖动时调用(按下的时候), 用于暂停动画
     */
    fun startChangePositionIndex() {
        pauseMove()
    }

    /**
     * 结束禁毒拖动时调用(抬起的时候), 继续动画
     */
    fun endChangePositionIndex() {
        resumeMove()
    }

    /**
     * 进度拖动过程中调用, 用于实时地显示位置
     * @param index Int
     */
    fun setPositionIndex(index:Int) {
        curIndex = index
        marker!!.position = points[curIndex]
    }

    fun setMoveListener(moveListener: SmoothMarkerMoveListener?) {
        this.moveListener = moveListener
    }


    //region <重载代码>
    override fun getInfoContents(p0: Marker?): View {
        return infoWindowLayout!!
    }

    override fun getInfoWindow(p0: Marker?): View {
        return infoWindowLayout!!
    }
    //endregion

}
```
