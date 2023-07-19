title: mORMot返回TClientDataSet
date: 2017-05-25 20:20:18 +0800
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



- [DataSetJSONConverter4D](https://github.com/ezequieljuliano/DataSetConverter4Delphi)
- [mORMot](https://github.com/synopse/mORMot)


我是从自带的例子 `20 - DTO interface based service` 进行修改而来
```pascal
  IAirportService = interface(IInvokable)
    ['{4A613FCE-3B0D-4582-97C5-4244B06C2006}']
    function ReturnCds(a:Integer):TServiceCustomAnswer;
  end;
```

这里返回 `TServiceCustomAnswer`的原因是
google 搜索到 

[https://synopse.info/forum/viewtopic.php?id=2400](https://synopse.info/forum/viewtopic.php?id=2400)

这个帖子，作者说，为了返回的json不带result这个字段，那么必须返回这个类型

见 

[https://synopse.info/files/html/api-1.18/mORMot.html#TSERVICECUSTOMANSWER](https://synopse.info/files/html/api-1.18/mORMot.html#TSERVICECUSTOMANSWER)

当然我就立马试了一下，不过不行，在经过认真阅读了文档之后，必须

```pascal
TServiceCustomAnswer.Header := JSON_CONTENT_TYPE_HEADER;
```

即Header必须要设置，否则无效

写了一个简单的类

```pascal
THTTPServiceBase = class(TInterfacedObject)
public
    procedure Success(var cds:TClientDataSet;out answer:TServiceCustomAnswer);overload;
    procedure Fail(const msg:string;out answer:TServiceCustomAnswer);
end;

procedure THTTPServiceBase.Fail(const msg: string;
out answer: TServiceCustomAnswer);
var
    ILog: ISynLog;
begin
    ILog := TSynLog.Enter(self,'Fail');
    ILog.log(sllInfo,'Fial');
end;

procedure THTTPServiceBase.Success(var cds: TClientDataSet;out answer:TServiceCustomAnswer);
begin
    answer.Header := JSON_CONTENT_TYPE_HEADER;
    answer.Content := ToUTF8(cds.AsJSONObjectString);
    answer.Status := 200;
end;
```

实现Service

```pascal
TAirportService = class(THTTPServiceBase, IAirportService)
  public
    function ReturnCds(a:Integer):TServiceCustomAnswer;
end;

function TAirportService.ReturnCds(a:Integer): TServiceCustomAnswer;
var
  cds:TClientdataSet;
begin
  if a<>1 then
  begin
    Self.Fail('错误的参数',Result);
  end;
  cds := TClientdataSet.Create(nil);
  try
    cds.FieldDefs.Clear;
    cds.FieldDefs.Add('F_NAME', ftString, 100);
    cds.FieldDefs.Add('F_SEX', ftString, 100);
    cds.CreateDataSet;

    cds.Append;
    cds.FieldByName('F_NAME').AsString := '这是一个名字';
    cds.FieldByName('F_SEX').AsString := '这是一个性别';
    cds.Post;
    self.Success(cds,Result);
  finally
    FreeAndNil(cds);
  end;
end;
```

如此一来，就可以实现我的以下要求了

HTTP URL 中传入方法名和参数，即可获得需要的数据，内部可以传入自己的连接池用于查询数据

THTTPServiceBase类中做一些处理，可以加入验证机制，自带的验证机制，我暂时还没搞懂

接下来可以尝试如何实现POST body的解析
