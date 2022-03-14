## nginx指令和信号对应关系
* reopen  ->  USR1
* reload  ->  HUP
* stop    ->  TERM或INT
* quit    ->  QUIT

## 信号说明
* TERM或INT：立即停止
* QUIT：     优雅停止
* HUP：      重载配置
* USR1：     重新打开日志文件
* USR2：     热升级nginx程序
* WINCH：    优雅关闭相应的worker进程

## work进程可以接收的信号
* TERM或INT
* QUIT
* USR1
* WINCH

## work和master
如果因为某些原因，worker进程意外终止了，master进程会创建一个新的worker进程，以保证有对应的worker进程可以使用，当子进程worker进程终止时，会向master父进程发送CHLD信号，当master进程收到CHLD信号以后，就会知道对应的worker进程退出了，此时，master进程会创建一个新的worker进程
