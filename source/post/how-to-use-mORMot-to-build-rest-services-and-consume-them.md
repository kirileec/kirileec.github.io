title: How to Use mORMot to Build Rest Services and Consume Them
date: "2018-07-26 13:35:35"
update: ""
author: me
tags:
- mORMot
- Rest
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



# 如何使用mORMot构建Rest服务并使用

## 服务端

```pascal
var
  FModel: TSQLModel;
  FDB: TSQLRestServer;
  FServer: TSQLHttpServer;

    //Create Server
    FModel := TSQLModel.Create([], 'api');
    FDB := TSQLRestServerFullMemory.Create(FModel, 'test.json', false, false);
    //reg services
    FDB.ServiceRegister(TTestService, [TypeInfo(ITestService)], sicShared);

    //setting and start it
    FServer := TSQLHttpServer.Create(httpPort, [FDB], '+',
    useHttpApiRegisteringURI);
    FServer.AccessControlAllowOrigin := '*'; // allow cross-site AJAX queries

```

### 接口和DTO单元

```pascal
type
  TTest = record
    A, B: string;
  end;

  TTest1 = class(TPersistent)
  private
    fB: string;
    fA: string;
  published
    property A: string read fA write fA;
    property B: string read fB write fB;
  end;

  ITestService = interface(IInvokable)
    ['{85B34854-522A-4218-A66C-4E2C274BD318}']
    function TestMethod(const D: TTest): TServiceCustomAnswer;
    procedure Fuck(const D: TTest; out r: TTest1);
  end;

//初始化的时候注册一下
initialization
  TInterfaceFactory.RegisterInterfaces([TypeInfo(IClockService)]);
```

### 服务类

```pascal
  TTestService = class(TInterfacedObject, ITestService)
  public
  published
    function TestMethod(const D: TTest): TServiceCustomAnswer;
    procedure Fuck(const D: TTest; out r: TTest1);
  end;

implementation

function TTestService.TestMethod(const D: TTest): TServiceCustomAnswer;
begin
  Result.Status := 200;

  Result.Content := '{"A":"sdsdsd","B":"sdsfdgfsweeed"}';
end;

procedure TTestService.Fuck(const D: TTest; out r: TTest1);
begin

  r.A := 'Hellsinsidn';
  r.B := 'sdwfgfgf';
end;

{ TTest1 }

end.

```

正常实现接口方法并编写逻辑处理代码即可, 返回值为 `TServiceCustomAnswer` 的话就可以返回自定义的JSON内容给客户端

## 客户端

```pascal
//定义几个常量
const
  ROOM_NAME = 'api';
  SERVICE_503 = 'HTTP服务不可用';
type
  // 配置一下服务器
  TServiceConfig = record
    Host:string;
    Port:string;
    /// <summary>
    ///   载入配置
    /// </summary>
    procedure LoadConf;
  end;  
//小小地封装一下, 方便调用
TSOAClient = class(TPersistentWithCustomCreate)
  private
    Client: TSQLHttpClient;
    Model: TSQLModel;
    Config: TServiceConfig;
    /// <summary>
    ///   注册服务接口
    /// </summary>
    procedure RegServices;
  public
    /// <summary>
    ///   创建SOA客户端实例
    /// </summary>
    /// <param name="pvConfig">
    ///   配置
    /// </param>
    constructor Create(pvConfig: TServiceConfig);
    destructor Destory; overload;

    /// <summary>
    ///   取得接口实例
    /// </summary>
    /// <param name="I">
    ///   接口
    /// </param>
    /// <param name="obj">
    ///   返回接口实例
    /// </param>
    /// <returns>
    ///   是否成功
    /// </returns>
    function Get(I: TGUID; out obj): Boolean;
  end;

implementation

function TSOAClient.Get(I: TGUID; out obj): Boolean;
begin
  Result := Client.Services.Resolve(I, obj);
end;

destructor TSOAClient.Destory;
begin
  FreeAndNil(Client);
  FreeAndNil(Model);
end;

procedure TSOAClient.RegServices;
begin
  //  Client.ServiceRegister([TypeInfo(ITestService)],sicShared);
  Client.ServiceDefine([ITestService
  //新接口注册在这里


  ], sicShared);
end;

constructor TSOAClient.Create(pvConfig: TServiceConfig);
begin
  Config := pvConfig;
  Model := TSQLModel.Create([], ROOM_NAME);
  Client := TSQLHttpClient.Create(Config.Host, Config.Port, Model);
  RegServices;
end;  


```

### 调用

```pascal
var
  c:TSOAClient;
  conf:TServiceConfig;
  I:ITestService;
begin
  Result := False;
  conf.LoadConf;

  try
    c := TSOAClient.Create(conf); //创建连接客户端 连接到HTTP服务
  except
    on E: Exception do
    begin
      // SERVICE_503
      Exit;
    end;
  end;
  try
    if c.Get(ITestService,I) then
    begin
      //这里进行随意的调用即可
      //I.Fuck
    end;

  finally
    FreeAndNil(c);
  end;
end;
```

如果返回 TServiceCustomAnswer, 那就用正常的HTTP组件去调用, 然后自行处理返回的body即可

小结: 这种模式我觉得很适合把Delphi的DataSnap改造成这种形式,
一方面可以享受到http.sys的高效, 另一方面这种基于接口的编程方式, 可以完全脱离代理类的那套流程
