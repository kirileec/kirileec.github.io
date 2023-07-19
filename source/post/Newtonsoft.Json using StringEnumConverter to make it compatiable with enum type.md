title: Newtonsoft.Json using StringEnumConverter to make it compatiable with enum
  type
date: "2016-12-19 23:07:00"
update: ""
author: me
tags:
- CSharp-WPF
categories:
- CSharp-WPF
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



forgive my poor english
for example: 
A java enum like
```java
public enum SomeTypeEnum {
    A(0),B(1),C(2);

    private int value;
    SomeTypeEnum(int value){
      this.value = value;
    }
    public int getValue(){
      return value;
    }
}
```
may be map to 
```json
{"someType":"A"}
```

then it can only be deserialized to string Type

however when we do this
```c#
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;

public enum SomeType
{
   A=0,B=1,C=2
}
public class SomeTypeTest
{
    [JsonConverter(typeof(StringEnumConverter))]
    public SomeType someType {get;set;}
}
```

it's OK whatever do deserializing or serializing, nothing else should be care, just do it!!
