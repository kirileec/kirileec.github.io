title: Blog Add Ipv6 Support
date: 2019-06-04 10:48:32 +0800
update: ""
author: linx
tags:
- nginx
categories:
- nginx
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



- DNS add AAAA record
- nginx config
  
  ```nginx
  server {
      listen [::]:443 ssl;
      server_name ipv6.llinx.me;
  }

  ```


- ```bash
  nginx -s stop
  nginx
  ```
