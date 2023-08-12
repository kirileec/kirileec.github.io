title: .net-grpc-android.md
date: 2021-09-11 11:48:07 +0800
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



# Android 连接 .Net 的gRPC服务

## .Net开启ssl gRPC

```c#
webBuilder.UseKestrel().ConfigureKestrel(e =>
{
    e.Listen(IPAddress.Any, 23333, listenConfigure =>
    {
        listenConfigure.Protocols = HttpProtocols.Http2;
        listenConfigure.UseHttps(new X509Certificate2("1.pfx","123456"));
    });
});
```
## Android 使用ssl
```kotlin
val caKeyStore: KeyStore = KeyStore.getInstance("PKCS12", "BC").apply {
            load(assets.open("1.pfx"), "123456".toCharArray())
            //setCertificateEntry("server", serverCertificate)
        }

        val trustManagerFactory = TrustManagerFactory.getInstance(TrustManagerFactory.getDefaultAlgorithm()).apply {
            init(caKeyStore)
        }

        val sslContext = SSLContext.getInstance("TLS").apply {
            init(null, trustManagerFactory.trustManagers, null)
        }
        
        managedChannel =
            OkHttpChannelBuilder.forAddress("192.168.3.233", 23333)
                    .hostnameVerifier { hostname, session ->
                        true
                    }
                    .sslSocketFactory(sslContext.socketFactory)
                    .keepAliveTime(10, TimeUnit.SECONDS)
                    .useTransportSecurity()
                    .keepAliveWithoutCalls(true)
                    .build()
```


## 安卓项目配置

```groovy
ext.kotlin_version = '1.5.30'
ext.grpc_version = '1.40.0'


maven { url 'https://maven.aliyun.com/repository/public/'}
maven { url "https://jitpack.io" }
maven { url 'http://maven.aliyun.com/nexus/content/repositories/releases/'}
google()
mavenCentral()

classpath 'com.google.protobuf:protobuf-gradle-plugin:0.8.17'
```
```groovy
apply plugin: 'com.google.protobuf'

android {
    sourceSets {
        main {
            java {
                srcDir 'src/main/java'
            }
            proto  {
                srcDir 'src/main/java/com/example/caller/proto' //指定proto文件位置
                include '**/*.proto'
            }
        }
    }
    lintOptions {
        // Do not complain about outdated deps, so that this can javax.annotation-api can be same
        // as other projects in this repo. Your project is not required to do this, and can
        // upgrade the dep.
        disable 'GradleDependency'
        // The Android linter does not correctly detect resources used in Kotlin.
        // See:
        //   - https://youtrack.jetbrains.com/issue/KT-7729
        //   - https://youtrack.jetbrains.com/issue/KT-12499
        disable 'UnusedResources'
        textReport true
        textOutput "stdout"
    }
}
```
```groovy
protobuf {
    protoc { artifact = 'com.google.protobuf:protoc:3.17.3' }
    plugins {
        javalite { artifact = "com.google.protobuf:protoc-gen-javalite:3.0.0" }
        grpc { artifact = "io.grpc:protoc-gen-grpc-java:$grpc_version" // CURRENT_GRPC_VERSION
        }
    }
    generateProtoTasks {
        all().each { task ->
            task.builtins {
                java { option 'lite' }
            }
            task.plugins {
                grpc { option 'lite' }
            }
        }
    }
}
```

```groovy
dependencies {
    implementation "io.grpc:grpc-okhttp:$grpc_version" // CURRENT_GRPC_VERSION
    implementation "io.grpc:grpc-protobuf-lite:$grpc_version" // CURRENT_GRPC_VERSION
    implementation "io.grpc:grpc-stub:$grpc_version" // CURRENT_GRPC_VERSION
    implementation "javax.annotation:javax.annotation-api:1.3.2"
}
```

### proto文件放置位置

`srcDir`所指定的位置即`src/main/java/me/example/packagename/proto`，我这里是放在当前包名下的proto目录下

### proto生成的Stub文件的包名

在proto文件中增加一行`option java_package="com.example.caller";`即可。`com.example.caller` 为包名.

### 生成

点击Android Studio顶部的build即可生成，即使有报错（依赖或代码错误），stub文件也是可以生成的，之后可以到generated目录下查看文件

### AndroidChannelBuilder

Android上建议使用[这个](https://github.com/grpc/grpc-java/blob/master/android/src/main/java/io/grpc/android/AndroidChannelBuilder.java)来作为channel，可以检测到网络连接的变化，代码如下

```java
package com.example.caller.grpc;

import android.annotation.TargetApi;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.net.ConnectivityManager;
import android.net.Network;
import android.os.Build;
import android.util.Log;
import com.google.common.annotations.VisibleForTesting;
import com.google.common.base.Preconditions;
import io.grpc.CallOptions;
import io.grpc.ClientCall;
import io.grpc.ConnectivityState;
import io.grpc.ExperimentalApi;
import io.grpc.ForwardingChannelBuilder;
import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.MethodDescriptor;
import io.grpc.internal.GrpcUtil;
import java.util.concurrent.TimeUnit;
import javax.annotation.Nullable;
import javax.annotation.concurrent.GuardedBy;

/**
 * Builds a {@link ManagedChannel} that, when provided with a {@link Context}, will automatically
 * monitor the Android device's network state to smoothly handle intermittent network failures.
 *
 * <p>Currently only compatible with gRPC's OkHttp transport, which must be available at runtime.
 *
 * <p>Requires the Android ACCESS_NETWORK_STATE permission.
 *
 * @since 1.12.0
 */
public final class AndroidChannelBuilder extends ForwardingChannelBuilder<AndroidChannelBuilder> {

    private static final String LOG_TAG = "AndroidChannelBuilder";

    @Nullable
    private static final Class<?> OKHTTP_CHANNEL_BUILDER_CLASS = findOkHttp();

    private static Class<?> findOkHttp() {
        try {
            return Class.forName("io.grpc.okhttp.OkHttpChannelBuilder");
        } catch (ClassNotFoundException e) {
            return null;
        }
    }

    private final ManagedChannelBuilder<?> delegateBuilder;

    @Nullable private Context context;

    /**
     * Creates a new builder with the given target string that will be resolved by
     * {@link io.grpc.NameResolver}.
     */
    public static AndroidChannelBuilder forTarget(String target) {
        return new AndroidChannelBuilder(target);
    }

    /**
     * Creates a new builder with the given host and port.
     */
    public static AndroidChannelBuilder forAddress(String name, int port) {
        return forTarget(GrpcUtil.authorityFromHostAndPort(name, port));
    }

    /**
     * Creates a new builder, which delegates to the given ManagedChannelBuilder.
     *
     * @deprecated Use {@link #usingBuilder(ManagedChannelBuilder)} instead.
     */
    @ExperimentalApi("https://github.com/grpc/grpc-java/issues/6043")
    @Deprecated
    public static AndroidChannelBuilder fromBuilder(ManagedChannelBuilder<?> builder) {
        return usingBuilder(builder);
    }

    /**
     * Creates a new builder, which delegates to the given ManagedChannelBuilder.
     *
     * <p>The provided {@code builder} becomes "owned" by AndroidChannelBuilder. The caller should
     * not modify the provided builder and AndroidChannelBuilder may modify it. That implies reusing
     * the provided builder to build another channel may result with unexpected configurations. That
     * usage should be discouraged.
     *
     * @since 1.24.0
     */
    public static AndroidChannelBuilder usingBuilder(ManagedChannelBuilder<?> builder) {
        return new AndroidChannelBuilder(builder);
    }

    private AndroidChannelBuilder(String target) {
        if (OKHTTP_CHANNEL_BUILDER_CLASS == null) {
            throw new UnsupportedOperationException("No ManagedChannelBuilder found on the classpath");
        }
        try {
            delegateBuilder =
                    (ManagedChannelBuilder)
                            OKHTTP_CHANNEL_BUILDER_CLASS
                                    .getMethod("forTarget", String.class)
                                    .invoke(null, target);
        } catch (Exception e) {
            throw new RuntimeException("Failed to create ManagedChannelBuilder", e);
        }
    }

    private AndroidChannelBuilder(ManagedChannelBuilder<?> delegateBuilder) {
        this.delegateBuilder = Preconditions.checkNotNull(delegateBuilder, "delegateBuilder");
    }

    /**
     * Enables automatic monitoring of the device's network state.
     */
    public AndroidChannelBuilder context(Context context) {
        this.context = context;
        return this;
    }

    @Override
    protected ManagedChannelBuilder<?> delegate() {
        return delegateBuilder;
    }

    /**
     * Builds a channel with current configurations.
     */
    @Override
    public ManagedChannel build() {
        return new AndroidChannel(delegateBuilder.build(), context);
    }

    /**
     * Wraps an OkHttp channel and handles invoking the appropriate methods (e.g., {@link
     * ManagedChannel#enterIdle) when the device network state changes.
     */
    @VisibleForTesting
    static final class AndroidChannel extends ManagedChannel {

        private final ManagedChannel delegate;

        @Nullable private final Context context;
        @Nullable private final ConnectivityManager connectivityManager;

        private final Object lock = new Object();

        @GuardedBy("lock")
        private Runnable unregisterRunnable;

        @VisibleForTesting
        AndroidChannel(final ManagedChannel delegate, @Nullable Context context) {
            this.delegate = delegate;
            this.context = context;

            if (context != null) {
                connectivityManager =
                        (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
                try {
                    configureNetworkMonitoring();
                } catch (SecurityException e) {
                    Log.w(
                            LOG_TAG,
                            "Failed to configure network monitoring. Does app have ACCESS_NETWORK_STATE"
                                    + " permission?",
                            e);
                }
            } else {
                connectivityManager = null;
            }
        }

        @GuardedBy("lock")
        private void configureNetworkMonitoring() {
            // Android N added the registerDefaultNetworkCallback API to listen to changes in the device's
            // default network. For earlier Android API levels, use the BroadcastReceiver API.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N && connectivityManager != null) {
                final DefaultNetworkCallback defaultNetworkCallback = new DefaultNetworkCallback();
                connectivityManager.registerDefaultNetworkCallback(defaultNetworkCallback);
                unregisterRunnable =
                        new Runnable() {
                            @TargetApi(Build.VERSION_CODES.LOLLIPOP)
                            @Override
                            public void run() {
                                connectivityManager.unregisterNetworkCallback(defaultNetworkCallback);
                            }
                        };
            } else {
                final NetworkReceiver networkReceiver = new NetworkReceiver();
                @SuppressWarnings("deprecation")
                IntentFilter networkIntentFilter =
                        new IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION);
                context.registerReceiver(networkReceiver, networkIntentFilter);
                unregisterRunnable =
                        new Runnable() {
                            @TargetApi(Build.VERSION_CODES.LOLLIPOP)
                            @Override
                            public void run() {
                                context.unregisterReceiver(networkReceiver);
                            }
                        };
            }
        }

        private void unregisterNetworkListener() {
            synchronized (lock) {
                if (unregisterRunnable != null) {
                    unregisterRunnable.run();
                    unregisterRunnable = null;
                }
            }
        }

        @Override
        public ManagedChannel shutdown() {
            unregisterNetworkListener();
            return delegate.shutdown();
        }

        @Override
        public boolean isShutdown() {
            return delegate.isShutdown();
        }

        @Override
        public boolean isTerminated() {
            return delegate.isTerminated();
        }

        @Override
        public ManagedChannel shutdownNow() {
            unregisterNetworkListener();
            return delegate.shutdownNow();
        }

        @Override
        public boolean awaitTermination(long timeout, TimeUnit unit) throws InterruptedException {
            return delegate.awaitTermination(timeout, unit);
        }

        @Override
        public <RequestT, ResponseT> ClientCall<RequestT, ResponseT> newCall(
                MethodDescriptor<RequestT, ResponseT> methodDescriptor, CallOptions callOptions) {
            return delegate.newCall(methodDescriptor, callOptions);
        }

        @Override
        public String authority() {
            return delegate.authority();
        }

        @Override
        public ConnectivityState getState(boolean requestConnection) {
            return delegate.getState(requestConnection);
        }

        @Override
        public void notifyWhenStateChanged(ConnectivityState source, Runnable callback) {
            delegate.notifyWhenStateChanged(source, callback);
        }

        @Override
        public void resetConnectBackoff() {
            delegate.resetConnectBackoff();
        }

        @Override
        public void enterIdle() {
            delegate.enterIdle();
        }

        /** Respond to changes in the default network. Only used on API levels 24+. */
        @TargetApi(Build.VERSION_CODES.N)
        private class DefaultNetworkCallback extends ConnectivityManager.NetworkCallback {
            @Override
            public void onAvailable(Network network) {
                delegate.enterIdle();
            }
        }

        /** Respond to network changes. Only used on API levels < 24. */
        private class NetworkReceiver extends BroadcastReceiver {
            private boolean isConnected = false;

            @SuppressWarnings("deprecation")
            @Override
            public void onReceive(Context context, Intent intent) {
                ConnectivityManager conn =
                        (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
                android.net.NetworkInfo networkInfo = conn.getActiveNetworkInfo();
                boolean wasConnected = isConnected;
                isConnected = networkInfo != null && networkInfo.isConnected();
                if (isConnected && !wasConnected) {
                    delegate.enterIdle();
                }
            }
        }
    }
}

```

### 管理Channel

这里整了个单例
```kotlin
import com.qijin.evaluating.grpc.AndroidChannelBuilder
import io.grpc.ManagedChannel
import java.util.concurrent.TimeUnit

class GrpcService private constructor(){
    companion object {
        val instance: GrpcService by lazy(mode = LazyThreadSafetyMode.SYNCHRONIZED) { GrpcService() }
    }
    var channel: ManagedChannel?=null
    var _serverIP:String = ""

    fun makeChannel(serverIP:String) {
        _serverIP = serverIP
        if (channel==null) {
            createChannel()
        } else {
            channel = null
            createChannel()
        }
    }
    private fun createChannel() {
        var serverIP = ""
        var port = 23333
        if (_serverIP.contains(":")) {
            serverIP = _serverIP.split(":")[0]
            port = _serverIP.split(":")[1].toInt()
        } else {
            serverIP = _serverIP
        }
        channel = AndroidChannelBuilder.forAddress(serverIP,port)
            .usePlaintext()
            .context(App.instance)
            .keepAliveTimeout(5, TimeUnit.SECONDS)
            .keepAliveTime(1, TimeUnit.SECONDS)
            .keepAliveWithoutCalls(true)
            .build()
    }

    fun getMyChannel(forceRecreate:Boolean=false):ManagedChannel {
        if (forceRecreate) {
            channel=null
        }
        if (channel==null && _serverIP!="") {
            createChannel()
        }
        return channel!!
    }
}
```

只要在开始时makeChannel传入服务器ip和端口即可，只传ip则使用默认端口

getMyChannel 的 forceRecreate 参数用于在连接断开后的重新创建连接，
这样比较暴力，不过可以达到目的，关于此，详细看下面的内容



### 调用示例

#### 异步调用

PS: 
1. StreamObserver的三个方法都是线程中的方法，因此在方法内执行ui相关的代码时需要 **runOnUiThread**
2. 同时`onNext`中发生的异常会到`onError`中抛出，而正常情况下，`onError`中我们只希望捕获到接口返回的异常，因此`onNext`请妥善处理异常情况。否则`onNext`的异常会导致channel的连接**诡异**断开（在streams部分解释为什么）

```kotlin
val client = EvaluateDeviceGrpc.newStub(GrpcService.instance.getMyChannel())
val req = EvaluateDeviceOuterClass.GetUserInfoRequest.newBuilder()
.setEveluteDeviceID(evaluateId)
.setUserNo(et_no.text.toString())
.build()

client.getUserInfo(req, object :StreamObserver<EvaluateDeviceOuterClass.UserResponse> {
    override fun onNext(value: EvaluateDeviceOuterClass.UserResponse?) {

    }
    override fun onError(t: Throwable?) {

    }
    override fun onCompleted() {

    }
}
```


#### streams订阅连接
```kotlin
private fun startConfigSub(force: Boolean = false) {
    val c = DeviceInfoServiceGrpc.newStub(GrpcService.instance.getMyChannel(force))
            val req = DeviceInfo.DeviceConfigRequest.newBuilder().setDeviceType("P")
                .setMac(DeviceUtils.getMacAddress()).build()
    c.deviceConfig(req, object : StreamObserver<DeviceInfo.DeviceConfigResponse> {
                override fun onNext(value: DeviceInfo.DeviceConfigResponse?) {
                    
                }

                override fun onError(t: Throwable?) {
                    Log.d("WorkFragment", "报错重连")
                    if (t?.message?.contains("Keepalive") == true) {
                        startConfigSub(true)
                    } else {
                        startConfigSub()
                    }
                }

                override fun onCompleted() {
                    
                }

            })

}
```

streams接口在连接不正常时不会通过keepalive而重新进行调用， 因此需要在发生特定异常时，重新调用方法， 并且需要使channel重新创建，即force传true。
如果异常不是连接类异常（业务异常），则无需重新创建channel直接重新调用即可。




#### 同步调用
```kotlin
fun deviceReg(): Boolean {
        try {
            val c = DeviceInfoServiceGrpc.newBlockingStub(GrpcService.instance.getMyChannel())
            val req = DeviceInfo.DeviceInfoRegistRequest.newBuilder()
                .setDeviceType("P")
                .setMac(DeviceUtils.getMacAddress())
                .setDeviceIP(NetworkUtils.getIPAddress(true))
                .setHostName(DeviceUtils.getAndroidID())
                .setVersion(App.instance.getAppVersionName())
                .setDeviceID(DeviceUtils.getAndroidID())
                .setDesc("请修改此字段描述设备位置")
                .setDeviceName(DeviceUtils.getManufacturer() + "-" + DeviceUtils.getModel())
                .build()
            val resp = c.deviceRegist(req)
            Log.d("WorkFragment", resp.toString())
            return resp.code == "SUCCESS"
        } catch (e: java.lang.Exception) {
            e.printStackTrace()
            return false
        }

    }
```    

### .Net 维护streams长连接

```c#
// 维护设备连接
private static readonly ConcurrentDictionary<DeviceConfigRequest, IServerStreamWriter<DeviceConfigResponse>> _subscriptions =
            new ConcurrentDictionary<DeviceConfigRequest, IServerStreamWriter<DeviceConfigResponse>>();

public override async Task DeviceConfig(DeviceConfigRequest request, IServerStreamWriter<DeviceConfigResponse> responseStream, ServerCallContext context)
        {
            _logger.LogWarning($"{context.Peer} DeviceConfig");
            if (!_subscriptions.TryAdd(request,responseStream))
            {
                _logger.LogWarning("加入连接管理失败, 连接已存在");
                //连接存在说明 此设备是第二次连接过来了, 此时可以清除掉旧的连接, 添加新的连接
                //管理的连接 需要永远以最新的为准
                _logger.LogWarning($"{context.Peer} 设备[{request.DeviceType}]({request.Mac}) 清理旧连接");
                _subscriptions.TryRemove(request, out IServerStreamWriter<DeviceConfigResponse> value1);
                _subscriptions.TryAdd(request, responseStream);
            } else
            {
                _logger.LogWarning($"{context.Peer} 设备[{request.DeviceType}]({request.Mac}) 已连接, 首次下发配置");
                var config = getDeviceConfig(request.DeviceType, request.Mac);
                await responseStream.WriteAsync(config);
            }
            
            
            var count = 0;
            // Keep the stream open so we can continue writing new Messages as they are pushed
            while (!context.CancellationToken.IsCancellationRequested)
            {
                
                count++;
                // 当连接没断开时, 每1秒发送当前秒级时间
                if (count%10==0)
                {
                    await responseStream.WriteAsync(new DeviceConfigResponse()
                    {
                        Time = DateTime.Now.ToUnix2(),
                        Config = "",
                    });
                }
                if (count%100==0)
                {
                    count = 0;
                    // 当连接没断开时, 每x (10) 秒更新心跳数据
                    UpdateHeartData(request.DeviceType, request.Mac);
                }
                
                // Avoid pegging CPU
                await Task.Delay(100); //这里短一点可以让连接更快断开
            }
            // Cancellation was requested, remove the stream from stream map
            _logger.LogWarning($"{context.Peer} 设备[{request.DeviceType}]({request.Mac}) 连接断开, 正在清理");
            _subscriptions.TryGetValue(request, out IServerStreamWriter<DeviceConfigResponse> value);
            if (value!=null && value.Equals(responseStream))
            {
                _logger.LogWarning($"{context.Peer} 设备[{request.DeviceType}]({request.Mac}) 原始连接, 正在清理");
                _subscriptions.TryRemove(request, out IServerStreamWriter<DeviceConfigResponse> _);
            } else
            {
                _logger.LogWarning($"{context.Peer} 设备[{request.DeviceType}]({request.Mac}) 已是新连接, 不清理 {_subscriptions.Count}");
            }
        }
```

这里实现了一个设备只有一个连接的逻辑，DeviceConfigRequest 作为_subscriptions的key，只有mac地址和设备类型，也就是一个mac地址只能有一个连接在维持

- 当设备主动断开连接（正常退出等），则跳出while循环到`原始连接, 正在清理`部分
- 当设备异常断开，诸如网络问题或强制关闭，则旧连接可能还没有被清理，新连接进来后将到 `加入连接管理失败, 连接已存在`，此时将_subscriptions里的responseStream更新一下，`已是新连接, 不清理`就是为了防止新连接已建立，但是旧的连接才刚退出循环的情况，此时不能将_subscriptions里唯一的连接给清理掉
- 服务端重启，则只要保证客户端能重新连接即可


### WinForm

```c#
using Grpc.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PrintNumber
{
    public class GrpcService
    {
        private GrpcService() { }
        private static GrpcService _instance = null;
        public static GrpcService Instance
        {
            get {
                if (_instance == null)
                {
                    _instance = new GrpcService();
                }
                return _instance;
            }
        }


        private Channel channel;
        private string _serverIP = "";

        public void makeChannel(string serverIP)
        {
            _serverIP = serverIP;
            if (channel==null)
            {
                createChannel();
            }
        }

        private void createChannel()
        {
            var opts = new List<ChannelOption>();
            opts.Add(new ChannelOption("grpc.keepalive_time_ms", 1000));
            opts.Add(new ChannelOption("grpc.keepalive_timeout_ms", 5000));
            opts.Add(new ChannelOption("grpc.keepalive_permit_without_calls", 1));
            channel = new Channel($"{_serverIP}:23333", ChannelCredentials.Insecure,opts);
        }

        public Channel getMyChannel(bool forceRecreate = false)
        {
            if (forceRecreate)
            {
                channel = null;
            }
            if (channel==null && _serverIP!="")
            {
                createChannel();
            }
            return channel;

        }
    }
}
```

```c#
// 用于程序退出后取消streams连接
static CancellationTokenSource cancelTokenSource = new CancellationTokenSource();

private async void startConfigSubAsync(CancellationTokenSource token, bool force= false)
        {
            if (token.IsCancellationRequested || !isMain)
            {
                return;
            }
            var aClient = new DeviceInfoServiceClient(GrpcService.Instance.getMyChannel(force));
            var req = new DeviceConfigRequest();
            req.DeviceType = "Q";
            req.Mac = NetHelper.GetMacByNetworkInterface();
            using (var client = aClient.DeviceConfig(req,null,null, cancelTokenSource.Token))
            {
                try
                {
                    while (!token.IsCancellationRequested && await client.ResponseStream.MoveNext())
                    {
                        var result = client.ResponseStream.Current;
                        ///。。。
                    }
                }
                catch (RpcException e)
                {
                    System.Diagnostics.Debug.WriteLine("异常:" + e.Message);
                    if (e.StatusCode==StatusCode.Cancelled)
                    {
                        // 触发取消时, 需要退出否则容易引发异常
                        return;
                    } else
                    {
                        // 其他异常则重连
                        System.Diagnostics.Debug.WriteLine("重连接:" + e.Message);
                        startConfigSubAsync(cancelTokenSource,true);
                    }
                    

                }
                catch  (Exception e)
                {
                    //非RPC异常 则重连接
                    System.Diagnostics.Debug.WriteLine("异常:" + e.Message);
                    startConfigSubAsync(cancelTokenSource, true);
                }
                
            }


            //startConfigSubAsync(cancelTokenSource);


        }

// 程序关闭时需要清理streams连接，否则会抛出异常
private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (isMain)
            {
                cancelTokenSource.Cancel();
                GrpcEnvironment.KillServersAsync();
            }
            

        }

```
