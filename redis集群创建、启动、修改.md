## 第一步：安装redis>=v3

## 第二步：安装ruby, rubygems和gem_redis
```
gem install redis --version 3.2.1
```

## 第三步：创建配置文件，如果是一台服务器多个实例的话，那么创建子目录放配置文件
```shell
daemonize yes
bind 0.0.0.0
port 6583
pidfile /var/run/redis-6583.pid
dbfilename dump-6583.rdb
appendfilename "appendonly-6583.aof"
cluster-config-file nodes-6583.conf
cluster-enabled yes
cluster-node-timeout 5000
appendonly yes
dir /var/redis/6583/
```

## 第四步：启动实例，至少有6个实例（3主3从）
```
.../bin/redis-server 6583/redis.conf
```

## 第五步：创建集群
```
/usr/local/hikvision/redis-3.2.1/src/redis-trib.rb create --replicas 1 10.82.4.102:6580 10.82.4.102:6581 10.82.4.102:6582 10.82.4.102:6583 10.82.4.102:6584 10.82.4.102:6585
```

## 第六步：验证
```
.../bin/redis-cli -c -p 6583
...
> cluster nodes
```
