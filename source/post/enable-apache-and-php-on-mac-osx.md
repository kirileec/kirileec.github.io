title: MAC 下启用 apache 和 php
date: "2015-02-05 15:02:00"
update: ""
author: me
tags:
- mac
categories:
- mac
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



1. 系统偏好设置->共享->互联网共享，勾上
2.  sudo vi  /etc/apache2/httpd.conf， 修改其中的 php 模块加载， 直接 /php5，回车。DocumentRoot 我设置
为/Users/kirile/www, 这样方便在 GUI 下操作文件，还是比较喜欢 GUI 的 vim，看着比较亲切 O(∩_∩)O~，
> Include /private/etc/apache2/extra/httpd-vhosts.conf

这两个参数重合了不知道会咋样，估计前者被覆盖了吧
3. cp /etc/php.ini.default  /etc/php.ini   设置下 display_errors = On  
4. sudo apachectl restart #apache需要root 权限才行
5. 这里涉及的配置文件基本都是 read only，ls 一看只有 r 权限，那么 
> chmod +w 文件名 

添加之，然后 sudo 即可
	
6.  重启 apache 服务，然后新建 phpinfo，测试得，php版本为5.4.30（Mavericks 10.9.5），curl、iconv、
mbstring、mysqli、pdo 都有

7. mysql 的话准备用 homebrew 试试看，网速比较慢
