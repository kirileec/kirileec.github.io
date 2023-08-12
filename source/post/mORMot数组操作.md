title: mORMot数组操作
date: 2017-12-11 19:53:49 +0800
update: ""
author: me
tags:
- mORMot
categories:
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
procedure TForm1.FormCreate(Sender: TObject);
type
  TGroup = record
    name: string;
    value: string;
  end;
  TGroupArr = array of TGroup;
var
  DA:TDynArray;
  strArr:TStringDynArray;
  v:string;
  newResult,findResult:TGroup;
  groupArr:TGroupArr;
begin
  SetLength(strArr,2);
  strArr[0]:='123';
  strArr[1]:='345';
  DA.Init(TypeInfo(TStringDynArray),strArr);
  v := 'str 1';
  //DA.Add('str 1') is illegal
  DA.Add(v);
  v := 'str 2';
  DA.Add(v);
  ShowMessage(DA.SaveToJSON());
  DA.ClearSafe;

  //find record from array
  DA.Init(TypeInfo(TGroupArr),groupArr);
  //必须设置这个属性 才可以查找
  DA.Compare := SortDynArrayString;
  newResult.name := 'A';
  newResult.value := 'AValue';
  DA.Add(newResult);

  newResult.name := 'B';
  newResult.value := 'BValue';
  DA.Add(newResult);
  findResult.name := 'A';

  //找到了就会自动填充
  DA.FindAndFill(findResult);
  ShowMessage(findResult.value);

end;
```
