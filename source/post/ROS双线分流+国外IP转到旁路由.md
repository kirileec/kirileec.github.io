title: ROS双线分流, 国外IP转到旁路由
date: 2023-07-13 21:08:44 +0800
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



经过多日难受 -_-||, 总算正常了

以下为我的场景

- 双宽带, 一条移动300M, 一条电信100M, 移动为桥接拨号, 电信是从上级路由DHCP(虽然是200M的宽带但是给的网线只接了4根). 需要两者进行叠加, 主要就是百度网盘这种可以叠加下载速度即可, 其他场景基本不需要叠加
- P2P打洞组网需求, 之前是用一台国内的服务器自建planet用zerotier, 由于服务器快过期了, 想想还是换到tailscale, 但是必须要有ipv6才行
- 由于之前瞎鸡儿乱搞导致翻墙访问很慢, google网页都要10s以上才有反应, 用curl测试也要10s左右, 因此特别去研究了下ROS的mangle

## 网络结构
- 10.11.0.1 ROS虚拟机
- 10.11.0.2 PVE
- 10.11.0.4 打洞服务
- 10.11.0.5 梯子服务
- 10.11.0.6 dns服务

## 配置两条网络连接
wanct 为电信, wancm则为连接移动的光猫口, pppoe-cm为移动拨号后的接口

1. 添加dhcp
```
/ip dhcp-client
add interface=wanct use-peer-dns=no use-peer-ntp=no
```
2. 添加pppoe拨号
```
/interface pppoe-client
add add-default-route=yes comment="" disabled=no interface=wancm \
    name=pppoe-cm user=用户名
```
![](/images/pppoe.png)

3. 由于我有两个lan口, 一个是pve的虚拟网卡, 还有一个则是直通的物理网卡, 给这俩来个桥接, 桥接成br-lan
```
/interface bridge
add comment="" name=br-lan
/interface bridge port
add bridge=br-lan interface=lan
add bridge=br-lan interface=lan2
```
![](/images/bridge.png)

4. 设定局域网ROS自己地址

```
/ip address
add address=10.11.0.1/24 interface=br-lan network=10.11.0.0
```

5. 创建dhcp服务, 局域网网段为 10.11.0.0/24
先创建IP分配池子
```
/ip pool
add name=dhcp-pool ranges=10.11.0.30-10.11.0.200
```

```
/ip dhcp-server
add address-pool=dhcp-pool interface=br-lan lease-time=4h name=server1

/ip dhcp-server network
add address=10.11.0.0/24 dns-server=10.11.0.1 gateway=10.11.0.1
```

6. 配置DNS
```
/ip dns
set allow-remote-requests=yes cache-size=20480KiB servers=10.11.0.6
```

7. 创建路由表
```
/routing table
add disabled=no fib name=gfw
add disabled=no fib name=cm
add disabled=no fib name=ct
add disabled=no fib name=zero
```
8. IPv6设置

目前只有移动的可以获得ipv6前缀

- 首先到 `IPv6` -> `Settings` 确认`Disable IPv6` 已经取消勾选
![](/images/use-ipv6.png)

- 然后到 `PPP`->`Profiles`, 确认`default`这个的`Protocols`里面的`Use IPv6` 选择的是 yes
![](/images/ppp-ipv6.png)
- 配置获取ipv6前缀
```
/ipv6 dhcp-client
add interface=pppoe-cm pool-name=ipv6 pool-prefix-length=60 request=prefix \
    use-peer-dns=no
```
这里pool-name随意, 请求到前缀后就会生成一个池子. pool-prefix-length看运营商给的是什么, 我这里是60

![](/images/dhcpv6-prefix.png)

- 给ROS自己分配个ipv6地址
```
/ipv6 address
add address=::/64 eui-64=yes from-pool=ipv6 interface=lan
```

这里在用winbox添加的时候, 直接填写 `::/64`, 保存后自己就会获取一个地址

- 配置ND服务

![](/images/ros-nd.png)
```
/ipv6 nd
set [ find default=yes ] interface=br-lan managed-address-configuration=yes \
    other-configuration=yes
add interface=*2 other-configuration=yes
```

到这里, 局域网机子应该可以自动获得ipv6地址了


## 开始重头戏

- 加入一个拉取国内IP地址列表的脚本, 名字随意
```
/tool fetch url=https://gh.api.99988866.xyz/https://raw.githubusercontent.com/DMF2022/ROS-cnip-script/main/cnip.rsc
/system logging disable 0
/import cnip.rsc
/system logging enable 0
:local CNIP [:len [/ip firewall address-list find list="CNIP"]]
/file remove [find name="cnip.rsc"]
:log info ("CNIP列表更新:"."$CNIP"."条规则")
```
![](/images/cnip-script.png)

加入后, 点一下 `Run Script`, 稍等一会就可以在 `IP`->`Firewall`的`Address Lists`里看到导入的地址列表了.

至于列表的自动更新, 没事的时候上去点一下也没啥, 反正就算少了些IP也问题不大, 如果真要自动更新, 就在`System`->`Scheduler`里加入定时任务即可

- 为路由表设置网关, 即打了某个路由标记的数据连接应该到哪里去
```
/ip route
add check-gateway=ping comment="" \
    disabled=no distance=1 dst-address=0.0.0.0/0 gateway=10.11.0.5 pref-src="" \
    routing-table=gfw scope=30 suppress-hw-offload=no target-scope=10
add check-gateway=ping comment="" disabled=no \
    distance=1 dst-address=0.0.0.0/0 gateway=10.11.0.4 pref-src="" \
    routing-table=zero scope=30 suppress-hw-offload=no target-scope=10
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    pppoe-cm pref-src="" routing-table=cm scope=30 suppress-hw-offload=no \
    target-scope=10
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    wanct pref-src="" routing-table=ct scope=30 suppress-hw-offload=no \
    target-scope=10
```

- 创建NAT
10.10.0.0/24
```
/ip firewall nat
add action=masquerade chain=srcnat comment="访问打洞的内网地址时进行IP伪装" dst-address=10.10.0.0/24 \
    src-address=10.11.0.0/24
add action=masquerade chain=srcnat comment=\
    "移动的伪装" out-interface=pppoe-cm
add action=masquerade chain=srcnat out-interface=wanct
add action=masquerade chain=srcnat comment="IP伪装, 通过路由表转发到clash, 如果不伪装, 数据回来的时候会直接回到客户端去,造成无法访问" out-interface=br-lan \
    routing-mark=gfw
add action=dst-nat chain=dstnat comment="Full Cone, 为tailscale开启NAT1, 目前靠ipv6, 没啥用" in-interface=wanct \
    to-addresses=10.11.0.4
```
这里最重要的是第四条, 由于我之前没有对转发到旁路由的流量进行伪装, 导致国外网页打开贼慢, 有时候干脆打不开. 各种测试硬是没找到原因在哪儿. 附上一个测试网页打开速度的脚本

```
curl -so /dev/null -w " DNS解析: %{time_namelookup} \n 连接耗时: %{time_connect} \n 应用耗时: %{time_appconnect} \n 预传输: %{time_pretransfer} \n 开始传输: %{time_starttransfer} \n\n 总共: %{time_total} \n 传输大小: %{size_download}\n" https://www.google.com
```
具体原因后面进行总结

- mangle打标记

```
/ip firewall mangle
add action=accept chain=prerouting comment=\
    "访问局域网地址时放行" dst-address=\
    10.11.0.0/24 src-address=10.11.0.0/24
add action=mark-routing chain=prerouting comment="访问打洞的其他网络的ip的时候, 直接打zero的路由标记, 并且不继续往下匹配" dst-address=10.10.0.0/24 new-routing-mark=zero passthrough=no \
    src-address=10.11.0.0/24
add action=mark-routing chain=prerouting comment=\
    "针对.4这一台过来的流量, 打上路由标记让它直接固定走一条线路" in-interface=\
    br-lan new-routing-mark=ct passthrough=no src-address=10.11.0.4
add action=mark-routing chain=prerouting comment="从梯子那台过来的流量也打个标记, 并且不继续匹配" in-interface=br-lan new-routing-mark=ct passthrough=no \
    src-address=10.11.0.5
add action=mark-routing chain=prerouting comment="非国内IP, 打上gfw标记, 转到.5那台去" connection-mark=\
    no-mark dst-address-list=!CNIP dst-address-type=!local in-interface=br-lan \
    new-routing-mark=gfw passthrough=no src-address=10.11.0.0/24
add action=change-mss chain=forward new-mss=clamp-to-pmtu passthrough=yes \
    protocol=tcp tcp-flags=syn
add action=mark-connection chain=input in-interface=pppoe-cm \
    new-connection-mark=conn-cm passthrough=yes
add action=mark-routing chain=output connection-mark=conn-cm new-routing-mark=\
    cm passthrough=yes
add action=mark-connection chain=input in-interface=wanct new-connection-mark=\
    conn-ct passthrough=yes
add action=mark-routing chain=output connection-mark=conn-ct new-routing-mark=\
    ct passthrough=yes
add action=mark-connection chain=prerouting comment=\
    "为连接打标记" connection-mark=no-mark \
    connection-state="" dst-address-type=!local in-interface=br-lan \
    new-connection-mark=conn-cm passthrough=yes per-connection-classifier=\
    both-addresses:4/0 src-address=10.11.0.25
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state="" dst-address-type=!local in-interface=br-lan \
    new-connection-mark=conn-cm passthrough=yes per-connection-classifier=\
    both-addresses:4/1 src-address=10.11.0.25
add action=mark-connection chain=prerouting connection-mark=no-mark \
    connection-state="" dst-address-type=!local in-interface=br-lan \
    new-connection-mark=conn-cm passthrough=yes per-connection-classifier=\
    both-addresses:4/2 src-address=10.11.0.25
add action=mark-connection chain=prerouting connection-mark=no-mark \
    dst-address-type=!local in-interface=br-lan new-connection-mark=conn-ct \
    passthrough=yes per-connection-classifier=both-addresses:4/3 src-address=\
    10.11.0.25
add action=mark-routing chain=prerouting connection-mark=conn-cm in-interface=\
    br-lan new-routing-mark=cm passthrough=yes
add action=mark-routing chain=prerouting connection-mark=conn-ct in-interface=\
    br-lan new-routing-mark=ct passthrough=yes
```

- passthrough=no 表示如果当前这条规则有匹配到了, 会直接忽略它下面的规则. 可以想象成, ROS中所有连接进来, 都会从上往下一个个匹配
- change-mss是为了让mtu能准确, 防止mtu问题导致的网络卡顿或丢包
- change-mss下面的4条, 是将两条宽带的流量进出统一起来, 防止从电信进来的流量从移动出去了
- `为连接打标记` 以及下面的3条为PCC(Per Connection Classifier) 负载设置. 由于我的是300M和100M, 所以把总带宽分为4份, 前面3份走移动, 还有1份走电信. 即 `4/0-3`. `src-address`这里暂时只设置了一台, 如果需要整个局域网都要就改成 `10.11.0.0/24`即可 
- 最后2条为把前面PCC标记的连接打上路由标记, 这样这些连接就会根据标记到该去的路由表进行处理了


## 小总结

```
add action=masquerade chain=srcnat comment="IP伪装, 通过路由表转发到clash, 如果不伪装, 数据回来的时候会直接回到客户端去,造成无法访问" out-interface=br-lan \
    routing-mark=gfw
```

由于之前没有这一条, 导致网络慢, 主要是外网.

期望的路由走向是这样的(访问外网)

client(10.11.0.25) -> 10.11.0.1 -> 10.11.0.5 -> 10.11.0.1 -> web -> 10.11.0.1 -> 10.11.0.5 -> 10.11.0.1 -> 10.11.0.25

但是不加伪装的话就会变成这样

client(10.11.0.25) -> 10.11.0.1 -> 10.11.0.5 -> 10.11.0.1 -> web -> 10.11.0.1 -> 10.11.0.5 -> ~~10.11.0.1~~ -> 10.11.0.25

就会少了中间划掉的那一步. 不伪装的时候, 10.11.0.5收到连接的时候, 源地址为 10.11.0.25, 那么流量回来的时候, 10.11.0.5 会把数据直接返回给10.11.0.25, 这样会出现10.11.0.25收到了从10.11.0.5发来的数据, 而10.11.0.25并没有给10.11.0.5发送过数据

IP伪装: 一个tcp请求包含源地址和目标地址, 一来一回两者必须一致. 伪装就是把源地址修改为伪装者(网关).

所以翻墙的旁路由也需要配置伪装(流量是老子发出去的, 不是我孙子发出去的)

![](/images/curl-test-google.png)
![](/images/google-trace.png)

目前和直接跑clash差不多速度了, 舒服~~
