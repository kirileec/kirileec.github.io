title: Delphi动态创建多个控件和设置圆角
date: "2014-04-16 18:06:00"
update: ""
author: me
tags:
- WINDOWS
categories:
- WINDOWS
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
type
TMyRect = record
    Top: Integer;
    Left: Integer;
    Width: Integer;
    Height: Integer;
    frame: TFrameCard;
  end;   //定义类
var
myre: array of TMyRect;  //定义类的数组，此处为动态
                        //数组，故使用前需要用SetLength设置
                        //数组元素个数
procedure XXXX
var
  Hrgn: THandle;
begin
  myre[i].frame := TFrameCard.Create(nil); //用循环存储创建的对象
  myre[i].frame.Top := myre[i].Top;
  myre[i].frame.Left := myre[i].Left;
  myre[i].frame.Width := myre[i].Width;
  myre[i].frame.Height := myre[i].Height;
  myre[i].frame.Parent := Main.ScrollBox1;  //设定归属和位置
  Hrgn := CreateRoundRectRgn(0, 0, myre[i].frame.Width,     myre[i].frame.height,20, 20);
  SetWindowRgn(myre[i].frame.Handle, Hrgn, true);
  DeleteObject(Hrgn);     //设置圆角
end;
```
