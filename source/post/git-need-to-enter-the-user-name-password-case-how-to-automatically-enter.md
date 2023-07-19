title: git 需要输入用户名密码的情况下如何自动输入
date: "2016-11-25 23:24:00"
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



由于各种原因，自建的gitlab服务器使用了非标准端口的HTTP服务，即使正确的加入了sshkey， 也依然提示需要输入用户和密码，而同样的情况下， windows下的git-shell则可以正常免密码进行pull和push， 而在linux下却不行， 尝试进行git版本的升级（默认是1.9.1）无效，因此可以使用以下方法进行操作，以实现免输入密码和用户名

首先git远端地址使用 HTTP 方式
```bash
sudo touch ~/.netrc
sudo chmod 600 ~/.netrc
sudo gedit ~/.netrc
```
写入以下内容

```
machine 服务IP地址 login gitlab用户名 password gitlab密码
```

然后测试

```git
git pull origin
```
