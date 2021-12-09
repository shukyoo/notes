## redis单例
* 方法一，直接使用命令
```
services:
  redis:
    image: redis
    ports:
        - "6379:6379"
    command: redis-server --port 6379 --requirepass 123456
```
* 方法二，挂载配置文件
```
  volumes:
    - ./redis.conf:/usr/local/etc/redis/redis.conf
```

## redis集群
1. 先无密码创建集群
2. 再挨个设置密码，requirepass和masterauth都需要设置，否则发生主从切换时，就会遇到授权问题，各个节点的密码都必须一致，否则Redirected就会失败
```
services:
  redis-cluster:
    image: grokzen/redis-cluster
    environment:
        - IP=0.0.0.0
    ports:
        - "7000:7000"
        - "7001:7001"
        - "7002:7002"
        - "7003:7003"
        - "7004:7004"
        - "7005:7005"
```
设置密码
```
// 设置masterauth密码
config set masterauth 123456
// 设置requirepass
config set requirepass 123456
// 验证
auth 123456
// 回写到文件，使其永久生效
config rewrite
```

