title: RestSharp Manually Add Json String To Body
date: "2016-11-02 22:00:00"
update: ""
author: me
tags:
- CSharp
categories:
- CSharp
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



```csharp
request.AddParameter("application/json", jsonStr, ParameterType.RequestBody); 
```

Somtimes when you use 
```csharp
request.AddJsonBody(object);
```
to add Json body will result in data losing.
eg. 
A Class like this
```csharp
public class ReportMessage
{
    public string reportName {get;set;}
    public string dataSetName {get;set;}
    public List<dynamic> data {get;set;}
}
```
may be serialized to 
```jsonp
{\"reportName\":\"aaa.frx\",
\"dataSetName\":\"data\",
\"data\":[\"filed1\":\"field1data\",\"field2\":\"field2data\"}]
}
```
or 
```json
{"reportName":"aaa.frx",
"dataSetName":"data",
"data":[{"filed1":"field1data","field2":"field2data"},
{"filed3":"field1data","field4":"field2data"},
{"filed5":"field1data","field6":"field2data"}
]
}
```
when I POST that to a Nancy Host using PostMan or Fiddler, it can be deserilized OK. But When Post it using RestSharp with AddJsonBody, then
```json
{"reportName":"aaa.frx",
"dataSetName":"data",
"data":[
{},{},{}
]
}
```
the data disappeared.
