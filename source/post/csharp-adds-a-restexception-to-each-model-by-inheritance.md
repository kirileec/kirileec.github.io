title: csharp 通过继承为每个Model添加一个restException
date: "2016-12-04 22:07:00"
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



## RestBase

```c#
public abstract class RestBase
{
    public GlobalError restException {get;set;}
}
```

如此， 此类的子类都有了类型为 `GlobalError` 的 `restException` 字段

在使用RestSharp进行REST请求时， 如果发生异常， 一般会将错误以 GlobalError 这样的统一的形式返回，那么在

```c#
            request.OnBeforeDeserialization = (resp) =>
            {
                if (((int)resp.StatusCode) >= 400)
                {
                    string restException = "{{ \"restException\" : {0} }}";  //注意这行， 修改了返回的内容
                    var content = resp.RawBytes.AsString(); //get the response content
                    var newJson = string.Format(restException, content);

                    resp.Content = null;
                    resp.RawBytes = Encoding.UTF8.GetBytes(newJson.ToString());
                }
            };
```
