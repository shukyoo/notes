## 服务器准备
一主，两从，一仲裁

## 安装mongo
参考 [centos安装mongodb](https://github.com/shukyoo/notes/blob/master/app/mongo/centos%E5%AE%89%E8%A3%85mongodb.md)

## 配置
每台都这样配置
```
dbpath=/usr/local/mongodb/data
logpath=/usr/local/mongodb/logs/mongo.log
logappend=true
bind_ip=0.0.0.0
port=27017
fork=true
replSet=test
```

## 启动
每台都启动
```
bin/mongod --config mongodb.conf
```

## 配置主从仲裁
```
# 连接主
bin/mongo xxx.xxx.xxx.xxx:27017

# 设置
rs.initiate({_id:"test", members:[
    {_id:0,host:"127.0.0.1:27017",priority:10},
    {_id:1,host:"127.0.0.1:27027",priority:8},
    {_id:2,host:"127.0.0.1:27037",priority:6},
    {_id:3,host:"127.0.0.1:27037",arbiterOnly:true}
]});

# 查看
rs.status();
```
