title: 使用一个数字存储很多状态
date: 2017-06-08 19:07:47 +0800
update: ""
author: me
tags:
- Delphi
- set
- Delphi-XE8
categories:
- Delphi-XE8
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



假设这样一种情景，一个界面上几十个CheckBox，每个都表示某个选项的启用或不启用，并且这些选项都需要存储起来。
那么怎么做呢？每个都创建一个字段存储起来？那如果选项很多呢？

又或者设计一个权限系统。。。

二进制的世界是美妙的，门就两个状态，开或者关。用二进制表示的话就是1和0 .

Delphi中， set集合本身就是以一个数字存储起来的

```pascal
  TSwitchStatus2 = set of (
    WindowOpen,
    WindowPause,
    WindowClose,
    AirConditionHigh,
    AirConditionMedium,
    AirConditionLow,
    AirConditionOpen,
    AirConditionClose);
```
```pascal
function SetToBin(p: PByteArray; size: Integer): UInt8;
var
  i,j: Integer;
  function SetBit(const X, N: integer): integer;
  asm
        bts     eax, edx
  end;
begin
  Result := 0;
  for i := 0 to size - 1 do
    for j := 0 to 7 do
      if Odd(p^[size - 1 - i] shr j) then
        Result := SetBit(Result, i * 8 + 8 - j);
end;
```

以上代码可以将一个最大容量为8的集合转换为一个8位的十进制值

```pascal
  SetToBin(@pvSwitchStatus, SizeOf(TSwitchStatus2));
```

其实这里的8位的意思是，这个值最大为
11111111 (无符号), 当然也可以写出 16位甚至64位的方法，那样就可以存储更多的状态。

当一个集合变量拥有了某个状态， 那么对应的二进制的对应位置的值就为1，否则为0

转换出来的数值可以直接存储，这样就实现了，一个字段就存储了8个状态。

当然还是需要转换回来的啦

```pascal
  Byte(switchStatus2) := DataFrame.Data[4];
```

那么接下来就可以使用in语法来判断某个状态是否开启了， 或者写个算法，做一下移位，然后用odd判断一下也可以（这样比较快）

当然了， 如果需要存储的状态并没有太大的关联性， 那么某种意义上来说， 并不适合存放在一起的


对于权限系统来说，可以将权限归类，每个类别限制在较少的数量，如此一来，一组权限只需要一个数字就行了

那么如果，真的很多权限呢？ 那么只要把一个数拆分为好几个部分即可，拆两半的话就一个高位一个低位即可
