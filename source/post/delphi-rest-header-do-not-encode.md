title: Delphi Rest请求控件增加请求头时不编码
date: 2018-11-05 18:48:21 +0800
update: ""
author: me
tags:
- Delphi
categories:
- Delphi
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


Delphi Rest Header Do Not Encode
<!--more-->

当使用Delphi 自带的REST控件进行HTTP请求的时候， 如果

```pascal
http.FRESTRequest.AddAuthParameter('Authorization','Bearer ' + token, pkHTTPHEADER);
```

默认会把其中的空格编码成`%20`

增加下面的一个参数即可不编码

```pascal
http.FRESTRequest.AddAuthParameter('Authorization','Bearer ' + FUserLoginInfo.data.token, pkHTTPHEADER,[TRESTRequestParameterOption.poDoNotEncode]);
```
