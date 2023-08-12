title: Add Bark and Config
date: 2019-05-31 12:45:03 +0800
update: ""
author: linx
tags:
- qrFileTransfer
- go
categories:
- go
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


增加Bark推送以及json配置文件

<!--more-->

配置文件
---

配置文件类似如下

```json
{
  "port":1005,
  "db":{
    "dbPath":"qr.db",
    "timeout":1
  },
  "limit":{
    "maxSingleFileSize":102400,
    "maxFileCount":10,
    "expiredTime":"1h",
    "downloadLimit":-1,
    "canAccessWhenAllExpired":false
  },
  "bark":{
    "server":"http://IP:端口",
    "key":"你的key"
  }

}
```
然后可以使用 `https://mholt.github.io/json-to-go/` 等类似的服务转成struct

```go
type Config struct {
	Port int `json:"port"`
	Db struct {
		DbPath string `json:"dbPath"`
		Timeout int `json:"timeout"`
	} `json:"db"`
	Limit struct {
		MaxSingleFileSize int `json:"maxSingleFileSize"`
		MaxFileCount int `json:"maxFileCount"`
		ExpiredTime string `json:"expiredTime"`
		DownloadLimit int `json:"downloadLimit"`
		CanAccessWhenAllExpired bool `json:"canAccessWhenAllExpired"`
	} `json:"limit"`
	Bark struct {
		Server string `json:"server"`
		Key string `json:"key"`
	} `json:"bark"`
}
```
再写个方法, 搞个全局变量就能用了

```go
var (
	Cfg Config
)

func LoadConfig(file string) (err error) {
	var f *os.File
	f, err = os.Open(file)
	defer f.Close()
	if err != nil {
		return
	}
	jsonParser := json.NewDecoder(f)
	return jsonParser.Decode(&Cfg)
}
```
main.go里读取一下, 用 `-c /path/to/config.json`运行
```go
var (
	configFile string
)

func init() {
	flag.StringVar(&configFile, "c", "config.json", "config json file")
}

func main()  {
  config.LoadConfig(configFile)
}
```

Bark推送
---

这个就简单了, 当然要先把服务搭起来能用先

```go
package utils

import (
	"errors"
	"fmt"
	"net/http"
	"qrcodeTransferBox/config"
)

func SendBarkUrl(title string,url string) error {
	if (title == "" || url == "") {
		return errors.New("param cannot be empty")
	}
	link := fmt.Sprintf("%s/%s/点击下载[%s]?url=%s",config.Cfg.Bark.Server,config.Cfg.Bark.Key,title,url)
	go http.Get(link)
	return nil
}

func SendBarkMsg(content string) error {
	if (content == "") {
		return errors.New("param cannot be empty")
	}
	link := fmt.Sprintf("%s/%s/%s",config.Cfg.Bark.Server,config.Cfg.Bark.Key,content)
	go http.Get(link)
	return nil
}

```

主要实现两种方式, 一个是直接推送文本的消息, 另一个用于文件上传完成之后, 可以在手机上点击直接下载或者跳转到相应的pack网址
