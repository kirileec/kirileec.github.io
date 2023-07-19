title: Android Kotlin RecyclerView Databinding
date: 2019-12-07 22:40:32 +0800
update: ""
author: linx
tags:
- kotlin
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


Android Kotlin RecyclerView Databinding
<!--more-->


- 一个已经能进行简单的按按钮操作的RecyclerView项目
-
    ```gradle
    apply plugin: 'kotlin-android'
    apply plugin: 'kotlin-kapt'
    apply plugin: 'kotlin-android-extensions'
    ```

    ```gradle
    dataBinding {
        enabled = true
    }
    ```

- 一个数据绑定辅助类
  
  ```kotlin
    /**
      * 赋予ImageView和ImageButton以 app:img 的属性, 用于绑定图片
      * @author linx
      */
    class BindingUtil {
        companion object {
            @BindingAdapter("app:img")
            @JvmStatic
            fun imgData(iv: ImageView, data: Int) {
                iv.setImageResource(data)
            }

            @BindingAdapter("app:img")
            @JvmStatic
            fun imgData(iv: ImageButton, data: Int) {
                iv.setBackgroundResource(android.R.color.transparent)
                iv.setImageResource(data)
            }

            /**
             * ImageView绑定图片地址url
             * @param iv ImageView
             * @param data Any
             */
            @BindingAdapter("app:url")
            @JvmStatic
            fun ImageViewUrl(iv: ImageView, data: Any) {
                if (data is String) {
                    if (!data.isEmpty()) {
                        Glide.with(iv.context).load(Uri.parse(data)).into(iv)
                    } else {
                        iv.setImageResource(R.mipmap.touxiang2_default)
                    }

                } else if (data is Int) {
                    iv.setImageResource(data)
                }
            }

        }
    }
  ```

- 一个数据adapter
  
  ```kotlin
    import android.view.LayoutInflater
    import android.view.View
    import android.view.ViewGroup
    import androidx.databinding.DataBindingUtil
    import androidx.databinding.ViewDataBinding
    import androidx.recyclerview.widget.RecyclerView.Adapter
    import androidx.recyclerview.widget.RecyclerView.ViewHolder
    import java.util.*

    /**
    * RecylerView 数据绑定适配器
    * @param T
    * @property mList List<T>?
    * @property layoutId Int?
    * @property brId Int?
    * @property itemClick ItemClick?
    * @constructor
    */
    open class QJBaseAdapter<T>(var mList: List<T>?, var layoutId: Int?, var brId: Int?) :
        Adapter<QJBaseAdapter.QJBaseViewHolder>() {


        var itemClick: ItemClick? = null

        /**
        * 更新数据
        * @param items ArrayList<T>?
        */
        fun updateData(items: ArrayList<T>?) {
            this.mList = items
            notifyDataSetChanged()
        }

        interface ItemClick {
            fun OnItemClick(v: View, position: Int)
        }

        fun setItemClickListener(itemClick: ItemClick) {
            this.itemClick = itemClick
        }


        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): QJBaseViewHolder {

            val binding: ViewDataBinding = DataBindingUtil.inflate(
                LayoutInflater.from(parent.context), this.layoutId!!, parent, false
            )
            return QJBaseViewHolder(binding)
        }

        override fun getItemCount(): Int = mList!!.size

        override fun onBindViewHolder(holder: QJBaseViewHolder, position: Int) {
            var item = mList!![position] // 这里必须为var 因为需要修改列表的数据
            doBeforeShow(holder.binding.root, item)
            holder.binding.setVariable(this.brId!!, mList!![position])
            holder.binding.executePendingBindings()
            // item点击事件
            holder.binding.root.setOnClickListener {
                itemClick?.OnItemClick(holder.binding.root, position)
            }
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
        open fun forInnerControl(itemView: View?, item: T) {

        }

        class QJBaseViewHolder(var binding: ViewDataBinding) : ViewHolder(binding.root)
    }
  ```
- 声明数据类
  
  ```kotlin
    data class SchoolNews(
        val title: String = "", //标题
        val contentShort: String = "", //内容简写
        val date: String = "", //日期
        val state: Int = 0, //0 unreaded 1 readed 2 pinned
        var img:Int =0
    )
  ```

- RecyclerView 的itemview中声明, 注意顶层元素使用layout, 其他盲敲即可, IDE会补全
  
  ```xml
    <layout xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto">
    <data>
        <variable
            name="schoolNews"
            type="model.SchoolNews" />
    </data>
  ```

- 以 `android:text="@{schoolNews.title}"` 这样的方式绑定数据, ImageView和ImageButton则以 `app:img="@{schoolNews.img}"` img 是resId即资源id, 图片的值不能直接绑定, 需要用代码`setImageResource`来实现

- 创建一个特定的适配器, 重写两个方法
  
  ```kotlin
    class SchoolNewsAdapter(mList: List<SchoolNews>?, layoutId: Int?, brId: Int?) :
        QJBaseAdapter<SchoolNews>(mList, layoutId, brId) {

        override fun forInnerControl(itemView: View?, item: SchoolNews) {
            // 这里可以为每个 itemView 的子控件添加事件
            
        }

        // 在这个方法中对item进行修改是可以应用到界面的, 不过肯定不能执行过于耗时的操作
        override fun doBeforeShow(itemView: View?, item: SchoolNews) {
            // 根据state字段的值来决定显示哪张图片
            when (item.state) {
                0-> item.img = R.mipmap.yuandian
                2-> item.img = R.mipmap.schoolnews_guding
                else->item.img = R.color.mainwhite
            }
        }


    }
  ```

  顺便说下, 代码中访问内置颜色是这样的`android.R.color.transparent`

- 最后就是使用了
  
  ```kotlin
    var mAdapter: SchoolNewsAdapter? = null

    private fun initView() {
        mAdapter = SchoolNewsAdapter(
            schoolNews, R.layout.recycler_view_item_school_news_info,
            BR.schoolNews
        )

        schoolNewsRv.adapter = mAdapter
    }
  ```

  这里说明下 schoolNews为 `ArrayList<SchoolNews>`, `R.layout.recycler_view_item_school_news_info`为item的布局文件, `BR.schoolNews`这个就是前面 `<layout>`内的variable了, 如果最开始的插件没有配置好, 这个会报错. 原理其实就是编译器自动帮我们生成好了代码

  更新数据则使用 `mAdapter!!.updateData(schoolNews)`即可
