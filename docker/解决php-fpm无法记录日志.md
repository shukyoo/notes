## 问题简述
php-fpm配置slowlog，测试，发现日志是空的

## 解决
在Linux系统中，PHP-FPM使用SYS_PTRACE跟踪worker进程，但是docker容器默认又不启用这个功能，所以就导致了这个问题。

如果用命令行，在命令上加上：
```
--cap-add=SYS_PTRACE
```

如果用docker-compose.yml文件，在服务中加上：
```
php:
  #...
  cap_add:
    - SYS_PTRACE
  #...
```

## 参考
[Docker中PHP-FPM容器无法记录日志](https://www.awaimai.com/2549.html)
