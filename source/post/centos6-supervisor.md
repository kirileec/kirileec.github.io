title: Centos6 Supervisor
date: 2019-07-18 17:03:40 +0800
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


Centos6 Supervisor
<!--more-->
centos6 不能使用systemd进行守护，使用supervisor

# 首先需要升级python到2.7版本
> 参考 https://www.cnblogs.com/gjc592/p/9223005.html

## 安装2.7 python
```bash
yum install gcc -y
wget https://www.python.org/ftp/python/2.7.16/Python-2.7.16.tgz
tar -zxvf  Python-2.7.16.tgz
cd Python-2.7.16
./configure --prefix=/usr/local/python2.7
make && make install
```

## 检测下
```bash
cd /usr/local/python2.7/bin
ll
whereis python
```

## 创建新的文件链接
```bash
cd /usr/bin
ll *python*
unlink python
unlink python2
ll *python*
cp /usr/local/python2.7/bin/python2.7 /usr/bin/python2.7  #注意路径
ln -s /usr/bin/python2.7  python　　　　　　
ln -s python  python2
ll *python*   
python               #可以看到提示的Python2.7.15,证明安装成功，但是还没有彻底结束
```

## 修改yum启动路径
```bash
vim /usr/bin/yum　#将头部#!/usr/bin/python 修改为 #!/usr/bin/python2.6
yum install gcc -y #测试一下
```

# 然后安装supervisor

supervisor在centos6上需要python2.7，同时需要pip来安装, 在上面升级了python之后，应该是需要重新安装pip和setup_tool的， 安装过程略

## pip==9.0.1 错误
先
```bash
easy_install pip==9.0.1
```
如果 `pkg_resources.DistributionNotFound: distribute==0.6.10`
则 安装 distribute-0.6.10
```bash
wget http://pypi.python.org/packages/source/d/distribute/distribute-0.6.10.tar.gz
cd distribute-0.6.10
python setup.py install
```
再安装一次
```bash
easy_install pip==9.0.1
```

最后 pip 确保可以正常输出


## 安装supervisor
```bash
easy_install supervisor
```

测试一下这个
```bash
python
python>>> import supervisor
```

执行生成配置
```bash
echo_supervisord_conf > /etc/supervisord.conf
```

配置文件里
```conf
[supervisord]
logfile=/var/log/supervisord.log ; main log file; default $CWD/supervisord.log

[include]
files = supervisord.d/*.ini
```

如果不增加其他配置文件 include也可以不管， 直接在supervisord.conf里加也是可以的


配置范例如下:
```conf
[program:golang-http-server]
command=/home/golang/simple_http_server
directory=/home/golang/
autostart=true
autorestart=true
startsecs=10
stdout_logfile=/var/log/simple_http_server.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
stdout_capture_maxbytes=1MB
stderr_logfile=/var/log/simple_http_server.log
stderr_logfile_maxbytes=1MB
stderr_logfile_backups=10
stderr_capture_maxbytes=1MB


[program:jingkongapp]
command = /data/www/group/app/jingkongapp 
autostart = true
autorestart = true
directory=/data/www/group/app/
user = root
redirect_stderr=true 
stdout_logfile=/data/www/group/app/log.txt 
stderr_logfile=/data/www/group/app/log_err.txt
```
注意directory 和 stdout_logfile redirect_stderr 要设置起来， 否则可能会运行后直接退出，启动的时候 ERROR (spawn error)错误
同时需要保证对应的服务端口没有被占用, 总之不能有阻碍程序运行的因素存在， 最好程序中尽量不使用相对路径


# 最后

```bash
supervisorctl status # 查看状态
supervisorctl stop all #停止所有
supervisorctl start all #启动所有
supervisorctl tail appname #模拟启动
supervisorctl reload #重新加载配置
```
