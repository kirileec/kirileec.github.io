title: RxlibEh控件替换流程
date: "2016-12-24 22:15:00"
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



GEXPERT 右键 `Replace Component`
Eh控件会残留 `RowDetailData:TRowDetailPanelControlEh`
记得清理

动态创建列
------------------------------------------------
```delphi
self.FillDataSet();
//kirile 2015-08-20 动态创建列
  dbgehMainDBTableView1.ClearItems;
  for i := 0 to Self.dbgehMainDBTableView1.DataController.DataSet.FieldCount - 1 do
  begin
    Self.dbgehMainDBTableView1.CreateColumn;
    Self.dbgehMainDBTableView1.columns[i].DataBinding.FieldName := Self.dbgehMainDBTableView1.DataController.DataSet.Fields[i].DisplayName;
    Self.dbgehMainDBTableView1.Columns[i].Caption := Self.dbgehMainDBTableView1.DataController.DataSet.Fields[i].DisplayName;
    Self.dbgehMainDBTableView1.Columns[i].Width := 160;
  end;
```

Eh 关键字
-----------------------------------------------------
```pascal
DBGridEhGrouping, 
ToolCtrlsEh,
DBGridEhToolCtrls, 
DynVarsEh, 
DBGridEh, 
PropFilerEh, 
PropStorageEh, 
PrnDbgeh,
DBCtrlsEh, 
DBLookupEh, 
EhLibVCL, 
GridsEh,
DBAxisGridsEh, 
DBVertGridsEh,
TRowDetailPanelControlEh,
TDBVertGridEh,
TDBGridEh,
TDBLookupComboboxEh,
TDBCheckBoxEh,
TPrintDBGridEh,
TPropStorageEh,
TIniPropStorageManEh;
```
---------------------------------------------------------------------------------
执行语句
-------
```pascal
with FDQuery do begin
  Command.CommandText.Text := 'Update T_CABINET set F_State = :F_State where F_ID = :F_ID';
  ParamByName('F_State').Value := aState;
  ParamByName('F_ID').Value := aID;
  try
    try
      ExecSQL;
      result := true;
    except
      on E: EFDDBEngineException do begin
      oMessage := '更新状态失败,请检查！' ;
      result:=False;
      end;
    end;
  except
    on E: Exception do
    begin
      oMessage := E.Message;
    end;
  end;
end;
```
删除记录
---
```pascal
  with myMainDM.sdsDelete do
  begin
    Connection := myConnection;
    Command.CommandText.Text := 'Delete From T_STORAGE Where F_AutoID = :F_AutoID';
    ParamByName('F_AutoID').AsInteger := aAutoID;
    ExecSQL ;
    try
      if RowsAffected <=0 then
        oMessage := '您选择的记录已不存在，请检查！'
      else
        result := true;
    except
      on E: Exception do
      begin
        oMessage := E.Message;
      end;
    end;
    myMainDM.sdsDelete.Close();
  end;
```
日期时间  替换为 `cxDateEdit` 设置 `properties`-> `Kind`
 `DBLOOKUPComboboxEh` ->  `cxLookupCombobox`
