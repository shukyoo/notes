## 命令
```
gdb /usr/local/php56/sbin/php-fpm -c /tmp/core.4522

# 输入命令bt，会列出退出前的堆栈信息, 可以看到最开始一条记录
bt
```

## 更多
上面的分析方法，因为有业务侧的代码显现，还比较容易定位问题，否则就要借助php提供的.gdbinit脚本了，它能将更高层的业务跟踪代码显示出来，.gdbinit文件的位置一般是在/usr/local/src/php-5.6.30/.gdbinit目录下（php后的版本号根据你的环境修改，或者通过find方法搜索，或在这下载https://github.com/php/php-src/blob/master/.gdbinit）。    
    
仍停留在上面的gdb交互环境里，执行命令source /usr/local/src/php-5.6.30/.gdbinit，再执行命令zbacktrace，则会打印更多业务侧的代码


## 参考
* [分析php core dump的原因](https://my.oschina.net/swingcoder/blog/4684020)
