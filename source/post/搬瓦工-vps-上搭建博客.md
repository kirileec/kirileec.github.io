title: 搬瓦工 VPS 上搭建博客
date: "2015-02-02 16:48:00"
update: ""
author: me
tags:
- vps
categories:
- vps
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



之前,曾使用 Typecho 作为博客程序,但是在搭建过程中遇到了蛋疼的问题,各种500 404 405错误,以及 `pdo` `pdomysql` `pathinfo`的问题, 基本都能解决. 总算安装成功之后, 又是各种点下一页就跳到首页,点链接就跳到首页,多方查询,确认应该是伪静态上的问题,无奈网上全是放个规则你自己抄,妈蛋我个菜鸟硬是不知道应该在 `.htaccess`里边还是在 `/nginx/sites-available/default` 里边,郁闷的.在导入数据库的时候,使用 `phpmyadmin` 导入,不行,经常提示 `duplicate primary key "1" `, 后来换了个远程管理的工具就正常了. 话说, php 程序不能在 mysql 里建个数据库(⊙ ⊙)？,还要亲自动手也是给跪

嫌烦,我就换成 wordpress, 幸好 Typecho 还有人搞了个插件把数据转回 wp, Typecho 简洁是简洁了, 但是......

记录一下:

Ubuntu 12.04.3 LTS \n \l 32位 非 minimal (搬瓦工的系统是不是有问题啊,总是缺这个缺那个的,之前搭 ss 的时候经常 apt-get 不能用,经常 can't locate package XXX)

    apt-get update

    apt-get install mysql-server

中间会提示设置 root 的密码

    mysqladmin -u root password db_user_password

如果用其他方式安装 mysql, 默认的密码用这个设置

测试登陆命令
```bash
    mysql -uroot -p

    create database 数据库名称;

    \q

    apt-get install nginx

    vi /etc/nginx/sites-available/default
```
```nginx
    root /var/www;

    index index.html index.php;  // 添加index.php

    #location ~ \.php$ {

    location ~ .*\.php(\/.*)*$ {    /4  nginx &gt; 0.7 开启pathinfo 的方法

    #       fastcgi_split_path_info ^(.+\.php)(/.+)$;

    #       # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini

    #

    #       # With php5-cgi alone:

    fastcgi_pass 127.0.0.1:9000;   /1

    #       # With php5-fpm:
    #       fastcgi_pass unix:/var/run/php5-fpm.sock;

    fastcgi_index index.php;  /2

    include fastcgi_params;  /3

    }
```
取消 /1/2/3处的注释,启用 php-fpm 的解析功能
```bash
    apt-get install php5

    php5-fpm php5-gd php5-mysql  php5-cli

    vi /var/www/test.php
```
```php
    <?php

    phpinfo();

    ?>
```
    :wq

打开 `ip/test.php`

查看是否有

**curl**

**mbstring**

**iconv**

**pdo**

**pdo_mysql**

**mysqli**

这些模块,PDO必须要有,不然 Typecho 不能选择"数据库适配器",相当于 php 无法连接数据库

但是我安装了 wordpress

```bash
    wget https://wordpress.org/latest.tar.gz
```
下载最新的「英文版」wp，我勒个去，最后还是想换回中文版的，于是
```bash
    tar -zxvf latest.tar.gz

    cd latest

    cp -rf * /var/www

    wget https://cn.wordpress.org/wordpress-4.1-zh_CN.tar.gz
```    
然后，
```bash
    tar -zxvf wordpress-4.1-zh_CN.tar.gz

    cd wordpress-4.1-zh_CN/wp-content

    cp -rf languages /var/www/wp-content
```    
恩，搞定，进仪表盘可以看到新的语言了。官方的那个方法弱

设置全部目录的所有者，可以不用安装 ftp 服务端了，www-data 可以使用 top 命令查看 php5-fpm
```bash
    chown -R www-data /var/www
```
最后，wordpress 赤裸裸地占了
```bash
398 root 20 0 43820 936 232 S 0.0 0.6 0:02.69 php5-fpm
400 www-data 20 0 73268 32m 3124 S 0.0 21.6 0:11.48 php5-fpm
402 www-data 20 0 72040 31m 2912 S 0.0 21.5 0:13.78 php5-fpm
403 www-data 20 0 70488 31m 3048 S 0.0 21.0 0:11.78 php5-fpm
404 www-data 20 0 70748 31m 3020 S 0.0 21.0 0:11.37 php5-fpm
```
而 mysql
```bash
331 mysql     20   0  349m  13m 3424 S  0.0  8.9   0:17.28 mysqld
```
只能说 wp 真是大户啊

---------------------

接上次，后来用1 2天:-( ， 发现实在受不了那么大得内存占用，于是又想换个别的，但是奇怪的是，wordpress 依然正常运行，除了安装插件之类的要等一会之外，其它都还可以

然后又去找博客程序，找半天觉得还是 Typecho 比较合适

 - 简洁，占内存小
 - 我用 github 之类的比较少，不想把博客放在 github 上，虽然说放在那边挺好，还能顺便版本控制，听说图片也可以，不过我的访问速度并不快，git clone 的速度以10k 附近在跑，VPS 上瞬间就 clone 完了。
 - Hexo之前听说过还不错的样子,主要安装挺方便,但是写个博客要输代码(⊙_⊙)？,那真是见鬼,管它是不是逼格很高呢.万一需要 ssh 到 vps 上写的话就恶心了,我VPS丢包率大得很,ssh 输命令都顿卡的

主要原因是找到了那个点击文章链接返回首页的方法, 还真的是伪静态(固定链接)的原因,只要保证, 
> typecho 后台可以直接开启 Rewrite 功能,而不提示任何有关「强制开启 rewrite」的信息。

nginx不管是 typecho还是 wordpress 都需要手动修改配置文件启用伪静态
位置为`/etc/nginx/sites-available/default`

```nginx  
    location / {
        # First attempt to serve request as file, then
        # as directory, then fall back to index.html
        # 原规则
        # try_files $uri $uri/ /index.html;
        # Uncomment to enable naxsi on this location
        # Wordpress  伪静态
        # try_files $uri $uri/ /index.php?q=$uri&$args;
        # Typecho 伪静态
        if (-f $request_filename/index.html){
            rewrite (.*) $1/index.html break;
        }
        if (-f $request_filename/index.php){
            rewrite (.*) $1/index.php;
        }
        if (!-f $request_filename){
            rewrite (.*) /index.php;
        }
        # include /etc/nginx/naxsi.rules
    }
```    
即可
