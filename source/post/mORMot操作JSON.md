title: mORMot操作JSON
date: 2017-12-09 23:07:03 +0800
update: ""
author: me
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



```pascal
type
  TCusObject = class
  private
    FB: string;
    FA: string;
    procedure SetA(const Value: string);
    procedure SetB(const Value: string);
  published
    property A: string read FA write SetA;
    property B: string read FB write SetB;
  end;

procedure TCusObject.SetA(const Value: string);
begin
  FA := Value;
end;

procedure TCusObject.SetB(const Value: string);
begin
  FB := Value;
end;


uses
  SynCommons;
```

```pascal
procedure TForm1.btn1Click(Sender: TObject);
var
  json,json1:Variant;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O
  json1 := _Json(mmo1.Lines.Text);
  mmo2.Lines.Add('==========Parse Json String To Variant==========');
  mmo2.Lines.Add('a:' + json.a);
  mmo2.Lines.Add('b:' + json.b);
  mmo2.Lines.Add('==========END==========');

end;

procedure TForm1.btn2Click(Sender: TObject);
var
  json:Variant;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O

  json.c := 'This is C';

  mmo2.Lines.Add('==========Add Field To Json==========');
  mmo2.Lines.Add('New Json:' + VariantToString(json));
  mmo2.Lines.Add('a:' + json.a);
  mmo2.Lines.Add('b:' + json.b);
  mmo2.Lines.Add('c:' + json.c);
  mmo2.Lines.Add('==========END==========');

end;

procedure TForm1.btn3Click(Sender: TObject);
var
  json:Variant;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O

  TDocVariantData(json).Delete('a');

  mmo2.Lines.Add('==========Remove Field From Json==========');
  mmo2.Lines.Add('New Json:' + VariantToString(json));
  mmo2.Lines.Add('==========END==========');

end;

procedure TForm1.btn4Click(Sender: TObject);
var
  json,json1:Variant;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O
  json1 :=  _JsonFast('{}');
  json1.c := 'This is C';
  json1.d := 'This is D';
  TDocVariantData(json).AddValue('c',VariantToUTF8(json1));

  mmo2.Lines.Add('==========Add Json To Json As One Field==========');
  mmo2.Lines.Add('New Json:' + VariantToString(json));
  mmo2.Lines.Add('==========END==========');

end;

procedure TForm1.btn5Click(Sender: TObject);
var
  json,json1:Variant;
  prettyJson:RawJSON;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O
  json1 :=  _JsonFast('{}');
  json1.c := 'This is C';
  json1.d := 'This is D';
  TDocVariantData(json).AddValue('c',VariantToUTF8(json1));
  prettyJson := TDocVariantData(json).ToJSON('','',jsonHumanReadable);
  mmo2.Lines.Add('==========Add Json To Json As One Field==========');
  mmo2.Lines.Add('New Json:' +prettyJson);
  mmo2.Lines.Add('==========END==========');
end;

procedure TForm1.btn6Click(Sender: TObject);
var
  json:Variant;
  prettyJson:RawJSON;
begin
  json := _JsonFast(mmo1.Lines.Text); // more faster O(∩_∩)O

  TDocVariantData(json).AddOrUpdateValue('c',_Json( '{"name":"This is C name","sex":"This is C sex"}'));


  mmo2.Lines.Add('==========Add Sub Object==========');
  prettyJson := TDocVariantData(json).ToJSON('','',jsonHumanReadable);
  mmo2.Lines.Add('New Json:' + prettyJson);
  mmo2.Lines.Add('a:' + json.a);
  mmo2.Lines.Add('b:' + json.b);
  mmo2.Lines.Add('c.name:' + json.c.name);
  mmo2.Lines.Add('==========END==========');

end;
```
