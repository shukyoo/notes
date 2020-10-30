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

#### canal配置
1. 两台canal各自所在的机器上修改canal.properties
```
canal.zkServers=192.168.207.141:2181,192.168.207.142:2181,192.168.207.143:2181
```
2. 修改 instance.properties （不同命名的instance）
```
canal.instance.mysql.slaveId = 1234 #两台不一样
# position info
canal.instance.master.address = 192.168.207.141:3306
canal.instance.dbUsername = root
canal.instance.dbPassword = 123456
# canal.instance.defaultDatabaseName = canal
canal.instance.connectionCharset = UTF-8
```
3 开启
```
./startup.sh
```
4. 查看日志，是否正常启动
```
tail -200 /example/example.log  # 这里的example为示例的instance
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

