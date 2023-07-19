title: Android Layout
date: 2019-11-30 12:09:07 +0800
update: ""
author: linx
tags:
- android
- layout
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


安卓布局笔记
<!--more-->

## 常用属性说明

- `layout_width` & `layout_height` : 高度和宽度, match_parent 表示拉伸到父组件, wrap_content 表示, 内容有多大就撑多大
- `layout_marginxxx`: 与旁边组件的距离
- `paddingxxx`: 布局内部组件和边缘的距离
- `android:clickable="true"` & `android:focusable="true"`: 让一个本来不可以点击的组件可以触发点击事件
- `elevation`: Z轴抬起的高度, 一般用于搞阴影



## 线性布局 LinearLayout

### 常用属性

- `orientation` 排列方向 取值: `horizontal` `vertical` 即纵向和横向布局

### 子组件常用属性

- `android:layout_weight`: 布局的权重, 例如, 当LinearLayout内有三个元素, 只有中间那个元素的 layout_weight 设置为1, 那么它会把其他两个撑开, 当然其它两个的layout_weight或者layout_height不要是match_parent, 两种行为可能会冲突, 导致最终效果不对
- `android:layout_gravity` & `gravity`: 重力方向, 我一般配合 `android:layout_height="match_parent"` 让文字纵向居中,
- 也可以用于横向三个组件均分的情况

## 相对布局 RelativeLayout

相对布局用于各种奇怪的布局, 特别是多个块之间不是连在一起的(区别于线性布局), 组件多层的情况一般用这个

### 子组件常用属性

- `layout_alignParentxxx`: 对齐到父组件(容器)的某一边, 多写几个就可以让一个FloatingActionButton一直呆在右上角了
- `android:layout_above` & `android:layout_below`: 顾名思义, 对齐到某个组件的上面或下面
- `android:layout_alignLeft`系列: 不太好用的样子, 暂时还没有用这个

## 网格布局 GridLayout

这个就简单了, 布那种九宫格或者需要平均分的情况, 需要指定 `android:rowCount` 和 `android:columnCount`

### 子组件常用属性

- `layout_rowWeight` & `layout_columnWeight`: 同理, 权重, 一般也都是设置成1的, 不是1的情况也不多见
