title: Use Delphinus to Make It Easy to Install Packages
date: 2018-11-09 14:51:34 +0800
update: ""
author: me
tags:
- Delphi
categories:
- Delphi
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


Use Delphinus to Make It Easy to Install Packages
<!--more-->

之前看到 Delphinus 的时候, 因为它需要手动配置一个包的配置文件而望而却步. 直到今天真正使用了一下之后决定, 把自己能改的控件全都加入Delphinus支持

要为一个控件加入Delphinus支持, 需要两个文件 `Delphinus.Info.json` 和 `Delphinus.Install.json` , 一个是包的描述文件, 一个是安装配置文件

 `Delphinus.Info.json` 内容如下:

```json
{
    "picture": "AsyncPro-1.0.png",
    "id": "{5A4907EF-EBB9-452B-8373-D15316D49A71}",
    "name": "AsyncPro",
    "license_type": "Apache 2.0",
    "license_file": "LICENSE",
    "first_version": "",
    "package_compiler_max": "32",
    "package_compiler_min": "23",
    "compiler_min": "23",
    "compiler_max": "32",
    "platforms": "Win32;Win64",
    "report_url": "",
    "dependencies": []
}

```

从上到下依次为, 包的图片\唯一GUID\名称\授权信息\版本号\包最大编译器版本\包最小编译器版本\最小编译器版本\最大编译器版本\支持平台\报告URL\依赖

一般一个独立的包只需要填写 id和name , 其他的信息可以用我这个抄一下, 当然如果一个包里有LICENSE文件, 那么可以用包里自带的. 当然了, 我们自用就随意一点吧

`Delphinus.Install.json` 内容如下:

```json
{
    "search_pathes": [
        {
            "pathes": "source",
            "platforms": "Win32;Win64"
        }
    ],
    "browsing_pathes": [
        {
            "pathes": "source",
            "platforms": "Win32;Win64"
        }
    ],
    "source_folders": [
        {
            "folder": "source"
        },
        {
            "folder": "packages",
            "base": "",
            "recursive": true,
            "filter": "*;*.*"
        }
    ],
    "projects": [
        {
            "project": "Packages\\Delphi\\Delphi.groupproj"
        }
    ]
}
```

`search_pathes` 下定义搜索路径, `browsing_pathes` 下定义浏览路径, 这两个路径都是跟系统平台相关的

`source_folders` 源码路径, 一般如果代码整理一下的话, 最终只会有源码文件夹和包工程文件夹

`"recursive": true` 注意这个需要有

`projects` 指定工程组的位置
