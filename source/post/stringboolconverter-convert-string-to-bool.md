title: StringBoolConverter Convert string to bool
date: "2016-12-19 22:52:00"
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



```c#
public class StringBoolConverter : JsonConverter
    {
        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            writer.WriteValue(((bool)value) ? "TRUE" : "FALSE");
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            return reader.Value.ToString() == "TRUE";
        }

        public override bool CanConvert(Type objectType)
        {
            return objectType == typeof(bool);
        }
    }
```
### Usage

```c#
using Newtonsoft.Json;

public class Test
{
    [JsonConverter(typeof(StringBoolConverter))]
    public bool A {get;set;}
}

var test = new Test(){A=true};
JsonConvert.SerializeObject(test);
=>>  {"A":"TRUE"}

//this can be supported default
JsonConvert.DeserializeObject(
         @"{""A"":""TRUE""}"
        );
```
