title: 技能树
date: 2017-05-24 22:37:27
update: ""
author: me
tags:
- x
- "y"
categories:
- "y"
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: page
hide: false
toc: false
image: ""
subtitle: ""
lastmod: ""
hidden: true
config: {}


---



- 易语言

    - 曾被其表格式的函数声明方式所吸引（才不是因为中文编程呢）
    - 当然如果这个世界上能出现一种真正不用切换的中文输入法的话那就美了
    - 不过现在基本不会写了

- Delphi

    - 虽然前途未知，资料匮乏
    - Windows下依然最强，界面美观的代价必然是exe越来越大
    - 对各种硬件设备的二次开发最让人开心了
    - 没有多少语法糖，但每一个新特性都能让人兴奋
    - DataSnap又爱又恨，特别是Indy控件
    - 还是经常掉入多线程的坑中无法自拔
    - OminiThreadLibrary
    - 自制http库，封装RESTClient
    - 有文档就没有什么难的
    - 正在学习并使用 [mORMot](https://github.com/synopse/mORMot), Delphi上的高性能Rest服务不再是梦, 然而这个框架内容非常之多
    - update:2019 我准备远离它了

- C# WPF Prism UnityContainer

    - MVVM做界面，双向绑定，爽 (PS: 屁嘞, 搞那么多层干啥)
    - AutoMapper
    - AOP暂时还没有找到个让人感觉特爽的框架
    - 当然这货依赖环境比较恶心
    - update:2019 .NET Core也不麻烦嘛
    - update:2023 准备个好用的框架很重要, 哪里需要改, 一下就找到了. 搞什么接口啦实现啦, 烦 

- golang

    - 使用beego开发WebAPI挺不错，不过有些东西还是需要自己封装一下
    - 虽说gc，但是有些东西还是要及时释放的，比如从连接池里拿出来的连接
    - 基于mongodb和RabbitMQ的中心服务器状态收集系统, 这里遇到的坑就是RabbitMQ上的消息没有设置有效时间, 导致消息堆积, 服务死掉
    - 把做的中心服务器删掉一些东西封装成了一个seed项目 (https://github.com/kirileec/beego-mgo-rabbitmq-jwt)
    - 后来发现gin这个框架更牛, 于是准备搞一个gin版的seed项目 
    - update:2019 好想有泛型功能啊, 2.0啥时候出啊
    - update:2019 一个多月没碰, 语法都快忘了, 补上补上
    - update:2023 泛型虽然出了, 但......
    - update:写api是真不爽, 啥都要自己写, 拼啊拼, 搁这拼图呢

- docker
    - 玩得贼拉溜(doge), 能找个封装完整的镜像得是多么美的一件事啊
    - 懒得敲命令, 人生苦短我用portainer
    - docker-compose挺好, 但每次都忘了docker-compose.yaml的文件开头咋写, 里面有啥属性

- k8s
    - 也就玩玩kuboard之类的, yaml工程师? 那不可能的
    - 这玩意没有足够的资源玩不起来啊, 想像docker那样挂载个目录进去挺麻烦的, 都用configmap太傻了

- python

    - 也尝试过写个爬虫， 不过总是没跑几下就停了

- java

    - 对那些繁杂的配置望而却步
    - 该死的内存占用
    - 写过一段时间的crub
    - 看得懂代码, 也改得了, 安卓组件一顿魔改
    - update: xml写界面yyds, 谁设计的用代码写界面

- ionic2

    - 一个调用go后端http服务的app
    - 花的最多的时间估计就在本地存储上面, 读取个值还要考虑是不是null是不是空, 又不会封装库::-_<::

- linux

    - 最初被安利ubuntu，在ubuntu论坛上逛过一段时间，主要是各种问题想办法搜索解决
    - 目前还停留在出现问题，就从报错信息中提取关键字，然后Google之，搜不到我就不行了
    - 在gnome年代也玩过几次界面特效啥的，模拟MAC界面之类的
    - 由于目前还没有必须要在linux下进行开发，停滞不前中
    - 会简单的docker使用
    - update:2019-12-31 尝试在老笔记本上装上了manjaro, 打算用linux当作主系统, 然而天不遂人愿, 笔记本挂了
    - update:2023 额, 最近老喜欢玩虚拟机了

- Jenkins

    - 现有的项目是一个版本一个分支的, 而且是一个客户一个库
    - 完全从头开始搭建了一个Delphi的编译发布流程
    - 实现推送代码就可以得到对应版本的程序, 并发布到更新服务器, 最后通过钉钉的消息通知告知构建结果
    - 这完全改变了之前的安装包的发布流程

- vim
    - 改配置用
    - update: 这玩意不用它编程或码字, 根本不需要学那么多命令

- android 开发
  
    - 目前正在进行, 从零开始用kotlin构建完整的校徽app, 目前已完成第一期的需求
    - update: 你以为难的是写代码, 其实难的是上架
