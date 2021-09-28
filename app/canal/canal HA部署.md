## 说明
Canal 集群的高可用 不是基于Server级别的，而是基于instance级别的，而一个instance对应的是一个mysql实例。   
当Canal Server中的某个instance挂掉之后，其他Canal Server在zookeeper中重新抢占节点。而Canal Client HA的原理就是通过监听zookeeper 中的canal节点，当监听到 关于canal节点有变化的时候，触发回调，重新初始化client连接该新的instance节点。这就是Canal Client的HA。   
在canal server运行的情况下，也可以动态添加新加入的instance节点，canal client同样可以通过zookeeper监听到，直接新起一个线程连接该instance即可。

## Canal和Zookeeper对应节点的关系
```
/otter/canal:canal的根目录
/otter/canal/cluster:整个canal server的集群列表
/otter/canal/destinations:destination的根目录
/otter/canal/destinations/example/running:服务端当前正在提供服务的running节点
/otter/canal/destinations/example/cluster:针对某个destination的工作集群列表
/otter/canal/destinations/example/1001/running:客户端当前正在读取的running节点
/otter/canal/destinations/example/1001/cluster:针对某个destination的客户端列表
/otter/canal/destinations/example/1001/cursor:客户端读取的position信息
```

## Canal Server HA搭建
机器准备
```
mysql: 源
canal:  2台
zookeeper: 3台
```

#### mysql配置
开启并设置数据库binlog，设置为row模式（canal对row模式支持较好，支持从指定的binlog的位置读取信息）

#### canal admin部署
1. 部署参考：[Canal Admin QuickStart](https://github.com/alibaba/canal/wiki/Canal-Admin-QuickStart)
2. 初始化元数据库
```
元数据库在admin包的conf/canal_manager.sql
> source conf/canal_manager.sql
```
3. 配置
```
server:
  port: 8080 // 端口
spring:
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8

spring.datasource:
  address: test.mysql:3306  // canal所在数据库
  database: canal_manager   // 库名
  username: canal           // 用户名
  password: canal           // 密码
  driver-class-name: com.mysql.jdbc.Driver
  url: jdbc:mysql://${spring.datasource.address}/${spring.datasource.database}?useUnicode=true&characterEncoding=UTF-8&useSSL=false
  hikari:
    maximum-pool-size: 30
    minimum-idle: 1

canal:
  adminUser: admin  // admin用户
  adminPasswd: admin  // admin密码
```

#### canal配置
1. 下载和解压：访问 [release](https://github.com/alibaba/canal/releases) 页面

2. 配置conf/canal_local.properties
```
# register ip
canal.register.ip = 10.220.11.11

# canal admin config
canal.admin.manager = 127.0.0.1:8080
canal.admin.port = 11110
canal.admin.user = admin
canal.admin.passwd = 4ACFE3202A5FF5CF467898FC58AAB1D615029441

# admin auto register
canal.admin.register.auto = true
canal.admin.register.cluster = test_canal
```

3. 启动
```
./startup.sh
```

4. 查看日志，是否正常启动
```
tail -200 /example/example.log  # 这里的example为示例的instance
```

#### admin后台配置
1. 新建集群
2. 主要修改配置
```
#################################################
######### 		common argument		#############
#################################################
# tcp bind ip
canal.ip =
# register ip to zookeeper
canal.register.ip =
canal.port = 11111
canal.metrics.pull.port = 11112

# canal admin config
canal.admin.manager = 127.0.0.1:8080
canal.admin.port = 11110
canal.admin.user = admin
canal.admin.passwd = 4ACFE3202A5FF5CF467898FC58AAB1D615029441

canal.zkServers = zook1.domain:4180,zook2.domain:4180

# table meta tsdb info
canal.instance.tsdb.enable = true
canal.instance.tsdb.dir = ${canal.file.data.dir:../conf}/${canal.instance.destination:}

canal.instance.tsdb.url = jdbc:mysql://test.mysql:3306/canal_tsdb
canal.instance.tsdb.dbUsername = canal
canal.instance.tsdb.dbPassword = canal


#################################################
######### 		destinations		#############
#################################################

canal.instance.tsdb.spring.xml = classpath:spring/tsdb/mysql-tsdb.xml

canal.instance.global.spring.xml = classpath:spring/default-instance.xml
```

3. 创建instance
4. instance主要配置
```
# enable gtid use true/false
canal.instance.gtidon=true

# position info
canal.instance.master.address=master.mysql:3306
canal.instance.master.journal.name=
canal.instance.master.position=
canal.instance.master.timestamp=
canal.instance.master.gtid=


canal.instance.standby.address = slave.mysql:3306

# username/password
canal.instance.dbUsername=canal
canal.instance.dbPassword=canal

# table regex
canal.instance.filter.regex=db1_test\\..*,db2_test\\..*
```


## 问题
### 1、启动顺序问题
首先canal的服务需要去canal-admin上去读取配置文件，所以canal-admin需要先启动，就是要先有UI界面，然后在启动canal服务。注意：canal的服务默认是读取本地的配置，启动时一定要加上loacl这个参数，或者改配置文件的名字。

### 2、元数据问题
在主配置里面canal.instance.global.spring.xml这个配置如果选择的是:
* file-instance.xml（一般是单机模式）元数据保存在conf/实例/instance.xml
* default-instance.xnl (为集群模式) 元数据保存在zookeeper里面/otter/canal/destinations   （需要配置zookeeper地址）

### 3、zookeeper改变
如果主配置的zookeeper地址改变了，需要修改集群的zookeeper和主配置的canal.zkServers参数，最好同时删除conf目录下的所有实例和zookeeper里面保存的所有实例。最后重启canal-admin，再重启canal服务

## 参考
* [canal-admin的高可用使用，单机使用，HA使用，阿里的canal的UI界面，管理canal的实例，以及问题](https://blog.csdn.net/weixin_40126236/article/details/100777543)

