title: Android Kotlin Fragmentadapter
date: 2019-12-07 23:13:56 +0800
update: ""
author: linx
tags:
- FragmentAdapter
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


Android Kotlin Fragmentadapter
<!--more-->

刚接触kotlin写安卓, 一脸懵逼, 连教程都没看就开搞了

直接上代码

```kotlin
package ${package}.base

import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentPagerAdapter

/**
 * Fragment适配器, ViewPager用
 * @property fm FragmentManager
 * @property fragments MutableList<Fragment>
 * @property fragmentTitles MutableList<String>
 * @constructor
 */
class QJFragmentAdapter(val fm: FragmentManager) : FragmentPagerAdapter(fm,BEHAVIOR_RESUME_ONLY_CURRENT_FRAGMENT) {

    var fragments: MutableList<Fragment> = ArrayList()
    var fragmentTitles: MutableList<String> = ArrayList()

    override fun getItem(position: Int): Fragment {
        return fragments[position]
    }
    fun addFragment(fragment: Fragment, title: String) {
        fragments.add(fragment)
        fragmentTitles.add(title)
    }

    override fun getPageTitle(position: Int): CharSequence? {
        return fragmentTitles[position]
    }
    override fun getCount(): Int = fragments.size
}
```

使用方式很简单

```kotlin
var adapter = QJFragmentAdapter(supportFragmentManager)
var makeLeaveFragment = MakeLeaveFragment()
var leaveListFragment = LeaveListFragment()

adapter.addFragment(MakeLeaveFragment(), makeLeaveFragment.title)
adapter.addFragment(LeaveListFragment(), leaveListFragment.title)

viewPager.adapter = adapter
tabLayout.setupWithViewPager(viewPager)
```

可以简化的地方: 创建一个BaseFragment, 声明一个title的属性, 然后每个Fragment类都继承这个, 就可以改成 `adapter.addFragment(MakeLeaveFragment())` 这样少一行代码了
