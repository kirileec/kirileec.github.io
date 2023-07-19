title: Android RecylerView BaseAdapter 更新
date: 2019-12-22 11:22:51 +0800
update: ""
author: linx
tags: []
categories: []
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


Android RecylerView BaseAdapter 更新(kotlin)
<!--more-->
废话不多说直接上代码

```kotlin
package com.qijin.xiaohui.base


import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.IntDef
import androidx.databinding.DataBindingUtil
import androidx.databinding.ViewDataBinding
import androidx.recyclerview.widget.RecyclerView
import androidx.recyclerview.widget.RecyclerView.Adapter
import androidx.recyclerview.widget.RecyclerView.ViewHolder
import com.qijin.xiaohui.R
import java.util.*


/**
 * RecylerView 数据绑定适配器
 * @param T
 * @property mList List<T>? 对应的数据列表
 * @property layoutId Int? RecylerView子item的布局id
 * @property brId Int? RecylerView子item中声明的model的名称(这个不会有代码提示, 直接写)
 * @property itemClick ItemClick? 项目item点击事件, 如果要对item内部的按钮设定时间, 重载forInnerControl即可
 * @constructor
 */
open class QJBaseAdapter<T> :
    Adapter<QJBaseAdapter.QJBaseViewHolder> {
    var mList: List<T>?
    var layoutId: Int?
    var brId: Int?

    constructor(context: BaseActivity, mList: List<T>?, layoutId: Int?, brId: Int?) : super() {
        this.mList = mList
        this.layoutId = layoutId
        this.brId = brId
        this.ctx = context
        this.layoutInflater = context.layoutInflater
        this.state = STATE_NORMAL
    }

    constructor(context: BaseFragment, mList: List<T>?, layoutId: Int?, brId: Int?) : super() {
        this.mList = mList
        this.layoutId = layoutId
        this.brId = brId
        this.ctx = context.context
        this.layoutInflater = context.layoutInflater
        this.state = STATE_NORMAL
    }
    var ctx:Context?=null
    open val layoutInflater:LayoutInflater?

    var itemClick: ItemClick? = null
    /**
     * 更新数据
     * @param items ArrayList<T>?
     */
    fun updateData(items: ArrayList<T>?) {
        this.mList = items
        if (LoadingView==null || EmptyView == null || ErrorView==null) {
            notifyDataSetChanged()
        } else {
            endLoading()
        }
    }

    fun startLoading() {
        if (LoadingView==null || EmptyView == null || ErrorView==null) {
            return
        }
        this.state = STATE_LOADING
        notifyDataSetChanged()
    }

    fun endLoading() {
        if (mList.orEmpty().size<=0) {
            this.state = STATE_EMPTY
        } else {
            this.state = STATE_NORMAL
        }
        if (state != STATE_NORMAL) {
            notifyDataSetChanged()
        } else {
            mListView.post({
                notifyDataSetChanged()
            })
        }

    }

    fun showError() {
        this.state = STATE_ERROR
        notifyDataSetChanged()
    }

    interface ItemClick {
        fun OnItemClick(v: View, position: Int)
    }

    fun setItemClickListener(itemClick: ItemClick) {
        this.itemClick = itemClick
    }


    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): QJBaseViewHolder {
        if (LoadingView!=null && EmptyView != null && ErrorView!=null) {
            when (viewType) {
                TYPE_LOADING -> {
                    return QJBaseViewHolder(LoadingView!!)
                }
                TYPE_EMPTY -> {
                    return QJBaseViewHolder(EmptyView!!)
                }
                TYPE_ERROR -> {
                    return QJBaseViewHolder(ErrorView!!)
                }
            }
        }

        val binding: ViewDataBinding = DataBindingUtil.inflate(
            LayoutInflater.from(parent.context), this.layoutId!!, parent, false
        )
        return QJBaseViewHolder(binding)
    }

    override fun getItemCount(): Int {
        when (state) {
            STATE_LOADING, STATE_EMPTY, STATE_ERROR -> return 1
        }
        return mList!!.size
    }


    override fun onBindViewHolder(holder: QJBaseViewHolder, position: Int) {
        if (state in arrayOf(STATE_LOADING,STATE_EMPTY,STATE_ERROR)) {return}

        var item = mList!![position] // 这里必须为var 因为需要修改列表的数据
        doBeforeShow(holder.binding.root, item)
        holder.binding.setVariable(this.brId!!, mList!![position])
        holder.binding.executePendingBindings()
        // item点击事件
        holder.binding.root.setOnClickListener {
            itemClick?.OnItemClick(holder.binding.root, position)
        }
        forInnerControl(holder.binding.root, item,position)
        forInnerControl(holder.binding.root, item)
    }




    /**
     * 在绑定数据之前执行, 可以修改数据 item 的值
     * @param itemView View?
     * @param item T
     */
    open fun doBeforeShow(itemView: View?, item: T) {

    }

    /**
     * 用于给ItemView内部的组件绑定事件
     * @param itemView View?
     * @param item T
     */
    open fun forInnerControl(itemView: View?, item: T,position: Int = 0) {

    }

    open fun forInnerControl(itemView: View?, item: T) {

    }


    class QJBaseViewHolder : ViewHolder {
        lateinit var binding: ViewDataBinding
        lateinit var view:View

        constructor(binding: ViewDataBinding) : super(binding.root) {
            this.binding = binding
        }

        constructor(view:View):super(view) {
            this.view = view
        }
    }


    var LoadingView: View? = null
        set(value) {
            field = value
        }
    var EmptyView: View? = null
        set(value) {
            field = value
        }
    var ErrorView: View? = null
        set(value) {
            field = value
        }

    @State
    private var state: Int = STATE_NORMAL

    companion object {
        const val STATE_NORMAL = 0
        const val STATE_LOADING = 1
        const val STATE_EMPTY = 2
        const val STATE_ERROR = 3
        const val TYPE_LOADING = 1000
        const val TYPE_EMPTY = 1001
        const val TYPE_ERROR = 1002

        @IntDef(STATE_NORMAL, STATE_LOADING, STATE_EMPTY, STATE_ERROR)
        @Retention(AnnotationRetention.SOURCE)
        annotation class State
    }

    @State
    open fun getState(): Int {
        return this.state
    }

    open fun setState(@State state: Int) {
        this.state = state
        notifyDataSetChanged()
    }

    override fun getItemViewType(position: Int): Int {
        return when (state) {
            STATE_LOADING -> TYPE_LOADING
            STATE_EMPTY -> TYPE_EMPTY
            STATE_ERROR -> TYPE_ERROR
            else -> super.getItemViewType(position)
        }
    }

    lateinit var mListView:RecyclerView

    fun setView(listView:RecyclerView) {
        LoadingView = layoutInflater!!.inflate(R.layout.rv_loading,listView,false)
        ErrorView = layoutInflater!!.inflate(R.layout.error,listView,false)
        EmptyView = layoutInflater!!.inflate(R.layout.empty,listView,false)
        listView.adapter = this
        mListView = listView
    }
}
```

## 更新

1. 新增 `fun setView(listView:RecyclerView)` 用于为 RecyclerView 设置"加载中" "加载失败" "无数据" 三种视图. 只需要
在调用数据开始的时候 `mAdapter.startLoading()`, 在 mAdapter.updateData(mList) 时, 将自动停止加载. 同时不用调用 `listView.adapter = mAdapter` 了
2. 增加另外一个 `forInnerControl`的版本多一个 position的参数, 用于简单实现"动态的单选RadioButton"功能, 两个版本重载一个即可
3. 增加一个构造函数, 传入两种类型的context
4. 不断更新....
