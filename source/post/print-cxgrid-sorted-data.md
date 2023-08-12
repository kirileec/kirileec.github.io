title: Print cxgrid sorted data
date: "2016-12-24 22:18:00"
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
procedure Print();
var
  AscFields, DescFields, S: string;
  IndexPrint: string;
  I: integer;
  Index: integer;
  cds: TClientDataSet;
begin
  S := '';
  AscFields := '';
  DescFields := '';
  IndexPrint := 'GoodsSaleReportIndex';

  if (cxgrdbtvGoodsSaleReport.DataController.DataSource.DataSet is TClientDataSet) then
  begin
    Cds := cxgrdbtvGoodsSaleReport.DataController.DataSource.DataSet as TClientDataSet;
    for I := 0 to cxgrdbtvGoodsSaleReport.SortedItemCount - 1 do
    begin
      Index := cxgrdbtvGoodsSaleReport.SortedItems[I].Index;
      S := cxgrdbtvGoodsSaleReport.Columns[Index].DataBinding.Field.FieldName + ';';
      AscFields := AscFields + S;
      if cxgrdbtvGoodsSaleReport.SortedItems[I].SortOrder = soDescending then
        DescFields := DescFields + S ;
    end;

    cds.IndexDefs.Update;
    if cds.IndexDefs.IndexOf(IndexPrint) >= 0 then
    begin
      cds.DeleteIndex(IndexPrint);
    end;
    cds.AddIndex(IndexPrint, AscFields, [], DescFields);
    cds.IndexName := IndexPrint;
  end;
  self.PrintReport(); 
end;
```
