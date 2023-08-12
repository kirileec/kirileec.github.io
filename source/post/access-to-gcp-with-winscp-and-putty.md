title: Access to Gcp With Winscp and Putty
date: 2019-10-26 11:06:31 +0800
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


使用putty的方式访问gcp
<!--more-->

## 前置要求
- Winscp和putty两件套
- GCP正在运行

## 流程

1. 打开GCP, 进入网页SSH, ![](/llinx.me/static/img/gcp-open-ssh.png)), 记下自己的用户名, 一般默认就是自己的gmail邮箱
2. 打开Puttygen, 点击`Generate`, 不断移动鼠标生成一组key, 在`Key comment`处填上第一步的用户名, 并分别点击 `Save public key` 和 `Save private key`, 保存两个文件, 并妥善保存
3. 复制`Public key for pasting into OpenSSH authorized_keys file`部分的文本, 粘贴到 `VM实例`->点击`instance-xxx`->`修改`->您有 xxx 个 SSH 密钥 `显示和修改` 这个位置中
4. 打开WinSCP, 填上IP和用户名, 双击一下gcp.ppk, 点击登录即可
