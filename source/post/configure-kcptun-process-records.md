title: 配置kcptun过程记录
date: "2016-08-20 22:55:38"
update: ""
author: me
tags:
- windows
- kcptun
categories:
- windows
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



先上链接:
> https://blog.kuoruan.com/102.html
> http://www.dou-bi.com/ss-jc37/
> https://blog.kuoruan.com/111.html
> https://blog.kuoruan.com/110.html


服务端:
```
wget https://raw.githubusercontent.com/kuoruan/kcptun_installer/master/kcptun.sh
chmod +x ./kcptun.sh
./kcptun.sh
```
输入一个监听端口+ss端口+key,即可跑起服务端了

客户端:

使用`KcpTun Tools`作为客户端的转发, 本地端口随意,例如8388, 加速端口选择那个监听端口,填入key, 点击浏览选择`client_windows_amd64.exe` , 保存配置, 勾选开机启动, 启动加速,OK

Shadowsocks `127.0.0.1:8388`,加密方式和密码为原ss的配置,OK

安卓客户端:
版本需为3.0.4 , KCP端口选择上面设置的端口  参数填入 --key "XXXXXX"  即可, 启用KCP协议即可
