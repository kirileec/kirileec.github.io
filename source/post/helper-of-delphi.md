title: 'Helper of Delphi '
date: "2017-01-07 13:47:48"
update: ""
author: me
tags:
- Delphi XE8
categories:
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



```pascal
TStringListHelper = class Helper for TStringList
  function Contains(value:string):Boolean;
end;


function TStringListHelper.Contains(value: string): Boolean;
var
  index: Integer;
begin
  if self.Find(str, index) then
    Exit(True)
  else
    Exit(False);
end;
```

简直和C#的扩展方法一毛一样, 写完放那就可以不用管了
