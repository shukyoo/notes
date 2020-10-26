# 简介
canal是阿里巴巴旗下的一款开源项目，纯Java开发。基于数据库增量日志解析，提供增量数据订阅&消费，目前主要支持了MySQL（也支持mariaDB）。

# 相关说明
* canal client与canal server之间是C/S模式的通信，客户端采用NIO，服务端采用Netty
* canal server启动后，如果没有canal client，那么canal server不会去mysql拉取binlog，即Canal客户端主动发起拉取请求，服务端才会模拟一个MySQL Slave节点去主节点拉取binlog。通常Canal客户端是一个死循环，这样客户端一直调用get方法，服务端也就会一直拉取binlog。

# 参考
* [阿里开源Canal--①简介](https://www.jianshu.com/p/87944efe1005)
* [谈谈对Canal（增量数据订阅与消费）的理解](https://developer.aliyun.com/article/238375)
* [深入解析中间件之-Canal](https://zqhxuyuan.github.io/2017/10/10/Midd-canal/)
