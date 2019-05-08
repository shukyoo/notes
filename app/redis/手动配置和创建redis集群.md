## 目录结构
* 6180
  * redis.conf
* 6181
  * redis.conf
* 6182
  * redis.conf
* 6183
  * redis.conf
* 6184
  * redis.conf
* 6185
  * redis.conf


## redis.conf配置

```
daemonize yes
bind 0.0.0.0
port 6180
pidfile /var/run/redis-6180.pid
dbfilename dump-6180.rdb
appendfilename "appendonly-6180.aof"
cluster-config-file nodes-6180.conf
cluster-enabled yes
cluster-node-timeout 5000
appendonly yes
dir /var/redis_cluster/6180/
```

## 启动每个节点
```
/usr/local/hikvision/redis-3.2.1/bin/redis-server 6180/redis.conf
```

## 集群连接
```
/usr/local/hikvision/redis-3.2.1/src/redis-trib.rb create --replicas 1 127.0.0.1:6180 127.0.0.1:6181 127.0.0.1:6182 127.0.0.1:6183 127.0.0.1:6184 127.0.0.1:6185
```
