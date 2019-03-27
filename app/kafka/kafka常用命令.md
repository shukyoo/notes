## kafka常用命令

1. 查看topic的详细信息
```
./kafka-topics.sh -zookeeper127.0.0.1:2181-describe -topic mytopic
```

2. 为topic增加副本
```
./kafka-reassign-partitions.sh -zookeeper127.0.0.1:2181-reassignment-json-file json/partitions-to-move.json -execute
```

3. 创建topic
```
./kafka-topics.sh --create --zookeeper localhost:2181--replication-factor1--partitions1--topic mytopic
```

4. 为topic增加partition
```
./kafka-topics.sh –zookeeper127.0.0.1:2181–alter –partitions20–topic mytopic
```

5. kafka生产者客户端命令
```
./kafka-console-producer.sh --broker-list localhost:9092--topic mytopic
```

6. kafka消费者客户端命令
```
./kafka-console-consumer.sh -zookeeper localhost:2181--from-beginning --topic mytopic
```

7. kafka服务启动
```
./kafka-server-start.sh -daemon ../config/server.properties
```

8. 下线broker
```
./kafka-run-class.sh kafka.admin.ShutdownBroker --zookeeper127.0.0.1:2181--broker #brokerId# --num.retries3--retry.interval.ms60shutdown broker
```

9. 删除topic
```
./kafka-run-class.sh kafka.admin.DeleteTopicCommand --topic mytopic --zookeeper127.0.0.1:2181
```
