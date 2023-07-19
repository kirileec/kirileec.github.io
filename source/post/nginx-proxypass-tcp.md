title: nginx proxypass tcp
date: 2020-06-17 21:58:40 +0800
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



```nginx
stream {
    upstream redis {
        server 127.0.0.1:6379 max_fails=3 fail_timeout=30s; 
    }
    server {
        listen 6379;
        proxy_connect_timeout 1s;
        proxy_timeout 3s;
        proxy_pass redis;
    }
}
```

放到 http { } 的前面
