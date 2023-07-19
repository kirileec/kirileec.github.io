title: Windows Service hosting HTTP based services using Nancy
date: "2016-10-22 18:53:00"
update: ""
author: me
tags:
- WINDOWS-CSharp
categories:
- WINDOWS-CSharp
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
public partial class SaturnAPIService : ServiceBase
    {
        NancyHost host;
        public SaturnAPIService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            //necessary because of Namespace Reservations
            var config = new HostConfiguration() { RewriteLocalhost = true, UrlReservations = new UrlReservations() { CreateAutomatically = true } };

            host = new NancyHost(config, new Uri("http://localhost:1234"));
            
            host.Start();
            
        }

        protected override void OnStop()
        {
            host.Stop();
        }
```
refer to 
> https://github.com/NancyFx/Nancy/wiki/Self-Hosting-Nancy
