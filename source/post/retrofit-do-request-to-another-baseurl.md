title: Retrofit do request to another BASEURL
date: 2020-04-20 19:45:17 +0800
update: ""
author: linx
tags:
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



Android retrofit 调用不同的BASEURL的接口

<!--more-->

## 方法一

```kotlin
		@GET("/api/v1/attend/report/student")
    fun getStudentAtt(
                      @Query("imei") imei:String,
                      @Query("page") page:Int,
                      @Query("size") size:Int
      								@Header("Authorization") token: String = App.instance.token
    )
```

可以写成这样

```kotlin
    @GET("http://localhost:8989/api/v1/attend/report/student")
    fun getStudentAtt(
                      @Query("imei") imei:String,
                      @Query("page") page:Int,
                      @Query("size") size:Int
      								@Header("Authorization") token: String = App.instance.token
    )
```

即直接写完全请求地址即可

## 方法二

```kotlin
    @GET
    fun getStudentAtt(
      								@Url url:String,
                      @Query("imei") imei:String,
                      @Query("page") page:Int,
                      @Query("size") size:Int
      								@Header("Authorization") token: String = App.instance.token
    )
```

然后由外部传入url, 这个方案有个缺陷就是`@Url`不能像下面的token一样使用默认参数(调用时可不传), 因为`@Url`不允许在`@Query`参数之后传入, 而默认参数一般都是要放在最后的.



当然, 网上也有用拦截器实现的, 很明显没有上面两种实用.
