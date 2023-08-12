title: Use Mqtt With Golang and Angular6
date: 2018-12-27 21:34:31 +0800
update: ""
author: me
tags: []
categories: []
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



使用go作为MQTT服务端，angular作为客户端，进行消息交互

<!--more-->

GO服务端这边

- 需要能够监听MQTT Broker的tcp端口(默认:1883)
- 需要能够监听MQTT Websocket的 ws 端口
- 提供一个广播或者指定发送到某个客户端的方法

直接上代码

```go

package utils

import (
	"encoding/json"
	"fmt"
	"io"
	"net"
	"net/http"
	"net/url"

	log "github.com/soesoftcn/process-manage/pkg/soelog"
	"github.com/surgemq/message"
	s "github.com/surgemq/surgemq/service"
	"golang.org/x/net/websocket"
)

type ServerMessage struct {
	IsBroadCast bool        `json:"isBroadCast"`
	ClientId    string      `json:"clientId"`
	MsgType     int         `json:"msgType"`
	Msg         interface{} `json:"msg"`
}

var MqttSvr *s.Server

func InitMQTTServer() {
	MqttSvr = &s.Server{
		KeepAlive:        300,           // seconds
		ConnectTimeout:   2,             // seconds
		SessionsProvider: "mem",         // keeps sessions in memory
		Authenticator:    "mockSuccess", // always succeed
		TopicsProvider:   "mem",         // keeps topic subscriptions in memory
	}

	mqttaddr := "tcp://:1883"
	addr := "tcp://127.0.0.1:1883"
	AddWebsocketHandler("/mqtt", addr)
	wsAddr := ":1882"
	go ListenAndServeWebsocket(wsAddr)

	err := MqttSvr.ListenAndServe(mqttaddr)
	if err != nil {
		log.Logger.Sugar().Errorf("surgemq/main: %v", err)
	}
}

/* copy from reader to websocket, this copies the binary frames as is */
func io_ws_copy(src io.Reader, dst *websocket.Conn) (int, error) {
	buffer := make([]byte, 2048)
	count := 0
	for {
		n, err := src.Read(buffer)
		if err != nil || n < 1 {
			return count, err
		}
		count += n
		err = websocket.Message.Send(dst, buffer[0:n])
		if err != nil {
			return count, err
		}
	}
	return count, nil
}

/* copy from websocket to writer, this copies the binary frames as is */
func io_copy_ws(src *websocket.Conn, dst io.Writer) (int, error) {
	var buffer []byte
	count := 0
	for {
		err := websocket.Message.Receive(src, &buffer)
		if err != nil {
			return count, err
		}
		n := len(buffer)
		count += n
		i, err := dst.Write(buffer)
		if err != nil || i < 1 {
			return count, err
		}
	}
	return count, nil
}

func WebsocketTcpProxy(ws *websocket.Conn, nettype string, host string) error {
	client, err := net.Dial(nettype, host)
	if err != nil {
		return err
	}
	defer client.Close()
	defer ws.Close()
	chDone := make(chan bool)

	go func() {
		io_ws_copy(client, ws)
		chDone <- true
	}()
	go func() {
		io_copy_ws(ws, client)
		chDone <- true
	}()
	<-chDone
	return nil
}

func AddWebsocketHandler(urlPattern string, uri string) error {
	sugar := log.Logger.Sugar()

	sugar.Infof("AddWebsocketHandler urlPattern=%s, uri=%s", urlPattern, uri)
	u, err := url.Parse(uri)
	if err != nil {
		sugar.Errorf("surgemq/main: %v", err)
		return err
	}

	h := func(ws *websocket.Conn) {
		WebsocketTcpProxy(ws, u.Scheme, u.Host)
	}
	http.Handle(urlPattern, websocket.Handler(h))
	return nil
}

func ListenAndServeWebsocket(addr string) error {
	return http.ListenAndServe(addr, nil)
}

func MessageFromServer(i ServerMessage) {
	msg := message.NewPublishMessage()
	payload, err := json.Marshal(i)
	if err != nil {
		fmt.Println(err)
	}
	msg.SetTopic([]byte("/superserver/notify"))
	msg.SetPayload(payload)

	MqttSvr.Publish(msg, nil)
}


```

前
