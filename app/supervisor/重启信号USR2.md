## 重启信号USR2
根据测试，使用supervisorctl restart是它先停止再启动的，supervisor默认使用的是TERM信号，当然stopsignal也可以配置；   
如果要用USR2作重启，需要以下这样的命令（v3.2后才支持）
```
supervisorctl signal USR2 hello
```

## 使用USR2重启的目的
平滑重启：
* 启动子进程共享父进程信息，两者同时工作
* 父进程停止接收，等待当前进行中任务完成（设置超时时间）
* 父进程退出
