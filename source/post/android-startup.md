title: Android APP初始的操作
date: 2019-11-18 16:22:46 +0800
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


Android APP初始的操作, 调用后台API
<!--more-->

## 操作环境 

- Android Studio 3.5.1

## 步骤
1. 没有模拟器的需要先建立模拟器
2. 没有代理的先把gradle设置全局HTTP代理
3. 建立kotlin项目, 选择Empty Activity
4. 新建一个Activity, 在上面放几个按钮和文本框, 注意设置android:id和android:onClick
5. 添加以下引用,Sync一下

```gradle
    implementation 'com.squareup.retrofit2:converter-gson:2.4.0'
    //okhttp提供的请求日志拦截器
    implementation 'com.squareup.okhttp3:logging-interceptor:3.10.0'
    implementation 'com.squareup.retrofit2:adapter-rxjava2:2.5.0'
    implementation 'com.squareup.retrofit2:retrofit:2.5.0'
    implementation 'io.reactivex.rxjava2:rxandroid:2.1.1'
```
6. AndroidManifest.xml 中修改一下 exported 属性, 一个APP必需要有一个默认的
```xml
<activity android:name=".MainActivity" android:exported="true"></activity>
```
7. 同样的 AndroidManifest.xml, 增加两条权限声明, 否则无法访问网络. **需要注意权限修改后需要卸载模拟器里的APP才可以, 可以到设置的APP列表里进行卸载, 调试的时候在外面看不到**

```xml
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
<uses-permission android:name="android.permission.INTERNET"/>
```

8. res下建立xml目录, 并在其下建立 network_security_config.xml文件, 内容如下
```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true" />
</network-security-config>
```
9. AndroidManifest.xml 加入 networkSecurityConfig
```xml
<application
    android:allowBackup="true"
    android:icon="@mipmap/ic_launcher"
    android:label="@string/app_name"
    android:roundIcon="@mipmap/ic_launcher_round"
    android:supportsRtl="true"
    android:networkSecurityConfig="@xml/network_security_config"
    android:theme="@style/AppTheme">
```

10. 建立api接口, Observable需要引用 `import io.reactivex.Observable`

```kt
interface ApiService {
    @GET("/testGet")
    fun getData(@Query("a") a:String):Observable<ResponseBody>

    @POST("/testPOST")
    fun postData(@Query("a") a:String,@Body myBody:MyBody) :Observable<MyBody>
}
```

11. 建立数据类
```kt
data class MyBody (
    val name:String,
    val age:Int
)
```
12. 创建自定义的httpclient

```kt
var myClient = okhttp3.OkHttpClient.Builder()
        .connectTimeout(10,TimeUnit.SECONDS)
        .writeTimeout(5,TimeUnit.SECONDS)
        .readTimeout(5,TimeUnit.SECONDS).build()
```

13. 可以调用了

```kt
var retrofit = Retrofit.Builder().baseUrl("http://192.168.3.24:8585").client(myClient)
            .addCallAdapterFactory(RxJava2CallAdapterFactory.create())
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
            .postData("a", MyBody("ss",19))
            .subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread())
            .subscribe({
                resultTextView.setText(it.toString())
            }) {
                println(it)
            }
```

14. 最后需要把 Retrofit2 封装一下方便调用


PS: kotlin的语法还不太清楚, 瞎写的
