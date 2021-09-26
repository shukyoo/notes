1. 查看topic的详细信息
```
./kafka-topics.sh --zookeeper 127.0.0.1:2181 --describe --topic mytopic
```

2. 为topic增加副本
```
./kafka-reassign-partitions.sh --zookeeper 127.0.0.1:2181 --reassignment-json-file json/partitions-to-move.json --execute
```

3. 创建topic
```
./kafka-topics.sh --create --zookeeper 127.0.0.1:2181 --replication-factor 1 --partitions 2 --topic mytopic
```

4. 为topic增加partition
```
./kafka-topics.sh --zookeeper 127.0.0.1:2181 --alter --partitions 20 --topic mytopic
```

5. kafka生产者客户端命令
```
./kafka-console-producer.sh --broker-list 127.0.0.1:9092 --topic mytopic
```

6. kafka消费者客户端命令
```
./kafka-console-consumer.sh --zookeeper 127.0.0.1:2181 --from-beginning --topic mytopic
```

7. kafka服务启动
```
./kafka-server-start.sh --daemon ../config/server.properties
```

8. 下线broker
```
./kafka-run-class.sh kafka.admin.ShutdownBroker --zookeeper 127.0.0.1:2181 --broker #brokerId# --num.retries 3 --retry.interval.ms60shutdown broker
```

9. 删除topic
```
delete.topic.enable要设置为true
./kafka-topics.sh --delete --zookeeper 127.0.0.1:2181 --topic mytopic
```
