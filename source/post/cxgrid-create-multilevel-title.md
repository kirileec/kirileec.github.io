title: cxgrid create multilevel title
date: "2016-12-24 22:11:00"
update: ""
author: me
tags:
- delphi
- cxgrid
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



```pascal
procedure CreateMultiBands(GridView:TcxGridDBBandedTableView;cds:TClientDataSet);
var
  band,band1:TcxGridBand;
  col:TcxGridDBBandedColumn;
  fieldCount:Integer;
  i,j,k:Integer;
  Lines:TStringList;
  bandCaption:string;
  bands:TDictionary<string,TcxGridBand> ;
begin
  bands := TDictionary<string, TcxGridBand>.Create;
  fieldCount := cds.Fields.Count;
  GridView.BeginUpdate(lsimPending);
  for i := 0 to fieldCount - 1 do
  begin      //第一层表头绘制
    Lines := TStringList.Create;
    ExtractStrings(['|'], [], PChar(cds.Fields[i].FieldName), Lines); //对一个字段进行分割处理
    bandCaption := '';
    if not bands.ContainsKey(Lines[0] + '|') then   //如果第一行重复不添加
    begin
      band := GridView.Bands.Add;
      band.Caption := Lines[0];
      bandCaption := Lines[0] + '|';
      if Lines.Count = 1 then
      begin
        col := GridView.CreateColumn;
        col.Position.BandIndex := band.Index;
        col.DataBinding.FieldName := cds.Fields[i].FieldName;
      end;
      bands.Add(bandCaption, band);
    end;
    FreeAndNil(Lines);
  end;
  for i := 0 to fieldCount - 1 do
  begin
    Lines := TStringList.Create;
    ExtractStrings(['|'], [], PChar(cds.Fields[i].FieldName), Lines);
    for j := 1 to Lines.Count - 1 do
    begin
      band := GridView.Bands.Add;
      band.Caption := Lines[j];
      bandCaption := '';
      for k := 0 to j - 1 do
      begin
        bandCaption := bandCaption + Lines[k] + '|';
      end;
      if bands.TryGetValue(bandCaption, band1) then
      begin
        band.Position.BandIndex := band1.Position.Band.Index;
      end;
      bandCaption := '';
      for k := 0 to j do
      begin
        bandCaption := bandCaption + Lines[k] + '|';
      end;
      if Lines.Count - 1 = j then
      begin
        col := GridView.CreateColumn;
        col.Position.BandIndex := band.Index;
        col.DataBinding.FieldName := cds.Fields[i].FieldName;
        ;
      end;
      bands.Add(bandCaption, band);
    end;
    FreeAndNil(Lines);
  end;
  GridView.EndUpdate;
end;
```
