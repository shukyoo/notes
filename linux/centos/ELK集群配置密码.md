## 集群配置
```
cluster.name: my_es   # 集群名称，每个节点需要相同
node.name: my_es1     # 节点名称，每个节点唯一
path.data: /usr/local/data
path.logs: /usr/local/elasticsearch-6.8.1/logs/
bootstrap.memory_lock: true
network.host: 0.0.0.0
http.port: 9200
discovery.zen.ping.unicast.hosts: ["10.0.0.1","10.0.0.2","10.0.0.3"]
action.destructive_requires_name: true

# 以下开启密码认证
xpack.security.enabled: true
xpack.license.self_generated.type: basic
xpack.security.transport.ssl.enabled: true
```

## 启动ES
```
bin/elasticsearch -d
```

## 设置密码
```
# 交互式设置密码
# 根据提示设置密码
bin/elasticsearch-setup-passwords interactive
```

## 生成证书
```
# ES6.0以后的集群版本需要安装 SSL和CA证书
bin/elasticsearch-certgen
    # Please enter the desired output file [certificate-bundle.zip]: cert.zip  （压缩包名称）
    # Enter instance name:  my_es  (实例名)
    # Enter name for directories and files [p4mES]: elasticsearch  （文件夹名）
    Enter IP Addresses for instance (comma-separated if more than one) []: 10.0.0.1,10.0.0.2,10.0.0.3     (实例ip，多个ip用逗号隔开)
    Enter DNS names for instance (comma-separated if more than one) []: my_es1,my_es2,my_es3    （节点名，多个节点用逗号隔开）
    Would you like to specify another instance? Press 'y' to continue entering instance information: (到达这一步,不需要按y重新设置,按空格键就完成了)
```

## 配置证书
每一个节点都相同操作
1. 解压zip证书到config/目录下
2. 配置config/elasticsearch.yml，后面追加
```
xpack.ssl.key: elasticsearch/elasticsearch.key
xpack.ssl.certificate: elasticsearch/elasticsearch.crt
xpack.ssl.certificate_authorities: ca/ca.crt
```
3. 重启ES


## kibana设置密码
```
 # 在config/kibana.yml下添加如下两行
 elasticsearch.username: elastic
 elasticsearch.password: {你修改的password}
```

## Logstash设置密码
```
# 配置config/logstash.yml
xpack.monitoring.enabled: true
xpack.monitoring.elasticsearch.username: logstash_system
xpack.monitoring.elasticsearch.password: 你的密码
xpack.monitoring.elasticsearch.url: ["http://10.0.0.1:9200", "http://10.0.0.2:9200", "http://10.0.0.3:9200"]
```

## 配置管道配置
```
# 配置config/pipelines.yml
- pipeline.id: my_log1
  pipeline.batch.size: 256
  queue.type: persisted
  path.config: "/usr/local/logstash/conf/mylog1.conf"

- pipeline.id: my_log2
  pipeline.batch.size: 256
  queue.type: persisted
  path.config: "/usr/local/logstash/conf/mylog2.conf"
```

## 配置日志采集
```
input {
    kafka {
        bootstrap_servers => "my1.kafka:9092,my2.kafka:9092,my3.kafka:9092"
        group_id => "my_log1"
        topics => ["my_log1"]
        consumer_threads => 3
        decorate_events => false
        codec => "json"
        auto_offset_reset => "latest"
    }
}

filter {
  if [mod] == "test" {
    drop{}
  }
}

output {
    elasticsearch {
        hosts => ["http://10.0.0.1:9200", "http://10.0.0.2:9200", "http://10.0.0.3:9200"]
        user => "elastic"
        password => "你的密码"
        index => "mylog-%{+YYYYMMdd}"
        template => "/usr/local/logstash/conf/template/mylog_template.json"
        template_name => "mylog"
        manage_template => true
        template_overwrite => true
        codec => "json"
    }
}
```

## template配置
```
{
  "template": "mylog*",
  "index_patterns" : [
    "mylog*"
  ],
  "settings": {
    "index.mapping.total_fields.limit": 100,
    "index.mapping.depth.limit": 2
  },
  "mappings": {
    "doc": {
      "dynamic" : "false",
      "properties": {
        "@timestamp": {
          "type": "date"
        },
        "@version": {
          "type": "text",
          "index": "false"
        },
        "dtm": {
          "type": "text"
        },
        "host": {
          "type": "text"
        },
        "tid": {
          "type": "text"
        },
        "app": {
          "type": "text"
        },
        "mod": {
          "type": "text"
        }
      }
    }
  }
}
```


# 参考
* [ElasticSearch集群部署完整指南](https://www.jianshu.com/p/9b4a729ca78c)
