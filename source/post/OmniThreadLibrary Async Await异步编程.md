title: OmniThreadLibrary Async &Await异步编程
date: "2015-11-15 13:42:00"
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



```pascal
    uses OtlParallel;
    Label1.Caption :='waiting...';
    Async(
        procedure
        var
          aa: TClientRuleClient;
        begin
          aa := TClientRuleClient.Create(SQLConnection1.DBXConnection);
          ClientDataSet2.Data := aa.GetAll;
          FreeAndNil(aa);
        end)
    .Await(
        procedure
        begin
           ClientDataSet2.Open;
           Label1.Caption :='end'
        end
    );
```
将和UI操作无关的部分代码和操作UI相关的代码进行分离
