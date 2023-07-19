title: Deploy Your Own Goproxy With Access to Private Server
date: 2019-08-28 21:15:43 +0800
update: ""
author: linx
tags:
- goproxy
- go
categories:
- go
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


部署自己的可以访问私有仓库的goproxy服务
<!--more-->

# 准备工作

- 一台服务器， 可以选择国内或者国外， 区别后面说
- 域名和https证书， 方便记忆和设置
- 安装并设置好golang的环境，例如安装到`/usr/local/go` `GOPATH` 在`/usr/local/gopath`
- nginx

# 安装goproxy

以下方法均可

- `go get -u -v github.com/goproxyio/goproxy` 
- `git clone https://github.com/goproxyio/goproxy.git`

----

这里简要略过

- `cd $GOPATH/src/github.com/goproxyio/goproxy`
- `go build`

# 配置无需登录访问私有仓库

以gitee为例

1. `ssh-keygen -t rsa -C "your_email@example.com"` 生成并添加公钥到gitee后台
2. `git config --global user.name "John Doe"` 和 `git config --global user.email johndoe@example.com` 配置好git
3. 一般如果是github这样就可以直接进行git push之类的操作了， 但是gitee不行， 因为这货的https上不能使用公钥进行访问， 必须使用ssh://协议， 于是这样


~/.gitconfig

```
[url "ssh://git@gitee.com"]
        insteadOf = https://gitee.com
```

~/.ssh/config
```
Host gitee.com
HostName gitee.com
Port 22
StrictHostKeyChecking no
IdentityFile /root/.ssh/id_rsa
```

# 运行goproxy

```
nohup /path/goproxy -listen=0.0.0.0:801 -cacheDir=/usr/local/gopath -proxy=https://goproxy.io -exclude gitee.com &
```

这里说一下各个选项的区别

- `-listen=0.0.0.0:801` 如果服务器上没有其他80端口的服务， 这里倒是可以直接用80， 不过goproxy好像没有作https的相关配置，因此想在不使用nginx的情况下，就需要改代码了， 还好代码没几行

而如果使用nginx， 并且已经有80和443服务的情况下， 可以这样  `-listen=127.0.0.1:801`

```
server {
     listen 443 ssl http2;
     server_name  proxy.example.com;

    add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
    ssl_certificate /path/to/proxy.example.com.cer;
    ssl_certificate_key /path/to/proxy.example.com.key;
    ssl_session_timeout 5m;
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE:ECDH:AES:HIGH:!NULL:!aNULL:!MD5:!ADH:!RC4:!DH:!DHE;
    ssl_prefer_server_ciphers on;

    location / {
        proxy_pass   http://127.0.0.1:801;
    }
}

```

- `-cacheDir=/usr/local/gopath` 这个路径就不要乱写了， 直接和GOPATH一样即可
- `-proxy=https://goproxy.io` 上级代理，国内服务器这个选项应该是必须的的， 国外的其实可以用server模式
- `-exclude gitee.com` 忽略域名，这个域名下的仓库会直连， 因此要保证能不用验证直接clone代码

# 以服务形式运行

源码目录下的goproxy.service可以使用, 不过需要加点东西

```
[Unit]
Description=goproxy service
Documentation=https://goproxy.io
After=network-online.target

[Service]
User=root
Group=root
LimitNOFILE=65536
Environment=PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/usr/local/go/bin:/root/bin:/usr/local/gopath/bin
ExecStart=/path/goproxy -listen=127.0.0.1:801 -cacheDir=/usr/local/gopath -proxy=https://goproxy.io -exclude "gitee.com"
WorkingDirectory=/path
KillMode=control-group

[Install]
WantedBy=multi-user.target
Alias=goproxy.service
```

`Environment=PATH=` 来自于 echo $PATH

PS: `systemctl enable goproxy`时提示 `Failed to execute operation: Invalid argument` 删除这一行即可 `Alias=goproxy.service`
