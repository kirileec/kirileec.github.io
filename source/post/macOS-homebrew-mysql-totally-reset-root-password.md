title: macOS homebrew mysql totally reset root password
date: 2020-08-17 22:31:44 +0800
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



当我安装完执行 `mysql_secure_installation` 想要设置一个密码的时候, 提示我

```sh
Error: Access denied for user 'root'@'localhost' (using password: YES)
```
这就尼玛离谱了, 还好找到了一个破罐子破摔的方法

```sh
brew services stop mysql
pkill mysqld
rm -rf /usr/local/var/mysql/ # NOTE: this will delete your existing database!!!
brew postinstall mysql
brew services restart mysql
mysql -uroot

ALTER USER 'root'@'localhost' IDENTIFIED BY '新密码';
exit
```
