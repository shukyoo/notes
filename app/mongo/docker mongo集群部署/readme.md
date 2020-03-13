# 安装

## 第一步，准备工作
* 创建好docker-compose.yml
* 创建好docker-compose里挂载的对应的目录
* 把scripts里初始命令都放到对应目录里

## 第二步，启动所有容器
```
docker-compose up -d
```

## 第三步，初始化
```
# 初始化configsrv
docker-compose exec configsrv sh -c "mongo < /scripts/init-configsrv.js"

# 初始化shard，如果有多个分区，则用第一个节点相同初始化
docker-compose exec rs1_node1 sh -c "mongo < /scripts/init-rs1.js"

# 加载仲裁节点
docker-compose exec rs1_node1 sh -c "mongo < /scripts/init-arbiter.js"

# 稍等一会儿（等已经选出主节点），初始化路由
docker-compose exec router sh -c "mongo < /scripts/init-router.js"
```

## 第四步，启动Sharding
在对collection进行sharding之前一定要先对数据库启动sharding
```
# 进入mongo
docker-compose exec router mongo

# Enable sharding for database `mydb`（自己命名的库）
sh.enableSharding("mydb")
# Setup shardingKey for collection `mycollection`（自己的collection）
sh.shardCollection( "mydb.mycollection", { _id : "hashed" } )
```

## 验证
```
# 验证集群状态
docker-compose exec router mongo --port 27017
sh.status()

# 验证分区状态
docker exec -it mongo_rs1_node1_1 bash -c "echo 'rs.status()' | mongo --port 27017" 

# 验证mydb
docker-compose exec router mongo --port 27017
use mydb
db.stats()
db.mycollection.getShardDistribution()
```

## 设置登录验证
```
# 进各mongo先创建管理用户
db.createUser({user: "admin", pwd: "123456", roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]  })
db.createUser({user: "root", pwd: "123456", roles: [ { role: "root", db: "admin" } ]  })

# 创建mongodb-keyfile文件，放进对应的db目录里
openssl rand -base64 741 > mongodb-keyfile
chmod 600 mongodb-keyfile

# docker-compose.yml加入--keyfile，如
command: mongod --keyFile /data/db/mongodb-keyfile --oplogSize 10240 --replSet rs1 --directoryperdb --port 27017 --shardsvr

# 再重新docker-compose up -d
```

## 加节点
```
# 进入router
use admin
db.auth("<username>","<password>")
sh.addShard("rs1/rs1_node3:27017")
```

## 重新设置
```
# 停止所有容器
# 删除
docker-compose rm
# 清除
docker-compose down -v --rmi all --remove-orphans
```

# 参考
* [使用Docker部署MongoDB Cluster](https://blog.csdn.net/hot88zh/article/details/80009146)
* [minhhungit/mongodb-cluster-docker-compose](https://github.com/minhhungit/mongodb-cluster-docker-compose)

