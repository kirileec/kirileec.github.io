title: influxdb v1 export and import data
date: 2023-03-30 17:25:41 +0800
update: ""
author: linx
tags: []
categories: []
topic: ""
cover: ""
draft: false
preview: ""
top: false
type: post
hide: false
toc: false
image: ""
subtitle: ""
config: {}


---



# InfluxDB 导出和导入数据

## 导出
```
.\influx_inspect.exe export -datadir "C:\Windows\System32\config\systemprofile\.influxdb\data" -waldir "C:\Windows\System32\config\systemprofile\.influxdb\wal" -out "database_export" -database database_export 
```


## 导入
```
.\influx.exe -import -path ""
```
