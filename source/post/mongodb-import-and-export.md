title: mongodb import and export
date: 2023-06-16 14:29:25 +0800
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



## 使用mongodump和mongorestore进行备份和还原
1. 安装MongoDB Community, 注意如果不是windows 10以上需要使用 4.2.24版本
2. 安装Navicat, 可以方便调用mongodump这些可执行程序
3. 安装[mongo database tools](https://www.mongodb.com/try/download/database-tools). 4.2.24版本在安装目录的bin文件夹已经带有mongodump. 记得选择msi的安装方式, 省事儿
4. 打开Navicat, 在集合处右键选择`MongoDump...`或`MongoRestore...`进行备份还原

PS: 之前使用导出json的方式来进行, 后面发现会丢失meta信息. 某些字段在导入之后会变成不一样的字段. 例如:

```
{
    "_id":"xxxxx",
    "data": [
        {
            "timeStamp": 1423122333
        }
    ]

}
```
会变成

```
{
    "_id":"xxxxx",
    "data": [
        {
            "timeStamp": {
                "$numberLong":"1423122333"
            }
        }
    ]

}
```
这样会导致如果使用某些框架进行反序列化的时候会出现问题
