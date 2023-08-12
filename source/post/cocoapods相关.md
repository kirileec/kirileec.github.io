title: cocoapods相关
date: "2015-06-19 10:50:00"
update: ""
author: me
tags:
- mac
- xcode
- mxac
categories:
- mxac
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: ""
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



 - cocoapods是XCODE开发时使用的第三方库管理工具


----------

## 安装

    brew cask install cocoapods
    或
    sudo gem install cocoapods
    //前者的版本会比后者低一点

    pod repo remove master
    pod repo add master http://git.oschina.net/akuandev/Specs.git
    pod repo update
    //这是官方自己的specs库，如果网络连github的速度还可以的化可以用这个 https://github.com/CocoaPods/Specs.git

## 使用

  1.  `pod setup`  第一次使用执行一次，看网络速度
  2.  终端，`cd`到项目目录下，`vi Podfile`
> Podfile 格式
> 第一行 `platform :ios, '8.2'`
> 第二行 `inhibit_all_warnings!`
> pdo ‘库名’,库信息
> > `pod 'AFNetworking','~> 2.2.0'` 版本号
> > `pod 'AFNetworking',:path => '库的目录'` 本地库
> > `pod 'AFNetworking',:git => 'https://github.com/gowalla/AFNetworking.git'` github上的库
> 详情看这里 [Podfile][1]
 3. `pod install --no-repo-update` 不加`--no-repo-update`参数则会检查repo的更新，如果网卡了，那么就是找死，没事不用更新，除非你要的库更新的版本当前repo里没有
 4. 最后载入生成的 `.xcworkspace` 文件即可

  [1]: https://guides.cocoapods.org/using/the-podfile.html
