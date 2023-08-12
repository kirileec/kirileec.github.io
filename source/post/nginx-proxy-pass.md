title: nginx proxy pass
date: 2020-04-28 21:28:00 +0800
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
location /admin/ {
    proxy_set_header HOST $host;   
    proxy_set_header X-Real-IP $remote_addr;   
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;   
    proxy_pass http://localhost:9002/admin;
}
```

`location` 表示要匹配的路径, `proxy_pass`则表示需要转发到的目标

前者为匹配规则, 而后者的末尾是否包含 `/`符号, 意味着会不会把匹配到的内容一起带到最终的请求地址里去

- 带 `/`  -> 会去掉匹配的内容 
- 不带 `/` -> 原样拼装
