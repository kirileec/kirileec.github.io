title: mORMot运行在普通VCL程序中
date: 2017-05-24 20:29:39 +0800
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



```pascal
uses 
  SynCommons, SynLZO, SynCrtSock;
type
  TTestServer = class
    protected
      fstr : string;
      fServer: THttpApiServer; //内部为http.sys的实现
      function Process(Ctxt: THttpServerRequest): cardinal;
    public
      constructor Create(const str:string;const path:string);
      destructor Destroy; override;
  end;


{ TTestServer }

constructor TTestServer.Create(const str:string;const path:string);
begin
  fstr := str;
  fServer := THttpApiServer.Create(false);
  fServer.AddUrl(path,'888',false,'+',true);
  fServer.RegisterCompress(CompressSynLZ); //可以启用不同的压缩库
  fServer.OnRequest := Process;
end;

destructor TTestServer.Destroy;
begin
  fServer.Free;
  inherited;
end;

function TTestServer.Process(Ctxt: THttpServerRequest): cardinal;
begin
  Ctxt.OutContentType := JSON_CONTENT_TYPE;// ContentType: application/json; charset=utf-8

  Ctxt.OutContent := ToUTF8(fstr); //转换到UTF8的字符串， 解决中文乱码的问题
  result := 200;
end;

```

```pascal
   //可以绑定多个路径， 但是是同一个端口
   TestServer := TTestServer.Create('{"你好":"aaa"}','root') ; 
   TestServer2 := TTestServer.Create('{"你好":"bbb"}','bbb') ;
```

非常棒！！
