title: OmniThreadLibrary 传递数据
date: "2015-11-15 14:54:00"
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
       case msg.MsgID of
         1:
         begin
            ClientDataSet2.Data := msg.MsgData.AsVariant;
            ClientDataSet2.Open;
         end;
         2:Label1.Caption := 'start';
         3:Label1.Caption :='end';
         4:Label1.Caption := 'sleep';
       end;
```
```pascal
    procedure GetAll( const task:IOmniTask);
    var
      aa:TClientRuleClient;
      f:OleVariant;
      msgData: TOmniValue;
      msgID  : word;
    begin
      task.Comm.Send(2,'start');
      Form1.ClientDataSet2.Close;
      aa:=TClientRuleClient.Create(Form1.SQLConnection1.DBXConnection);
      f:= aa.GetAll;
      FreeAndNil(aa);
     // Form1.ClientDataSet2.Data := f;
      if task.Comm.Receive(msgID,msgData) then begin
         if msgID = 0 then Exit;
      end;
      task.Comm.Send(4,'sleep');
      Sleep(3000);
    
      task.Comm.Send(3,'end');
      task.Comm.Send(1, tomnivalue.CastFrom(f));
    end;
```
