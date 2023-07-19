title: Centos Install Nginx Mainline Version and Configure Https
date: 2019-08-14 12:52:50 +0800
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


CentOS 7 安装nginx(非编译安装)
<!--more-->

> http://nginx.org/en/linux_packages.html#RHEL-CentOS

```bash
yum install sudo
sudo yum install yum-utils
vim /etc/yum.repos.d/nginx.repo

```

```config
[nginx-stable]
name=nginx stable repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=1
enabled=1
gpgkey=https://nginx.org/keys/nginx_signing.key

[nginx-mainline]
name=nginx mainline repo
baseurl=http://nginx.org/packages/mainline/centos/$releasever/$basearch/
gpgcheck=1
enabled=0
gpgkey=https://nginx.org/keys/nginx_signing.key
```

```
sudo yum-config-manager --enable nginx-mainline
sudo yum install nginx
vim /etc/nginx/conf.d/default.conf
```

```nginx
server {
    listen  80;
    server_name llinx.me;
    rewrite ^(.*)$  https://$host$1 permanent;
}

server {
    listen 443 ssl;
    server_name llinx.me;

    ssl_certificate /etc/ssl/llinx.me.cer;
    ssl_certificate_key /etc/ssl/llinx.me.key;
    ssl_session_timeout 5m;
    ssl_protocols SSLv2 SSLv3 TLSv1;
    ssl_ciphers ALL:!ADH:!EXPORT56:RC4+RSA:+HIGH:+MEDIUM:+LOW:+SSLv2:+EXP;
    ssl_prefer_server_ciphers on;
    location / {
        root /var/www;
        index index.html index.htm;
    }

}
```

PS: `ssl_certificate_key` 这玩意拼写不要错了, 我也不知道从哪找了一个, 导致 `nginx -t` 的时候一直提示 `ssl_certficate_key` ( <= 这个是错误的, 少了个`i`) , 但是对着看半天也没看出啥问题 `nginx -V` 也有https模块的
