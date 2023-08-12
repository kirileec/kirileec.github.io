title: Adobe Reader
date: "2012-03-14 15:45:38"
update: ""
author: me
tags:
- windows
categories:
- windows
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



关于Adobe Reader打开文件后,提示"Invalid plugin detected.Adobe Reader will quit",开始以为是某个服务的原因,搜索后,原来是插件的问题.`C:\Program Files\AdobeReader 10.0\Reader\plug_ins`一般在这个目录.如果你装了有道词典或者其他有关的屏幕取词软件的,那么在这个目录下寻找相应的api插件,如有道词典是`YodaoDict.api`,找到这个文件,然后重命名即可(删去或修改其后缀名)
