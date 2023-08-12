title: OmniThreadLibrary  TASK任务和消息监听
date: "2015-11-15 13:47:00"
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
    uses OtlCommon,OtlParallel,OtlEventMonitor,OtlTask,OtlTaskControl,OtlComm;
    //主线程中的消息处理
    procedure TForm1.OmniEventMonitor1TaskMessage(const task: IOmniTaskControl;
      const msg: TOmniMessage);
    begin
       case msg.MsgID of
         1:ClientDataSet2.Open;
         2:Label1.Caption := 'start';
         3:Label1.Caption :='end';
         4:Label1.Caption := 'sleep';
       end;
    end;
    //任务创建
    procedure TForm1.Button5Click(Sender: TObject);
    begin
      FTASK:=OmniEventMonitor1.Monitor(CreateTask(GetAll,'GetAll')).Run ;
    end;
    //任务体
    procedure GetAll(const task:IOmniTask); //参数必须是这样子
    var
      aa:TClientRuleClient;
      f:OleVariant;
    begin
      task.Comm.Send(2,'start');
      Form1.ClientDataSet2.Close;
      aa:=TClientRuleClient.Create(Form1.SQLConnection1.DBXConnection);
      f:= aa.GetAll;
      FreeAndNil(aa);
      Form1.ClientDataSet2.Data := f;
    
      task.Comm.Send(4,'sleep');
      Sleep(3000);
      task.Comm.Send(3,'end');
      task.Comm.Send(1,'task terminated');
    end;
```
