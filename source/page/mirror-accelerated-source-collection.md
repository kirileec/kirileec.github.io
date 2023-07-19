title: 镜像(加速源)收集
date: 2015-04-22 14:01:53
update: ""
author: me
tags:
- mirrors
- page
categories:
- page
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: page
hide: false
toc: false
image: ""
subtitle: ""
lastmod: ""
hidden: true
config: {}


---



#

## Nuget

```link
http://nuget.fishlee.net/v3/index.json 
```

From [这里](https://blog.fishlee.net/2015/10/14/announcing_nuget_acceleration_service/)  
  
## Python Pypi  

```bash
vi ~/.pip/pip.conf  
```

```ini  
[global]  
index-url = http://pypi.v2ex.com/simple  
[install]  
trusted-host=pypi.v2ex.com  
```

`:wq`

## NPM

```bash  
vi ~/.npmrc  
```

```ini
registry = https://registry.npm.taobao.org  
```

From [淘宝NPM镜像](https://npm.taobao.org/)  
  
## Ubuntu
[163镜像](http://mirrors.163.com/.help/ubuntu.html)  
  
## Openwrt
[http://openwrt.proxy.ustclug.org/](http://openwrt.proxy.ustclug.org/)  
  
## Homebrew
[http://homebrew-mirror-china.tycdn.net/](http://homebrew-mirror-china.tycdn.net/)  

```bash
export HOMEBREW_BOTTLE_DOMAIN="http://homebrew-mirror-china.tycdn.net"
```

----  
[https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git](https://lug.ustc.edu.cn/wiki/mirrors/help/brew.git)  

```bash
cd "$(brew --repo)"  
git remote set-url origin git://mirrors.ustc.edu.cn/brew.git  
```

[https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles](https://lug.ustc.edu.cn/wiki/mirrors/help/homebrew-bottles)  

```bash
# 对于bash用户：  
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.bash_profile  
source ~/.bash_profile  
# 对于zsh用户  
echo 'export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles' >> ~/.zshrc  
source ~/.zshrc  
```

----  
[http://ban.ninja/](http://ban.ninja/)
