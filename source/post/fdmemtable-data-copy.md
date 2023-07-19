title: FDMemTable data copy
date: "2016-12-24 22:08:00"
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



防止添加重复数据  
```pascal
FDMemTable2.First;
  while  not FDMemTable2.Eof do
  begin
    if not FDMemTable1.Locate('F_AUTOID',FDMemTable2.FieldByName('F_AUTOID').AsString,[] ) then
       FDMemTable1.CopyRecord(FDMemTable2);
    FDMemTable2.Next;
  end;
```
完全转移数据
```pascal
FDMEMTABLE.AppendData(FDMEMTABLE.DATA);
```
