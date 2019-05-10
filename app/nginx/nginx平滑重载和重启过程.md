## 配置重载reload
```
nginx -s reload
或
kill -HUP master pid
```
* 检查配置文件语法的有效性
* 试图应用新的配置，即打开新的日志文件和新的socket 监听
* 如果失败，它将回滚配置更改并继续使用旧的配置
* 如果成功了，它开启新的工作进程
* 给旧的工作进程发消息让它们优雅的关闭，旧的工作进程接收到关闭信号后，不再接收新的请求，如果已有请求正在处理，等当前请求处理完毕后关闭，如果没有请求正在处理，则直接关闭。

- master pid不变
- worker pid更新

## 升级重启restart
```
kill -USR2 master pid
```
开始产生新的master和worker，并存，产生nginx.pid.oldbin
```
root       9944      1  0 13:22 ?        00:00:00 nginx: master process ./nginx
nobody     9965   9944  0 13:29 ?        00:00:00 nginx: worker process
root      10012   9944  0 13:43 ?        00:00:00 nginx: master process ./nginx
nobody    10013  10012  0 13:43 ?        00:00:00 nginx: worker process
```

给旧的主进程发送WINCH信号
```
kill -WINCH master pid
```
旧的主进程号收到WINCH信号后，将旧进程号管理的旧的工作进程优雅的关闭。   
即一段时间后旧的工作进程全部关闭，只有新的工作进程在处理请求连接。这时，依然可以恢复到旧的进程服务，因为旧的进程的监听socket还未停止。   
   
给旧的主进程发送QUIT信号，使其关闭
```
kill -QUIT master pid
```
给旧的主进程发送QUIT信号后，旧的主进程退出，并移除logs/nginx.pid.oldbin文件，nginx的升级完成。

-----

在步骤(3)时，如果想回到旧的nginx不再升级   
```
kill -HUP old master pid
kill -QUIT new master pid
```

## 参考
[nginx启动、重启、重新加载配置文件和平滑升级](https://blog.csdn.net/gnail_oug/article/details/52754491)

