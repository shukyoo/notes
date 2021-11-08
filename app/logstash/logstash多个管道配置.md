## 编辑pipelines
```
vim logstash/config/pipelines.yml
```

## 多个管道
```
- pipeline.id: test1
  pipeline.batch.size: 256
  queue.type: persisted
  path.config: "/usr/local/logstash/conf/test1.conf"

- pipeline.id: test2
  pipeline.batch.size: 256
  queue.type: persisted
  path.config: "/usr/local/logstash/conf/test2.conf"
```

## 启动
```
/usr/local/logstash/bin/logstash --path.data=/data/log/logstash
```
