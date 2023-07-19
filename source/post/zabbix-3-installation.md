title: Zabbix 3 安装
date: "2016-03-13 12:39:00"
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



**引用**
> https://www.zabbix.com/documentation/3.0/manual/installation/install_from_packages
> http://www.zabbix.net.cn/viewtopic.php?f=13&t=1096&sid=c7083137d85cde63fad7c2430cfdee08

```bash
sudo su
apt-get install gettext
apt-get install unzip
apt-get install rar
```

## Zabbix 3.0 for Ubuntu 14.04 LTS:

```bash
wget http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1+trusty_all.deb
dpkg -i zabbix-release_3.0-1+trusty_all.deb
apt-get update
```
**Installing Zabbix packages**
安装zabbix包

**Example for Zabbix server and web frontend with mysql database.**
安装zabbix的php前端和mysql服务器，中间会提示配置mysql的用户信息，本文以  `root:root` 为例
```bash
apt-get install zabbix-server-mysql zabbix-frontend-php
```
**Example for installing Zabbix agent only.**
安装zabbix客户端（本地也作为一个客户端）
```bash
apt-get install zabbix-agent
```
**Creating initial database**

**Create zabbix database and user on MySQL. For instructions on doing that, see database creation scripts for MySQL.**
在mysql里创建一个zabbix的数据库 
```bash
mysql -uroot -proot
```

**Then import initial schema and data.**
创建表结构
```bash
cd /usr/share/doc/zabbix-server-mysql
zcat create.sql.gz | mysql -uroot -proot zabbix
```

**Edit database configuration in `zabbix_server.conf`**
配置数据库信息
```bash
vi /etc/zabbix/zabbix_server.conf
```
```ini
DBHost=localhost
DBName=zabbix
DBUser=root
DBPassword=root
```

启动服务器
```bash
service zabbix-server start
```
**Editing PHP configuration for Zabbix frontend**

Apache configuration file for Zabbix frontend is located in `/etc/apache2/conf.d/zabbix` or `/etc/apache2/conf-enabled/zabbix.conf`. Some PHP settings are already configured.
配置zabbix专用的配置文件里php部分，修改时区
```nginx
php_value max_execution_time 300
php_value memory_limit 128M
php_value post_max_size 16M
php_value upload_max_filesize 2M
php_value max_input_time 300
php_value always_populate_raw_post_data -1
# php_value date.timezone Europe/Riga
```
最后一行，去掉＃号，时区改成 Asia/Shanghai
```bash
service apache2 restart
```

然后浏览器登录：
```
http://YOURIP/zabbix
```
数据库帐号是root，密码是你设置的密码：root
一路安装。。。web登录帐号是Admin／zabbix，基本ok！

汉化
```bash
vi cd/usr/share/zabbix/include/locales.inc.php
```
把zh_CN后面参数写true
```bash
apt-get install language-pack-zh-hant language-pack-zh-hans
sudo vim /etc/environment
```

在文件中增加语言和编码的设置：
```ini
LANG="zh_CN.UTF-8"
LANGUAGE="zh_CN:zh:en_US:en"
```
重新设置本地配置：
```bash
sudo dpkg-reconfigure localessudo dpkg-reconfigure locales
```
```bash
cd /usr/share/zabbix/locale/zh_CN/LC_MESSAGES
wget https://github.com/echohn/zabbix-zh_CN/archive/master.zip
unzip master.zip
```

用包里的文件替换里面的文件
安装字体
```bash
wget http://dx.sc.chinaz.com/Files/DownLoad/font2/dd.rar
rar x dd.rar
```
把解压缩出来的msyh.ttf放到/usr/share/zabbix/fonts目录下面
然后修改/usr/share/zabbix/include/defines.inc.php 
找到
```php
define('ZBX_GRAPH_FONT_NAME', 'graphfont'); // font file name
```
修改成：
```php
define('ZBX_GRAPH_FONT_NAME', 'msyh'); // font file name
```
```bash
service zabbix-server restart
```

一些提示 tips

重新启动zabbix－server服务进程
```bash
service zabbix-server restart
service zabbix-server restart
```
重启apache进程
```bash
service apache2 restart
```
