title: 阿里mPaas Inside 接入H5 (Android)
date: 2020-06-23 19:50:09 +0800
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



## 准备

- 先搞定账号, 开通服务什么的
- 创建应用
- 创建完后, 点进去, 到 `初始化配置`->`代码配置`, 检查一下包名, 点击 `下载配置`, 得到一个config文件

## 创建工程

- 根据 `https://help.aliyun.com/document_detail/155844.html?spm=a2c4g.11186623.6.620.7c66569eYaSB82`安装插件, 目前该插件已经支持Android Studio 4.0

- 预先准备好一个jks签名文件和你要开发的app的包名, 根据`https://help.aliyun.com/document_detail/112551.html?spm=a2c4g.11186623.6.1277.f5754728oUkDSw`去申请UC SDK 的KEY

- 在AS中, `File`->`New`->`Start a New mPaas Project`, 选择Inside工程即可, H5够用了

  ![](/images/Snipaste_2020-06-23_09-04-23.png)

- 接下来一个页面, 在Windows上乱码,  从上到下分别是

![](/images/Snipaste_2020-06-23_09-05-39.png)

- 组件的话看着选, 一般日志啥的现在不选以后也要选上的, 全选上也问题不大就是apk体积会比较大

- 创建完工程之后, 先做这么几件事, 否则**掉坑里都不知道哪里踩空了**
  - 我创建完工程默认啥都没有, 所以先创建 MyApplication 和 MainActivity (记得勾选 Launcher Activity, 好久没建工程还以为那个 intent-filter 都是自己手动加的 😓)
  - `android:theme="@style/Theme.AppCompat.Light"` 给AndroidManifest.xml 加个这玩意, 尼玛没有的时候启动app就崩溃, 然后报错信息要翻好几遍日志才能看到, 真是😅
  - 同理 `android:name=".MyApplication"`这个也改了

## 准备离线包

- 到mPaas控制台的应用管理页面, 点应用下方的🚀,  然后选择离线包管理, 新建一个离线包(差不多就是app名称的意思)

- **H5App ID** 随便填8位数字, 测试的时候随便填, 正式用的时候还是要简单管理下, 不然每次都要到控制台找, 多麻烦

- 添加离线包, 主要是离线包打包问题, 按这个顺序

  - 找个目录创建以**H5App ID**为名的文件夹, 例如 `19981998`

  - 进到该目录创建 `www`目录
  - `www`目录里面放入你真实的打包的H5文件(`index.html`)
  - windows上直接右键`19981998`这个目录, `发送到`-`Zip压缩文件`
  - 保证双击zip文件看到的目录结构第一层是这个`19981998`就行了
  - ok 上传上去

- 主入口 `/www/index.html`, 勾上 `已确认以上信息准确，提交后不再修改`, 提交

- 下载AMR和配置文件, 一个是 `19981998_0.0.0.2.amr` id+版本号.amr的压缩包, 另一个是h5_json.json

![](/images/Snipaste_2020-06-23_09-30-45.png)

- AS选择Project, 然后在main下创建assets目录, 把俩文件丢进去

  ![](/images/image-20200623093452742.png)

## 写代码

#### MyApplication重载onCreate

```java
@Override
public void onCreate() {
    super.onCreate();
    QuinoxlessFramework.init();
}
```

#### 重载attachBaseContext

```java
@Override
protected void attachBaseContext(Context base) {
    super.attachBaseContext(base);

    QuinoxlessFramework.setup(this, new IInitCallback() {
        @Override
        public void onPostInit() {
            // 在这里开始使用mPaaS功能
            loadOfflineNebula();
        }
    });
}
private void loadOfflineNebula() {
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 此方法为阻塞调用，请不要在主线程上调用内置离线包方法。如果内置多个amr包，要确保文件已存在，如不存在，会造成其他内置离线包失败。
                // 此方法仅能调用一次，多次调用仅第一次调用有效。
                MPNebula.loadOfflineNebula("h5_json.json", new MPNebulaOfflineInfo("19981998_0.0.0.2.amr", "19981998", "0.0.0.2"));
            }
        }).start();
    }
```

#### MainActivity里搞个按钮

```java
findViewById(R.id.start_url_btn).setOnClickListener(new View.OnClickListener(){
    @Override
    public void onClick(View v) {
        MPNebula.startApp("19981998");
    }
});
```

#### AndroidManifest.xml加上UC SDK的AppKey

```xml
<meta-data
            android:name="UCSDKAppKey"
            android:value="***" />
```

#### 兼容Android 9 + 

`res/xml` 下创建 `network_security_config.xml`, 内容为

```xml
<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config cleartextTrafficPermitted="true">
        <trust-anchors>
            <certificates src="system" />
        </trust-anchors>
    </base-config>
</network-security-config>
```

`AndroidManifest.xml`  `<application>`下加上 `android:networkSecurityConfig="@xml/network_security_config"`

#### 离线包自动更新

`MainActivity`

```java
Toast.makeText(MainActivity.this, "检查应用更新", Toast.LENGTH_SHORT).show();
        MPNebula.updateAllApp(new MpaasNebulaUpdateCallback() {
            @Override
            public void onResult(final boolean success, boolean isLimit) {
                runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        MPNebula.setCustomViewProvider(new H5ViewProviderImpl());
                        if (success) {
                            Toast.makeText(MainActivity.this, "应用更新完成即将打开", Toast.LENGTH_SHORT).show();
                            MPNebula.startApp("19981998");
                        } else {
                            MPNebula.startApp("19981998");
                        }

                    }
                });
            }
        }, true);
```

#### 离线包不能检查到更新的问题解决

-  https://help.aliyun.com/document_detail/159033.html?spm=a2c4 根据该链接进行Charles抓包 https://charles.ren, 主要检查请求体中是否有nebula-*-all, 如果有, 并且没有Response进行下一步
- defaultConfig 下增加 abiFilters 'armeabi' 过滤so
- 客户端版本号和离线包版本号都改成1.0.0.* 这样的版本号
- 回忆一下, 当初在控制台的代码配置处下载配置的时候, 有没有上传APK文件, 参考 https://help.aliyun.com/document_detail/164968.html?spm=a2c4g.11186623.6.566.22813e52mE41Ph, 每次下载都要上传apk, 因为每次都会被清理掉. 如果没上传, 那么下载下来的配置文件中 base64Code 为空, 将导致检查更新时鉴权不通过
