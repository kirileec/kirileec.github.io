title: Install Docker on Debian
date: 2020-05-10 19:46:01 +0800
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



# Debian 安装Docker
<!--more-->

1. 卸载旧的

```bash
sudo apt-get remove docker docker-engine docker.io containerd runc
```

2. 安装下前戏

```bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
```

3. 正式安装

```bash
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

PS: 执行 curl 时错

```bash
curl: (77) error setting certificate verify locations:
  CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
```

检查 `/etc/ssl/certs` 目录下是否有对应的文件, 如果没有, 则为不可抗力原因消失了, 重新安装 `ca-certificates`这个包即可.

```bash
sudo apt-get remove ca-certificates
sudo apt-get install ca-certificates
```
