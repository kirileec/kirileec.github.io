title: 使用acme.sh自动签发和续期ssl
date: "2017-02-18 11:41:00"
update: ""
author: me
tags:
- linux
- acme.sh
- ssl
categories:
- linux
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



```bash
git clone https://github.com/Neilpang/acme.sh.git
cd ./acme.sh
./acme.sh --install
```
重新连接ssh

```bash
acme.sh --issue -d llinx.me -w /var/www
```
```bash
acme.sh --installcert -d llinx.me \
               --keypath       /etc/ssl/private/llinx.me.key  \
               --fullchainpath /etc/ssl/certs/llinx.me.pem \
               --reloadcmd     "service nginx force-reload"
```
```bash
openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```
```nginx
ssl_certificate /etc/ssl/certs/llinx.me.pem;
ssl_certificate_key /etc/ssl/private/llinx.me.key;
ssl_dhparam /etc/ssl/certs/dhparam.pem;
```
```bash
service nginx restart
```
