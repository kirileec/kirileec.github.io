title: 以JSON作为配置文件
date: "2017-12-16 21:42:40"
update: ""
author: me
tags:
- SynCommons
- config
- mORMot
categories:
- mORMot
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



代码如下

其实我一直有个疑问， 为什么github上很多的配置库基本上都是只读的，并没有提供写配置的方法，因为如果可以实时地修改某个配置项的话就会很方便了。
我这个版本是直接更新整个文件的. 另外CnPack里有个根据Ini配置文件生成读写单元的功能， 但是我认为如果配置文件里需要加入新的配置项的话依然会很不方便（需要重新生成）

```pascal
{*******************************************************}
{                                                       }
{           工程: 短信专业版                             }
{       单元功能: 配置管理                               }
{           作者: Linx                                  }
{           时间: 2017-12-10 17:26:50                   }
{                                                       }
{       版权所有 (C) 2017 soesoft                       }
{                                                       }
{*******************************************************}

unit SMSPro.Base.JSONConfig;

interface

uses
  System.SysUtils,
  SynCommons,
  Vcl.Dialogs;
const
  CONFIG_FILENAME = 'SMS.json';
type
  TParam = record
    name: string;
    description: string;
    field: string;
    hdwms_sms_type: string;
    demo:string;
  end;

  TParamDynArray = array of TParam;

  TTemplate = record
    sms_template_code: string;
  end;

  TSMSConfig = record
    account: record
      username: string;
      password: string;
    end;
    pageSize:Integer;
    log:Boolean;
    api: record
      baseUri: string;
      sendApi: string;
      checkApi: string;
      templatesApi: string;
      templateApi:string;
      listDetail: string;
    end;
    params: array of TParam;
    template: TTemplate;
    procedure LoadFromFile(pvFileName: string = '');
    function SaveToFile(pvFileName: string = ''): Boolean;
    procedure SaveDefaultToFile();
    function DecodeFile(pvFileName: string = ''):Boolean;
    function EncodeFile(pvFileName:string = ''):Boolean;
  end;

procedure LoadConfig;

function Config: TSMSConfig;

var
  SMSConfig: TSMSConfig;

implementation

uses
  System.IOUtils;

procedure LoadConfig;
begin
  SMSConfig.LoadFromFile();
end;

function Config: TSMSConfig;
begin
  Result := SMSConfig;
end;

procedure TSMSConfig.SaveDefaultToFile();
var
  lvFileName: string;
  configContent: RawJSON;
begin
  lvFileName := ExtractFilePath(ParamStr(0)) + CONFIG_FILENAME;
  configContent := RecordSaveJSON(Self, TypeInfo(TSMSConfig));
  TFile.WriteAllText(lvFileName, configContent);
end;


function TSMSConfig.SaveToFile(pvFileName: string = ''): Boolean;
var
  lvFileName: string absolute pvFileName;
  configContent: RawJSON;
  IfSaveBase64:Boolean;
begin
  Result := True;
  try
    if lvFileName = '' then
    begin
      lvFileName := ExtractFilePath(ParamStr(0)) + CONFIG_FILENAME;
    end;
    if not FileExists(lvFileName) then
    begin
      IfSaveBase64 := True;
    end
    else
    begin
      configContent := TFile.ReadAllText(lvFileName);
      IfSaveBase64 := IsBase64(configContent);
    end;

    if IfSaveBase64 then
    begin
      configContent := RecordSaveBase64(Self,TypeInfo(TSMSConfig));
    end
    else
    begin
      configContent := RecordSaveJSON(Self, TypeInfo(TSMSConfig));
    end;

    TFile.WriteAllText(lvFileName, configContent,TEncoding.UTF8);
  except
    Result := False;
  end;

end;

procedure TSMSConfig.LoadFromFile(pvFileName: string = '');
var
  lvFileName: string absolute pvFileName;
  configContent: RawJSON;
begin
  if lvFileName = '' then
  begin
    lvFileName := ExtractFilePath(ParamStr(0)) + CONFIG_FILENAME;
  end;
  if TFile.Exists(lvFileName) then
  begin

    configContent := AnyTextFileToRawUTF8(lvFileName, True);

    if IsBase64(configContent) then
    begin
      if not RecordLoadBase64(PAnsiChar(configContent), Length(configContent), Self,
        TypeInfo(TSMSConfig)) then
      begin
        ShowMessage('读取短信配置失败');
      end;
    end
    else
    begin
      if not RecordLoadJson(Self, configContent, TypeInfo(TSMSConfig)) then
      begin
        ShowMessage('读取短信配置失败');
      end;
    end;
  end
  else
  begin
    ShowMessage('短信配置文件SMSPro.json不存在');
  end;
end;

function TSMSConfig.DecodeFile(pvFileName: string = ''):Boolean;
var
  lvFileName: string absolute pvFileName;
  configContent: RawJSON;
  tmp:TSMSConfig;
begin
  Result := False;
  if lvFileName = '' then
  begin
    lvFileName := ExtractFilePath(ParamStr(0)) + CONFIG_FILENAME;
  end;
  if not FileExists(lvFileName) then
  begin
    Exit;
  end
  else
  begin
    configContent := AnyTextFileToRawUTF8(lvFileName, True);
  end;

  if IsBase64(configContent) then
  begin
    if RecordLoadBase64(PAnsiChar(configContent), Length(configContent), tmp, TypeInfo(TSMSConfig)) then
    begin
      configContent := RecordSaveJSON(tmp, TypeInfo(TSMSConfig));
      Result := True;
    end;
  end
  else
  begin
    Exit(True);
  end;

  TFile.WriteAllText(lvFileName, configContent, TEncoding.UTF8);
end;

function TSMSConfig.EncodeFile(pvFileName:string = ''):Boolean;
var
  lvFileName: string absolute pvFileName;
  configContent: RawJSON;
  tmp:TSMSConfig;
begin
  Result := False;
  if lvFileName = '' then
  begin
    lvFileName := ExtractFilePath(ParamStr(0)) + CONFIG_FILENAME;
  end;
  if not FileExists(lvFileName) then
  begin
    Exit;
  end
  else
  begin
    configContent := AnyTextFileToRawUTF8(lvFileName, True);
  end;

  if not IsBase64(configContent) then
  begin
    if RecordLoadJSON(tmp, configContent, TypeInfo(TSMSConfig)) then
    begin
      configContent := RecordSaveBase64(tmp, TypeInfo(TSMSConfig));
      Result := True;
    end;
  end
  else
  begin
    Exit(Result);
  end;

  TFile.WriteAllText(lvFileName, configContent, TEncoding.UTF8);
end;


initialization
  LoadConfig;

finalization

end.

```
