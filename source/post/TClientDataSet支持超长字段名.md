title: TClientDataSet支持超长字段名
date: "2018-10-29 19:31:08"
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



找到 `DataSnap.DBClient.pas`文件， 拷贝到一个目录中， 例如 `D:\DataSnap.DBClient.pas` ，修改其中的 `TCustomClientDataSet.AddFieldDesc` 方法，

```pascal
  //fix cds 字段长度限制问题
  LName := TMarshal.ReadStringAsAnsi(CP_UTF8, TPtrWrapper.Create(@FieldDesc.szName[0]));
  //if LName.Length = SizeOf(MIDASNAME) - 1 then
  //begin
    V := InternalGetOptionalParam(szFIELDNAME, FieldID);
    if not VarIsNull(V) and not VarIsClear(V) then
      LName := VarToStr(V);
  //end;
```

然后打开命令行

```bat
cd "C:\Program Files (x86)\Embarcadero\Studio\19.0\bin"
dcc32.exe D:\DataSnap.DBClient.pas
```

这样就可以生成 `DataSnap.DBClient.dcu` 文件

pas文件覆盖到 `C:\Program Files (x86)\Embarcadero\Studio\19.0\source\data\dsnap`
dcu文件覆盖到
`C:\Program Files (x86)\Embarcadero\Studio\19.0\lib\win32\debug`和 `C:\Program Files (x86)\Embarcadero\Studio\19.0\lib\win32\release`

如果需要x64程序也支持， 那么命令行使用 `dcc64.exe` 进行编译, 覆盖到对应位置即可
