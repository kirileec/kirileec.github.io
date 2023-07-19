title: something about nginx
date: 2020-09-21 09:28:27 +0800
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



## centos nginx install

```shell
sudo yum install yum-utils -y
vim /etc/yum.repos.d/nginx.repo

[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
module_hotfixes=true

sudo yum-config-manager --enable nginx-mainline

sudo yum install nginx -y
```

## https -> https

```nginx
proxy_set_header Host example.com;
proxy_ssl_name        example.com;
proxy_pass            https://1.2.3.4;
```

## add query param

```nginx
location  /XX/XX {     
    set $args "$args&a1=xxx&a2=xxx";      
    proxy_ pass  http://ip:port/xxxx;  
}
```

## .Net Core 

```nginx
location / {
    proxy_pass http://localhost:5000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection keep-alive;
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
}
```

## optimization

```nginx
# 线程优化

worker_processes  1;  # 根据cpu核数调整
worker_rlimit_nofile 65535;
events {
    use epoll;  # linux 才能用
    worker_connections  65535;
    multi_accept on;
}

# 一般优化
tcp_nopush     on;

keepalive_timeout  60;
tcp_nodelay on;
client_header_buffer_size 4k;
open_file_cache max=102400 inactive=20s;
open_file_cache_valid 30s;
open_file_cache_min_uses 1;
client_header_timeout 15;
client_body_timeout 15;
reset_timedout_connection on;
send_timeout 15;
server_tokens off;
client_max_body_size 10m;

# gzip
gzip on;
gzip_disable "msie6"; 
gzip_vary on; 
gzip_proxied any;
gzip_comp_level 8; #压缩级别
gzip_buffers 16 8k;
#gzip_http_version 1.1;
gzip_min_length 100; #不压缩临界值
gzip_types text/plain application/javascript application/x-javascript text/css application/xml text/javascript application/x-httpd-php image/jpeg image/gif image/png;


# 指定文件类型进行缓存
location ~* \.(ico|jpe?g|gif|png|bmp|swf|flv)$ {
    expires 30d;
    #log_not_found off;
    access_log off;
}

location ~* \.(js|css)$ {
    expires 7d;
    log_not_found off;
    access_log off;
}
```

其中, gzip和缓存可以放到 server下, 设置某一个网站生效
