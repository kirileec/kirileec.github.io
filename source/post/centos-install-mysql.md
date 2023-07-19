title: centos install mysql
date: 2020-09-21 09:27:01 +0800
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



```shell
yum list installed mysql*
rpm –qa|grep mysql*
yum list mysql*

yum install mysql
sudo rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
yum repolist enabled | grep mysql.*

yum install mysql-community-server

systemctl start  mysqld
grep "password" /var/log/mysqld.log
mysql -uroot -p

set password for root@localhost = password('password'); 
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
```
