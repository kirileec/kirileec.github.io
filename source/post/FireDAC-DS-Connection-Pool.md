title: FireDAC DataSnap Connection Pool
date: "2018-08-30 13:58:21"
update: ""
author: me
tags:
- Delphi
- FireDAC
- Pool
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



First use these units as follows. Of course, also need some other units

```pascal
uses
  SysUtils, Classes,
  DB,Variants, Windows, Math,
  System.IniFiles,
  SynCommons,
  IPPeerClient,
  FireDAC.Comp.Client,
  FireDAC.Phys.DS,
  FireDAC.Comp.UI,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Util,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool ,
  FireDAC.Stan.Error,
  FireDAC.Stan.Intf,
  Datasnap.DSHTTPLayer;
```

then we need a record to read configs, you can implement it as you like

```pascal
  TDSPoolConfig = record
    CleanupTimeout: string;
    ExpireTimeout: string;
    MaximumItems: string;
    Server: string;
    Port: string;
    DSUserName, DSPassword: string;
    IsHttpClient:Boolean;
    procedure ReadConfig;
  end;
```  

ok, now come the pool

```pascal
TDSConnectionPool = class(TComponent)
  const
    POOL_DEFNAME = 'POOL';
  private
    DSLink: TFDPhysDSDriverLink;
    WaitCursor:TFDGUIxWaitCursor;
    fIsReConn: Boolean;
    Config:TDSPoolConfig;
    function GetCount: Integer;
    procedure LiftUp;
    procedure ShutDown;
    procedure OnError(ASender, AInitiator: TObject; var AException: Exception);
    procedure OnRecover(ASender, AInitiator: TObject;AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
    procedure OnRestored(ASender:TObject);
    procedure OnLost(ASender:TObject);
  public
    constructor Create; overload;
    destructor Destroy; override;
    function Lock: TFDConnection;
    procedure WriteParams;
    property Count:Integer read GetCount;
    // if true the connection is not active
    property IsReConn:Boolean read fIsReConn write fIsReConn;
  end;
```

my implementation

```pascal
constructor TDSConnectionPool.Create;
begin
  DSLink := TFDPhysDSDriverLink.Create(self);
  WaitCursor := TFDGUIxWaitCursor.Create(self);
  Config.ReadConfig;
  LiftUp;
end;

destructor TDSConnectionPool.Destroy;
begin
  ShutDown;
  FDFreeAndNil(DSLink);
  FDFreeAndNil(WaitCursor);
  inherited;
end;

function TDSConnectionPool.Lock: TFDConnection;
begin
  Result := TFDConnection.Create(nil);
  Result.ConnectionDefName := POOL_DEFNAME;
  // make some different actions for main thread and other thread
  if GetCurrentThreadID = MainThreadID then
  begin
    Result.OnRecover := OnRecover;
    Result.OnRestored := OnRestored;
  end
  else
  begin
    Result.OnRecover := OnRecoverIgnore;
    Result.OnRestored := OnRestored;
  end;
end;

function TDSConnectionPool.GetCount: Integer;
begin
  Result := FDManager.ConnectionCount;
end;

procedure TDSConnectionPool.LiftUp;
var
  oParams: TStrings;
begin
  oParams := TStringList.Create;
  oParams.Add('DriverID=DS');
  oParams.Add('Server='+ Config.Server);
  oParams.Add('Port='+  Config.Port);
  oParams.Add('Pooled='+  'True');
  oParams.Add('POOL_CleanupTimeout='+  Config.CleanupTimeout);
  oParams.Add('POOL_ExpireTimeout='+  Config.ExpireTimeout);
  oParams.Add('POOL_MaximumItems='+  Config.MaximumItems);
  // also can support http protocol
  if Config.IsHttpClient then
    oParams.Add('Protocol='+  'http')
  else
    oParams.Add('Protocol='+  'tcp/ip');

  //oParams.Add('LoginTimeout='+'2000');
  //oParams.Add('CommunicationTimeout='+'2000');
  oParams.Add('User_Name='+  Config.DSUserName);
  oParams.Add('Password='+  Config.DSPassword);

//  FDManager.ResourceOptions.AutoReconnect := True;
  FDManager.AddConnectionDef(POOL_DEFNAME, 'DS', oParams);
  FreeAndNil(oParams);

  FDManager.Active := True;
end;

// may be used to write out params to file for debug
procedure TDSConnectionPool.WriteParams;
begin
 FileFromString(RecordSaveJSON(Config,TypeInfo(TDSPoolConfig)),
   ExtractFilePath(ParamStr(0))+'ConnParam.connection',True);
end;

procedure TDSConnectionPool.ShutDown;
begin
  FDManager.CloseConnectionDef(POOL_DEFNAME);
  FDManager.Close;
end;

procedure TDSConnectionPool.OnError(ASender, AInitiator: TObject;
  var AException: Exception);
begin
  // log error
end;

procedure TDSConnectionPool.OnRecover(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  IsReConn := True;

  // set global flag
  if ReConnectionCount = 0 then
  begin
    ReConnectionCount := ReConnectionCount + 1;
  end
  else
  begin
    ReConnectionCount := ReConnectionCount + 1;
  end;
  AAction := faFail; // if set to faRetry, this event will be triggered many times
end;

procedure TDSConnectionPool.OnRestored(ASender: TObject);
begin
  IsReConn := False;
  // set global flag
  if ReConnectionCount > 0 then
  begin
    ReConnectionCount := 0;
  end
  else
  begin
    ReConnectionCount := 0;
  end;
end;

procedure TDSConnectionPool.OnLost(ASender: TObject);
begin
  // notify to handle connection lost. only when faRetry
end;

procedure TDSConnectionPool.OnRecoverIgnore(ASender, AInitiator: TObject;
  AException: Exception; var AAction: TFDPhysConnectionRecoverAction);
begin
  // can do something different here when get connection in a thread

  IsReConn := True;
  // set global flag
  if ReConnectionCount = 0 then
  begin
    ReConnectionCount := ReConnectionCount + 1;
  end
  else
  begin
    ReConnectionCount := ReConnectionCount + 1;
  end;
  AAction := faFail;
end;

```
