title: samba 无密码访问
date: 2020-07-07 21:24:18 +0800
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



树莓派

```
[global]
workgroup = WORKGROUP
server string Samba Server Version %v
security = user
map to guest = Bad User
guest account = root
[deploy]
comment = 
path = /share
browseable = yes
writeable = yes
guest ok = yes
create mode = 0777
directory mode = 2777
```

```
sudo samba restart
```
