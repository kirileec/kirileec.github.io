title: cxGird adding footer dynamically
date: "2016-12-24 22:19:00"
update: ""
author: me
tags:
- delphi
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
    if dbgehMainDBTableView1.DataController.DataSet.Fields[i].DataType = ftFloat then
    begin
      cxGridDBTableSummaryItem := dbgehMainDBTableView1.DataController.Summary.FooterSummaryItems.Add as TcxGridDBTableSummaryItem;
      cxGridDBTableSummaryItem.Column := dbgehMainDBTableView1.columns[i];
      cxGridDBTableSummaryItem.FieldName := dbgehMainDBTableView1.DataController.DataSet.Fields[i].DisplayName;
      cxGridDBTableSummaryItem.Kind := skSum;
    end;
```
