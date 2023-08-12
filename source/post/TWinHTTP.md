title: TWinHTTP
date: "2017-12-31 18:07:44"
update: ""
author: me
tags:
- mORMot
- Delphi
categories:
- mORMot
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
uses
  SynCrtSock;

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  mmo1.Lines.Add( TWinHTTP.Get('https://www.baidu.com'));
end;
```
静态调用
