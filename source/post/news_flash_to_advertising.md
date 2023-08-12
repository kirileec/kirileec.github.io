title: 闪讯去广告
date: "2012-06-02 10:52:00"
update: ""
author: me
tags:
- 杂谈
- other
categories:
- other
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




闪讯，恶心的家伙，本来联网的时候只弹一次的广告还能忍受，反正一天也就一次不是。可是最近，这货不知道什么时候偷偷更新了，然后居然在联网的时候弹出所谓的新闻界面，所做行为令人发指。本来第一直觉是脱壳去广告，后来一尝试，哎，水平不足啊，放弃，以后再试吧。于是网搜相关方法。
找到了防火墙方法
添加出站规则，阻止`Netkeeper.exe`访问以下三个地址

```
220.191.135.221
61.164.4.165
61.164.4.163
```

如果有必要，可以考虑在host文件里添加三条
```
127.0.0.1 wap.114school.cn
127.0.0.1 business.114school.cn
127.0.0.1 tag.114school.cn
```

然后找到config目录下，将`basic.xml`文件修改为
```xml
<?xml version="1.0" standalone="yes" ?>
<DialTerminal>
    <window>
    </window>
</DialTerminal>
将config.xml修改为
<?xml version="1.0" encoding="GBK"?>
<DialTerminal>
<tabConfig>
</tabConfig>
<toolConfig>
</toolConfig>
<textAdvtConfig>
</textAdvtConfig>
</DialTerminal>
```
保存，然后设置两个文件为只读，ok联网，那个恶心的弹出广告也没了，世界清静了。
详细可以查看
> http://jusoy.com/blog/archives/45
