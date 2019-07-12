## 一，下载安装Protobuf编译器protoc
下载地址：[https://github.com/google/protobuf/releases](https://github.com/google/protobuf/releases)
（windows下载后把bin加入path）

## 二，go get
```
// gRPC运行时接口编解码支持库
go get -u github.com/golang/protobuf/proto
// 从 Proto文件(gRPC接口描述文件) 生成 go文件 的编译器插件
go get -u github.com/golang/protobuf/protoc-gen-go
// 获取go的gRPC包
go get -u google.golang.org/grpc
```

## 三，编写示例proto
在项目目录里新建一个如pb目录用于存放proto
hello.proto
```
syntax = "proto3";//声明proto的版本 只能 是3，才支持 grpc

//声明 包名
package pb;

//声明grpc服务
service Greeter {
   /*
   声名一个 sayhello 接口
   它的参数 是 HelloRequest
   它的返回参数是 HelloReply
   */
  rpc SayHello (HelloRequest) returns (HelloReply) {}
}

//参数结构
message HelloRequest {
  string name = 1;
}

//参数结构
message HelloReply {
  string message = 1;
}
```

## 四，使用命令把proto编译成go
（windows下打开gitbash）
```
cd /e/go/src/grpctest/pb
protoc --go_out=plugins=grpc:. *.proto
```

## 五，编写server
```go
package main

import (
	"context"
	"google.golang.org/grpc"
	"grpctest/pb"
	"net"
)

const PORT  = ":50051"

type server struct {}

func (s *server)SayHello(ctx context.Context, in *pb.HelloRequest)(*pb.HelloReply,error){
	return &pb.HelloReply{Message:"hello"},nil
}

func main(){
	//监听端口
	lis,err := net.Listen("tcp",PORT)
	if err != nil{
		return
	}
	//创建一个grpc 服务器
	s := grpc.NewServer()
	//注册事件
	pb.RegisterGreeterServer(s,&server{})
	//处理链接
	s.Serve(lis)
}
```

## 六，编写client
```go
package main

import (
	"google.golang.org/grpc"
	"grpctest/pb"
	"log"
	"context"
)

const (
	ADDRESS = "localhost:50051"
)
func main(){

	//通过grpc 库 建立一个连接
	conn ,err := grpc.Dial(ADDRESS,grpc.WithInsecure())
	if err != nil{
		return
	}
	defer conn.Close()

	//通过刚刚的连接 生成一个client对象。
	c := pb.NewGreeterClient(conn)
	//直接通过 client对象 调用 服务端的函数
	r, err := c.SayHello(context.Background(), &pb.HelloRequest{Name: "namas"})
	if err != nil {
		log.Fatal("could not greet: %v", err)
	}
	log.Printf("Greeting: %s", r.Message)
}
```

## 备注
一开始使用了这样的命令去编译，但是编译出来的文件不全
```
protoc --plugin=protoc-gen-go=/e/go/bin/protoc-gen-go.exe --go_out=./ hello.proto
```
后来查了以后，试着用以下命令才正常，具体原因还未知
```
protoc --go_out=plugins=grpc:. *.proto
```

