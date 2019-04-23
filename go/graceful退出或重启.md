## graceful退出或重启
* go1.8后官方为http.server增加了shutdown方法，可以平滑退出或重启   
    * [github.com/douglarek/zerodown](https://github.com/douglarek/zerodown)
    * [github.com/tabalt/gracehttp](https://github.com/tabalt/gracehttp)
    * [github.com/kuangchanglang/graceful](https://github.com/kuangchanglang/graceful)
    * [github.com/TV4/graceful](https://github.com/TV4/graceful)
    * [github.com/fevin/gracehttp](https://github.com/fevin/gracehttp)

* 基于tpc / socket
    * [github.com/gobwas/graceful](https://github.com/gobwas/graceful)
    * [github.com/rcrowley/goagain](https://github.com/rcrowley/goagain)
    
* 老的知名grace
    * [github.com/facebookarchive/grace](https://github.com/facebookarchive/grace)
    * [github.com/fvbock/endless](https://github.com/fvbock/endless)
    * [github.com/jpillora/overseer](https://github.com/jpillora/overseer)

## 官方http.server Shutdown原理
* 首先关闭所有的监听
* 然后关闭所有的空闲连接
* 然后无限期等待连接处理完毕转为空闲，并关闭
* 如果提供了 带有超时的Context，将在服务关闭前返回 Context的超时错误

## 热重启原理
* 监听信号（USR2..）
* 收到信号时fork子进程（使用相同的启动命令），将服务监听的socket文件描述符传递给子进程
* 子进程监听父进程的socket，这个时候父进程和子进程都可以接收请求
* 子进程启动成功之后，父进程停止接收新的连接，等待旧连接处理完成（或超时）
* 父进程退出，重启完成


## 参考
* [Golang服务器热重启、热升级、热更新](https://www.cnblogs.com/sunsky303/p/9778466.html)
* [使用 Go 语言实现优雅的服务器重启](https://www.oschina.net/translate/graceful-server-restart-with-go)
* [无停机优雅重启 Go 程序](https://studygolang.com/articles/14038?fr=sidebar)
