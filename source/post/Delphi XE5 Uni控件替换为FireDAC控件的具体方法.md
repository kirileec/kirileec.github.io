title: Delphi XE5 Uni控件替换为FireDAC控件的具体方法
date: "2015-09-07 12:33:31"
update: ""
author: me
tags:
- delphi
categories:
- delphi
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



1. 在UniConnection和UniQuery在的DataModule上创建新的FDConnection和FDQuery，重命名UniConnection
为uniConnection1，FDConnection重命名为UniConnection，FDQuery同理
2. 替换代码中TUniConnection为TFDConnection，这一步比较麻烦，可以使用Gexpert的F2功能进行，会比较快
，以及各种引用的时候，CommandText替换为Command.CommandText.Text
3. 替换字段类型
- TBCDField ->TFMTBCDField
- TCurrency ->TFMTBCDField
- TSQLTimeStampField ->TDateTimeField
4. FDConnection 中 Options添加Data Mapping Rules
