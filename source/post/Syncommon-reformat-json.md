title: Syncommon Reformat Json
date: 2018-11-30 15:16:24 +0800
update: ""
author: linx
tags:
- Delphi
- mORMot
categories:
- Delphi
- mORMot
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


重新格式化JSON
<!--more-->

```pascal
FormatedJson := JSONReformat(OriginJSON,jsonHumanReadable);
ShowMessage(FormatedJson);
```

其他选项可以查看 `SynCommon.pas` 下的 `TTextWriterJSONFormat` 集合
