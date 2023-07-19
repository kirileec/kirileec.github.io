title: SynLog日志组件捕获成吨可调试异常
date: "2017-12-16 21:54:30"
update: ""
author: me
tags: []
categories: []
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



> 工程设置(Release or Debug)
> Delphi Compiler -> Linking -> Map file -> Detailed
> Delphi Compiler -> Compiling -> Debug information -> Debug information

```pascal
{*******************************************************}
{                                                       }
{           工程: 短信专业版                            }
{       单元功能: 日志类                                }
{           作者: Linx                                  }
{           时间: 2017-12-10 17:29:47                   }
{                                                       }
{       版权所有 (C) 2017 Soesoft                       }
{                                                       }
{*******************************************************}

unit SMSPro.Log.Logger;

interface

uses
  System.SysUtils,
  Vcl.ComCtrls,
  Data.DBXCommon;

type
  TSMSLogger = class
  public
    class procedure InitSynLog();
    function GetCurLogFileName:string;
  end;

implementation

uses
  SynLog,
  SynCommons;

{ TSoeLogger }

class procedure TSMSLogger.InitSynLog;
begin
  ForceDirectories('.\log\smspro');
  TSynLog.Family.Level := LOG_VERBOSE;
  TSynLog.Family.Level := [sllException, sllExceptionOS,sllInfo,sllError,sllEnter];
  TSynLog.Family.LocalTimeStamp := True;
  //不记录环境变量
  TSynLog.Family.NoEnvironmentVariable := True;
  //记录单元名
  TSynLog.Family.WithUnitName := True;
  //行结尾符号
  TSynLog.Family.EndOfLineCRLF := True;
  TSynLog.Family.DestinationPath := '.\log\smspro\';
  //TSynLog.Family.PerThreadLog := true;
  //TSynLog.Family.HighResolutionTimeStamp := true;
  //TSynLog.Family.AutoFlushTimeOut := 5;
  //TSynLog.Family.StackTraceUse := stOnlyAPI;
  //lz压缩
  TSynLog.Family.OnArchive := EventArchiveSynLZ;
  //TSynLog.Family.OnArchive := EventArchiveZip;
  TSynLog.Family.ArchiveAfterDays := 7; // archive after one day
  TSynLog.Family.RotateFileSizeKB := 10240;
  TSynLog.Family.RotateFileDailyAtHour := 20;
  //忽略的异常（只是不记录到日志里）
  TSynLog.Family.ExceptionIgnore.Add(TDBXError);
  TSynLog.Family.ExceptionIgnore.Add(EOSError);
end;

function TSMSLogger.GetCurLogFileName: string;
begin
  Exit(TSynLog.Add.FileName);
end;

end.
```
