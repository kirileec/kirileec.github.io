title: phpstorm XDebug调试PHP
date: "2016-02-14 20:06:00"
update: ""
author: me
tags:
- WEB
categories:
- WEB
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



环境:

> - phpStudy 2016
> - phpstorm
> - Chrome

流程:

**phpstudy**

`其他选项菜单`->`PHP扩展及设置`->`PHP扩展`->`Xdebug`

`其他选项菜单`->`打开配置文件`->`php-ini`

修改自动生成的内容如下

```ini
[XDebug]
xdebug.profiler_append = 0
xdebug.profiler_enable = 1
xdebug.profiler_enable_trigger = 0
xdebug.profiler_output_dir ="D:\phpstudy\tmp\xdebug"
xdebug.trace_output_dir ="D:\phpstudy\tmp\xdebug"
xdebug.profiler_output_name = "cache.out.%t-%s"
xdebug.remote_enable = 1
xdebug.remote_handler = "dbgp"
xdebug.remote_host = "127.0.0.1"
xdebug.remote_port = 9001
xdebug.idekey = PHPSTORM
zend_extension="D:\phpstudy\php53\ext\xdebug.dll"
```
OK重启Apache

**phpstorm**

`File`->`Setting`->`Language & Framworks`->`PHP`

`Servers`
添加一个服务器
```yaml
Name:localhost
Host:localhost
Port:80
Debugger:Xdebug
```
`Debug`->`Xdebug`
```yaml
Debug port:9001 
```
`Debug`->`DBGp Proxy`
```yaml
IDE Key:PHPSTORM
Host:127.0.0.1
Port:80
```



两种方法进行调试:
1. `Shift`+`F9`
2. 
- Chrome安装`xdebug helper`,并配置好
- 点击界面右上角 `Start Listening for PHP Debug Connections`
- 访问`localhost`


PS:

- 如果发现基于MySQL的PHP程序异常慢, 请把代码中或程序配置中的`localhost`改为`127.0.0.1`
