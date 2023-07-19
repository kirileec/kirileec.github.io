title: Apache ab test tool
date: 2019-08-14 17:30:39 +0800
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



最简单的发起POST请求
```
ab -n 10000 -c 10 -T 'application/json' -p body.txt  http://ip:port/api/post
```

`ab -n 总请求次数 -c 模拟用户数(线程数) -T 'application/json' -p body.txt  POST的地址`

body.txt 里写入body json的内容

要格外注意的是  `-T` 必须要在 `-p` 之前, 否则后端将无法取得正确的`Content-Type`
