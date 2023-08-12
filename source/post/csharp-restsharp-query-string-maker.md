title: 'csharp RestSharp query string maker '
date: "2016-12-19 23:17:00"
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



```c#
using RestSharp.Extensions.MonoHttp;

    public static class ExQueryString
    {
        public static string GetQueryString(this object obj)
        {
            var properties = from p in obj.GetType().GetProperties()
                             where p.GetValue(obj, null) != null
                             select p.Name + "=" + HttpUtility.UrlEncode(p.GetValue(obj, null).ToString());

            return string.Join("&", properties.ToArray());
        }
    }
```
