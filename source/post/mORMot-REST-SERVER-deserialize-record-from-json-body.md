title: mORMot REST服务端自动解析json body为record
date: 2017-05-28 21:52:12 +0800
update: ""
author: me
tags:
- Delphi
- mORMot
- Delphi-XE8
categories:
- Delphi-XE8
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



声明
```pascal
type
  TMyRecord = record
    id:Integer;
    name:string;
  end;

  ITestService = interface(IInvokable)
    ['{CB7ABEE8-134D-4706-8C6D-FAACECA754D4}']
    function PostClient(const rec:TMyRecord):TServiceCustomAnswer;
  end;

```

```pascal
function TTestService.PostClient(const rec:TMyRecord): TServiceCustomAnswer;
begin
  CheckMethod('POST',Result);

  Success('成功取得请求体:'+RecordSaveJson(rec,TypeInfo(TMyRecord)), Result);
end;
```

客户端调用方法

```json
{
    "rec":
    {
        "id":"id",
        "name":"name"
    }

}
```

不能直接向其它服务端那样，而是需要指定一下参数名， 这里的 `rec` 就是参数名，
那么， 其实一次POST请求可以传递多个参数了
