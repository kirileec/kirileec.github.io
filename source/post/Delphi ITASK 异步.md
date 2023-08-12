title: Delphi ITASK 异步
date: "2015-11-15 13:51:00"
update: ""
author: me
tags:
- delphi
categories:
- delphi
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



    TTask.Run(
        procedure
        var
          aa: TClientRuleClient;
        begin
          aa := TClientRuleClient.Create(SQLConnection1.DBXConnection);
          ClientDataSet1.Data := aa.GetAll;
          ClientDataSet1.Open;
          FreeAndNil(aa);
        end
    );
