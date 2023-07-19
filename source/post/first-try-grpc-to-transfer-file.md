title: 初识grpc, 使用grpc传输文件
date: 2020-05-29 23:46:46 +0800
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



## 准备工作

1. 生成CA证书
   
```sh
openssl genrsa -out server.key 2048  # 私钥
openssl req -new -x509 -sha256 -key server.key  -out server.crt -days 36500 # 公钥
```

   公钥会需要填写信息, 主要有一个 `Common Name` 需要记录下来, 比如我填写的是 `deploy`, 当然你可以填写任意字符串, 记下来就行.

   36500表示100年有效, 自签证书就久一点好了

2. 安装protobuf生成工具
   
```sh
go get -u github.com/golang/protobuf/protoc-gen-go
```

安装完后, 终端输入`protoc`可以输出帮助信息就准备完成了


## 服务端

- proto接口定义
   
新建一个go module项目, 创建proto目录, 再创建fs.proto文件. 如果IDE提示装插件就装上

```
syntax = "proto3";

package proto;
option go_package = ".;proto";

service FileService {
  rpc Upload(FSReq) returns (FSResp) {}
}

message FSReq {
  string dstDir = 1;
  string projName =2;
  string name = 3;
  int32 projType = 4;
  bool ifReboot =5;
  string hash = 6;
  int64 filelen = 7;
  bytes file = 8;
}

message FSResp {
  bool status = 1;
  string message = 2;
}

```
    

- 生成 *.pb.go
   
```bash
protoc --go_out=plugins=grpc:. --go_opt=paths=source_relative proto/fs.proto
```
会在proto目录下生成fs.pb.go

**或者**

![](images/idea-filewatcher-protobuf-gen-setting.png)

让ide自动生成


- server.go

```go
package main

import (
	"context"
	"crypto/sha256"
	"fmt"
	"github.com/linxlib/logs"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"grpc_startup/proto"
	"log"
	"math"
	"net"
)

const (
	port = ":50051"
)

type server struct {
}

// verifyFile 校验下上传的数据包是否完整, 通过Sha256和文件数据长度两个进行判断
func (s *server) verifyFile(file []byte, hash string, length int64) bool {
	h := sha256.New()
	h.Write(file)
	myHash := fmt.Sprintf("%x", h.Sum(nil))
	logs.Info("hash:", hash, " myHash:", myHash, " len:", length, " myLen:", len(file))
	return hash == myHash
}

func (s *server) Upload(ctx context.Context, in *proto.FSReq) (*proto.FSResp, error) {
	if !s.verifyFile(in.File, in.Hash, in.Filelen) {
		return &proto.FSResp{
			Status:  false,
			Message: "数据包哈希校验失败，请重新部署",
		}, nil
	}
	return &proto.FSResp{
		Status:  true,
		Message: "received",
	}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		logs.Fatalf("failed to listen: %v", err)
	}
	c, err := credentials.NewServerTLSFromFile("./server.crt", "./server.key")
	if err != nil {
		log.Fatalf("credentials.NewServerTLSFromFile err: %v", err)
	}
	//由于要发送较大的压缩包，默认为 4M。
	//如果需要向客户端发送大文件则增加一条grpc.MaxSendMsgSize()
	s := grpc.NewServer(
		grpc.Creds(c),
		grpc.MaxRecvMsgSize(math.MaxInt64))
		
	//注册服务
	proto.RegisterFileServiceServer(s, &server{})

	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
```

这样一个使用CA证书可传输大文件的grpc服务器就跑起来了


## go客户端

```go
package main

import (
	"context"
	"crypto/sha256"
	"fmt"
	"github.com/linxlib/conv"
	"github.com/linxlib/logs"
	"google.golang.org/grpc"
	"google.golang.org/grpc/credentials"
	"grpc_startup/proto"
	"io/ioutil"
	"log"
	"time"
)

const (
	address = "localhost:50051"
)

func main() {
	// 注意这里的deploy， 需要和证书公钥生成时的 Common Name 对应
	c, err := credentials.NewClientTLSFromFile("./server.crt", "deploy")
	if err != nil {
		log.Fatalf("credentials.NewClientTLSFromFile err: %v", err)
	}
	conn, err := grpc.Dial(address, grpc.WithTransportCredentials(c))
	if err != nil {
		log.Fatalf("did not connect: %v", err)
	}
	defer conn.Close()
	client := proto.NewFileServiceClient(conn)

	// 30秒的上下文, 传输大文件适当扩大时间
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*30)
	defer cancel()

	bs, _ := ioutil.ReadFile("./1.0-window.7z")
	filelen := conv.Int64(len(bs))
	h := sha256.New()
	h.Write(bs)
	myhash := fmt.Sprintf("%x", h.Sum(nil))
	logs.Info("myhash:", myhash)
	start := time.Now()
	r, err := client.Upload(ctx, &proto.FSReq{
		DstDir:   "ehw",
		ProjName: "dsaudg",
		Name:     "dasgf",
		ProjType: 1,
		Hash:     myhash,
		Filelen:  filelen,
		IfReboot: false,
		File:     bs,
	})
	end := time.Now().Sub(start).Seconds()
	kb := filelen / 1024
	logs.Info("time:", end, " file size:", kb, "KB")
	if err != nil {
		log.Fatalf("could not upload: %v", err)
	}
	log.Printf("Upload: %s", r.Message)
}

```

主要需要注意的就是 `Common Name`, `NewClientTLSFromFile`的参数二, 这俩需要一样.

还有上下文的长度根据具体传输的文件大小还有网络状况而定


## C# WinForm 客户端

1. 依赖如下
  ![](images/grpc-csharp-nuget-package.png)
2. 拷贝fs.proto到解决方案下, 在安装了上图的 `Grpc.Tools` 之后, 选中fs.proto文件, 下方的`生成操作`应该会多出一个`Protobuf`, 选择这个, 重新生成下项目, 就可以在 `obj/Debug` 下看到生成的 `Fs.cs` `FsGrpc.cs` 两个文件了

3. 准备好一个比较大的压缩包(100M以上吧), 和上面生成的 server.crt, 上代码

```csharp
private void button1_Click(object sender, EventArgs e)
{
	var secureChanel = new SslCredentials(File.ReadAllText("server.crt"));
	var channOptions = new List<ChannelOption>
	{
		new ChannelOption(ChannelOptions.SslTargetNameOverride,"deploy")
	};
	Channel channel = new Channel("127.0.0.1:50051", secureChanel , channOptions);

	var client = new FileServiceClient(channel);
	var req = new Proto.FSReq();
	req.DstDir = "ssdd";
	req.IfReboot = false;
	req.Name = "sadas";
	req.ProjName = "dsada";
	req.ProjType = 3;

	var file = File.ReadAllBytes("1.0-window.7z");
	SHA256Managed Sha256 = new SHA256Managed();
	byte[] bs = Sha256.ComputeHash(file);
	var hash = BitConverter.ToString(bs);
	req.Hash = hash.Replace("-","").ToLower();
	req.Filelen = file.Length;
	req.File = ByteString.CopyFrom(file);

	var reply = client.Upload(req);

	MessageBox.Show("来自" + reply.Message);

	channel.ShutdownAsync().Wait();
}
```

## 遇到的坑和总结

- c# 的sha256需要做去`-`和转小写才可以和go的一样
- grpc生成的对应bytes的类型在go和c#中不一样, c#是Google.Protobuf.ByteString
- c#客户端中间有遇到一个`Stream removed`错误, 搜了一圈, 最终也不知道怎么解决的, 貌似重新运行了服务端就好了
- c#的依赖装完后可以都更新到最新版本, Grpc.Net.* 的包不是给WinForm用的, 好像是给.Net Core使用的, 一直无法安装, 我还以为是.Net版本太低了
- grpc默认的最大数据包大小为4M, 需要手动设置一下
