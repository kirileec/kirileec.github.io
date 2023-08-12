title: 'SQL SERVER导入txt数据错误: 数据流任务、 数据转换失败、文本截断'
date: "2014-07-04 10:48:00"
update: ""
author: me
tags:
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



使用POWERBUILDER 6 从HIS测试服务器中导出txt数据，然后导入到我自己的数据库里导入时发现有些表无法导入，列分隔符为制表符，行分隔符为CR LF导入时报标题的错，纠结了一天
找到了解决方案高级里，设置 “有中文的列的数据类型”为 unicode字符串，然后将长度设为……………………数字去吧，一个汉字长度2，粘贴到word里然后瞄一眼左下角，卧槽我直接设了700
