title: Install nginx mysql php
date: "2016-11-18 21:06:00"
update: ""
author: me
tags:
- Linux
categories:
- Linux
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



##nginx
```bash
apt-get install nginx
```

##mysql
```bash
apt-get install mysql-server-5.5 mysql-client-5.5
```
if error like `logger:command not found`
try this
```bash
apt-get --yes autoremove --purge mysql-server-5.5
apt-get --yes autoremove --purge mysql-client-5.5
apt-get --yes autoremove --purge mysql-common
rm -rf /var/lib/mysql /etc/mysql ~/.mysql
deluser mysql
apt-get autoclean
apt-get update && sudo apt-get upgrade
apt-get install mysql-server-5.5 mysql-client-5.5
dpkg --configure -a
apt-get --reinstall install bsdutils  ##maybe the most important line

apt-get install mysql-server-5.5 mysql-client-5.5
```
### import data
```bash
mysql -uroot -p

create database typecho;
use typecho;

source /path/to/sqlfile;
```

## PHP
```bash
apt-get install php5 php5-fpm
apt-get install php5-mysql
```

## nginx conf file
```bash
cd /etc/nginx
vi typecho.conf
```
```nginx
if (!-e $request_filename) {
        rewrite ^(.*)$ /index.php$1 last;
    }
```
```bash
vi enable-php-pathinfo.conf
```
```nginx
location ~ [^/]\.php(/|$)
        {
            fastcgi_pass  unix:/tmp/php-cgi.sock;
            fastcgi_index index.php;
            include fastcgi.conf;
            include pathinfo.conf;
        }
```
```bash
vi fastcgi_param
```
```nginx
fastcgi_param   QUERY_STRING            $query_string;
fastcgi_param   REQUEST_METHOD          $request_method;
fastcgi_param   CONTENT_TYPE            $content_type;
fastcgi_param   CONTENT_LENGTH          $content_length;

fastcgi_param   SCRIPT_FILENAME         $request_filename;
fastcgi_param   SCRIPT_NAME             $fastcgi_script_name;
fastcgi_param   REQUEST_URI             $request_uri;
fastcgi_param   DOCUMENT_URI            $document_uri;
fastcgi_param   DOCUMENT_ROOT           $document_root;
fastcgi_param   SERVER_PROTOCOL         $server_protocol;

fastcgi_param   GATEWAY_INTERFACE       CGI/1.1;
fastcgi_param   SERVER_SOFTWARE         nginx/$nginx_version;

fastcgi_param   REMOTE_ADDR             $remote_addr;
fastcgi_param   REMOTE_PORT             $remote_port;
fastcgi_param   SERVER_ADDR             $server_addr;
fastcgi_param   SERVER_PORT             $server_port;
fastcgi_param   SERVER_NAME             $server_name;

fastcgi_param   HTTPS                   $https if_not_empty;
# PHP only, required if PHP was built with --enable-force-cgi-redirect
fastcgi_param   REDIRECT_STATUS         200;
```
```bash
cd sites-available
vi default
```
```nginx
server {
        listen 80 default_server;
        listen [::]:80 default_server ipv6only=on;
        root /path/to/htmlroot;
        server_name loclahost;
        #return 301 https://$server_name$request_uri;
        include typecho.conf;
        location / {
           index  index.html index.htm index.php l.php;
           autoindex  off;
       }
       location ~ \.php(.*)$  {
            fastcgi_pass unix:/var/run/php5-fpm.sock;
            fastcgi_index  index.php;
            fastcgi_split_path_info  ^((?U).+\.php)(/?.+)$;
            fastcgi_param  SCRIPT_FILENAME  $document_root$fastcgi_script_name;
            fastcgi_param  PATH_INFO  $fastcgi_path_info;
            fastcgi_param  PATH_TRANSLATED  $document_root$fastcgi_path_info;
            include        fastcgi_params;
        }
}
```
```bash
/etc/init.d/nginx configtest
/etc/init.d/nginx restart
```
