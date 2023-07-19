title: TJSONObject 对象内存释放
date: 2017-05-07 21:59:29 +0800
update: ""
author: me
tags:
- Delphi
- Delphi XE8
categories:
- Delphi
- Delphi XE8
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



使用
```delphi
ReportMemoryLeaksOnShutdown := True;
```
来开启自带的内存泄露检测

引用 `System.JSON`单元

测试代码如下：
```pascal
procedure TForm1.FormCreate(Sender: TObject);
var
  jo:TJsonObject;
  joo:TJsonObject;
  ja:TJsonArray;
  jao:TJsonValue;
begin
  //状况1 单个JSON对象 直接释放即可
  jo := TJSONObject.ParseJSONValue('{"A":true}') as TJSONObject;
  //jo.Free;
  FreeAndNil(jo);

  //状况2 数组对象 在遍历时， 无需对遍历的对象进行释放
  ja := TJSONObject.ParseJSONValue('[{"A":true},{"B":false}]') as TJSONArray;
  for jao in ja do
  begin
    OutputDebugString(PChar(jao.ToString));
    // jao.Free;  这样会报异常   因为其实这里的jao仅仅是一个指针，而不是拷贝出来的对象
  end;
  //ja.Free;
  FreeAndNil(ja);

  //状况3 Values['Name'] 出来的对象， 其实这里和状况2类似
  jo := TJSONObject.ParseJSONValue('{"A": {"B":true}}') as TJSONObject;

  joo := jo.Values['A'] as TJSONObject;
  OutputDebugString(PChar(joo.ToString));
  //joo.Free;
  //FreeAndNil(joo);  //这样也会出错

  FreeAndNil(jo);
end;
```

为什么会这样， 看源码：
```delphi
destructor TJSONObject.Destroy;
var
  Member: TJSONAncestor;
  I: Integer;
begin
  if FMembers <> nil then
  begin
    for i := 0 to FMembers.Count - 1 do
    begin
      Member := TJSONAncestor(FMembers[I]);
      if Member.GetOwned then
        Member.Free;
    end;
    FreeAndNil(FMembers);
  end;
  inherited Destroy;
end;

destructor TJSONArray.Destroy;
var
  Element: TJSONAncestor;
  I: Integer;
begin
  if FElements <> nil then
  begin
    for I := 0 to FElements.Count - 1 do
    begin
      Element := TJSONAncestor(FElements[I]);
      if Element.GetOwned then
        Element.Free;
    end;
    FreeAndNil(FElements);
  end;
  inherited Destroy;
end;
```

也就是说，这棵对象的树会自己处理树枝的生命周期， 因此只要管好 `ParseJSONValue` 出来的那个对象即可
