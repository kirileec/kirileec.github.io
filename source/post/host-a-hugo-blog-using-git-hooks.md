title: 使用git钩子在VPS架设hugo博客
date: 2017-04-23 20:44:51 +0800
update: ""
author: me
tags:
- 博客
- hugo
- git
- hooks
- blog
categories:
- blog
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



首先第一步， 当然是先在本地搭建好hugo

## 配置nginx

```nginx
server {
        listen 443 ssl default_server;
        listen [::]:443 ssl default_server;
        root /var/www;
        ssl on;
        ssl_certificate /etc/ssl/certs/llinx.me.pem;
        ssl_certificate_key /etc/ssl/private/llinx.me.key;
        ssl_dhparam /etc/ssl/certs/dhparam.pem;
        index index.html index.htm index.nginx-debian.html;

        server_name llinx.me;

        location / {
                try_files $uri $uri/ =404;
        }
}

server {
        listen 80;
        server_name llinx.me;
        rewrite ^(.*) https://$server_name$1 permanent;
}
```
```bash
service nginx restart
```

## 配置HTTPS

> https://llinx.me/post/automatic-issuance-and-renewal-of-acmesh-using-ssl/

## 配置git
```bash
apt install git -y
cd ~
mkdir llinx.me.git
cd llinx.me.git
git init --bare
cd hooks
touch post-receive
vi post-receive
```
使用以下脚本

```sh
#!/bin/sh 
GIT_REPO=/root/llinx.me.git
TMP_GIT_CLONE=/tmp/blog
NGINX_HTML=/var/www
rm -rf ${TMP_GIT_CLONE}
git clone $GIT_REPO $TMP_GIT_CLONE
rm -rf ${NGINX_HTML}/*
cp -rf ${TMP_GIT_CLONE}/* ${NGINX_HTML}
```
:wq

```bash
chmod +x post-receive
```
## 设置本地git(Source Tree)

- 创建新仓库
- 目录选择hugo的public目录， 名称修改为自己的域名
- 生成SSH-KEY 
  
  ```bash
    ssh-keygen -t rsa -C "A@B.COM"
  ```


## 配置SSH

```bash
cd ~
mkdir .ssh
vi ~/.ssh/authorized_keys 
```

设置权限
```bash
chmod 600 authorized_keys 
chmod 700 -R .ssh  
```

## 测试ssh连接

```bash
ssh root@IP -p PORT
```
如果无需密码登陆那么进行下一步

Source Tree 添加远端为
```
ssh://root@IP:PORT/root/llinx.me.git
```
选项中设置密钥为id_rsa (私钥)

## 修改hugo设置并推送
主要是`baseurl`，因为一般在本地使用的时候也不会去搞https的

## 存放其他文件
为保证其他文件不丢失，那么可以把public加入忽略，然后把整个博客目录推送到github上或者其他代码托管服务上
