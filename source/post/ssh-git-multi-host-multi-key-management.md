title: git SSH多主机多密钥的管理
date: "2016-09-12 20:41:55"
update: ""
author: me
tags:
- WINDOWS-Linux
categories:
- WINDOWS-Linux
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



## 生成多个密钥
```bash
ssh-keygen -t rsa -C "a@email.com" -f ~/.ssh/id_rsa.a
ssh-keygen -t rsa -C "b@email.com" -f ~/.ssh/id_rsa.b
ssh-keygen -t rsa -C "c@email.com" -f ~/.ssh/id_rsa.c
```

## 配置多密钥匹配各自的主机

位置是 
当前用户:~/.ssh/config
全局:
- Windows 下在 `"C:\Program Files\Git\etc\ssh\ssh_config"`
- Linx下在 `/etc/ssh/ssh_config`

一般情况下不需要修改全局的文件, 只需要新增一个用户的`config`即可(默认不存在)

以下为一个例子:
```
Host 192.168.1.206
    Port 2222
    User "linx"
    KexAlgorithms +diffie-hellman-group1-sha1
    IdentityFile ~/.ssh/id_rsa.a
```

可以指定ssh使用的端口(使用非22端口时)
第四行一般是`Gerrit`会需要使用
最后一行, 则指定了访问`192.168.1.206`这个主机是需要使用的KEY私钥

**特殊情况**: 比如Jenkins在访问非标准端口的Git仓库时, 需要在全局`ssh_config`里配置, 否则会无法访问, 提示不是正常的仓库

最后, `ssh -T git@192.168.1.206`, 无需带上端口
