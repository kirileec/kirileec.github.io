title: OmniThreadLibrary 匿名事件监视
date: "2015-11-15 16:26:00"
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



```pascal
    FAnonTask := CreateTask(
        procedure (const task: IOmniTask) begin
          task.Comm.Send(0, Format('Hello, world! Reporting from thread %d',
            [GetCurrentThreadID]));
        end,
        'HelloWorld')
      .OnMessage(
        procedure(const task: IOmniTaskControl; const msg: TOmniMessage) begin
          lbLog.ItemIndex := lbLog.Items.Add(Format('%d:[%d/%s] %d|%s',
            [GetCurrentThreadID, task.UniqueID, task.Name, msg.msgID,
             msg.msgData.AsString]));
        end)
      .OnTerminated(
        procedure(const task: IOmniTaskControl) begin
          lbLog.ItemIndex := lbLog.Items.Add(Format('[%d/%s] Terminated',
            [task.UniqueID, task.Name]));
          btnHello.Enabled := true;
          FAnonTask := nil;
        end)
      .Run;
```
