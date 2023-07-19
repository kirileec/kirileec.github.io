title: flash P2P MAC
date: "2015-07-10 18:34:00"
update: ""
author: me
tags:
- MAC
categories:
- MAC
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



```bash
##自带flash
mkdir -p ~/Library/Application\ Support/Google/Chrome/Default/Pepper\ Data/Shockwave\ Flash/System
touch ~/Library/Application\ Support/Google/Chrome/Default/Pepper\ Data/Shockwave\ Flash/System/mms.cfg
echo "RTMFPP2PDisable=1" >> ~/Library/Application\ Support/Google/Chrome/Default/Pepper\ Data/Shockwave\ Flash/System/mms.cfg
##MAC Chrome Pepper Flash
/Users/用户名/Library/Application Support/Google/Chrome/Profile 2/Pepper Data/Shockwave Flash/System
## /Users/用户名/Library/Application Support/Google/Chrome/Profile 2 这一部分在 `chrome://version/` 页面获取
```
System文件夹需要新建一个
