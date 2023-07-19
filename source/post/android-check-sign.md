title: Android Check Sign
date: 2020-04-21 09:09:28 +0800
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


安卓签名查看
<!--more-->

添加 %JAVA_HOME%\bin到PATH

## 查看apk签名

```
keytool -list -printcert -jarfile /path/to/apk
```

## 查看keystore签名

```
keytool -list -v -keystore /path/to/keystore
```

## Android Studio 使用本项目下的keystore打包

```
signingConfigs {
    debug {
        storeFile file(rootProject.getRootDir().getAbsolutePath()+"/debug.keystore");
    }
}
```

## 对比两个包名一样的apk但签名是否一致

**安装其中一个然后安装另外一个**
