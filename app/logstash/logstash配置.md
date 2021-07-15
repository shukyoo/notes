##基本语法
```
input {
    kafka {
        # kafka consumer 配置
    }
}

filter {
    # 数据处理配置
}

output {
    elasticsearch {
        # elasticsearch 输出配置
    }
}
```

## 简单调试
标准输入到标准输出
```
bin/logstash -e 'input { stdin { } } output { stdout {} }'
```

## 启动
```
bin/logstash -f conf/test.conf --path.data=/var/log/logtest
```

## kafka写入到ES
```
input {
    kafka {
        bootstrap_servers => "kafka1:9092,kafka2:9092,kafka3:9092"
        group_id => "test_hello"
        topics => ["test_topic"]
        consumer_threads => 3
        decorate_events => false
        codec => "json"
        auto_offset_reset => "latest"
    }
}

filter {
  if [mod] == "debug" {
    drop{}
  }
}

output {
    elasticsearch {
        hosts => ["es1:9200","es2:9200","es3:9200"]
        index => "test"
        codec => "json"
    }
}
```

## 相关配置示例和说明
输出到文件
```
input {
    stdin {
        type => "std"
    }
}

output {
    file {
        path => "../data_test/%{+yyyy}/%{+MM}/%{+dd}/%{host}.log"
        codec => line { format => "custom format: %{message}"}
    }
}
```

过滤，特定过滤不输出
```
filter {
  if [loglevel] == "debug" {
    drop { }
  }
  if ![test] {
    drop{}
  }
  # 正则匹配文本
  if([message]=~ "^Retrieved hosts from InstanceDiscovery: 0"){
      drop{}
  }
}
```

示例2
1. 准备数据：sample.json
```
{"id": 4,"timestamp":"2019-06-10T18:01:32Z","paymentType":"Visa","name":"Cary Boyes","gender":"Male","ip_address":"223.113.73.232","purpose":"Grocery","country":"Pakistan","pastEvents":[{"eventId":7,"transactionId":"63941-950"},{"eventId":8,"transactionId":"55926-0011"}],"age":46}
{"id": 5,"timestamp":"2020-02-18T12:27:35Z","paymentType":"Visa","name":"Betteanne Diament","gender":"Female","ip_address":"159.148.102.98","purpose":"Computers","country":"Brazil","pastEvents":[{"eventId":9,"transactionId":"76436-101"},{"eventId":10,"transactionId":"55154-3330"}],"age":41}
```
2. 配置
```
input {
  file {
    path => [ "/Users/liuxg/data/logstash_json/sample.json" ]
    start_position => "beginning"
    sincedb_path => "/dev/null"
    codec   => "json"
  }
}
 
output {   
  stdout {
    codec => rubydebug
  }
}
```
3. 运行
```
bin/logstash -f logstash_json.conf 
```

其它过滤新增
```
filter {
  json {
    # 输出增加message原数据
    source => "message"
  }
  # 过滤特定日志
  if [paymentType] == "Mastercard" {
    drop{}
  }
  # 去掉某些字段
  mutate {
    remove_field => ["message", "path", "host", "@version"]
  }
  # 拆分数组，并形成多个文档
  split {
    field => "[pastEvents]"
  }
}
```

#### 示例3
```
input {
 kafka {
   type => "normal_log_type" 
   bootstrap_servers => ["10.2.11.92:9092"] 
   topics => ["log_topic"] 
   #group_id => "filebeat-logstash" 
   #client_id => "logstashnode1" 
   consumer_threads => 1 
   codec => json { 
     charset => "UTF-8" 
   } 
   decorate_events => false 
 }
}

filter { 
  # 不匹配正则则删除，匹配正则用=~ 
  if [level] !~ "(ERROR|INFO)" { 
    # 删除日志 drop {} 
  }
  grok { 
    # 匹配com.ggport 开头的类 
    match => { 
      "className" => "(?^com.ggport)" 
    }
  }
  # 移除匹配生成的标签
  mutate { 
    remove_field  => ["ggport"]
  } 
  # 不匹配删除 
  if "_grokparsefailure"  in [tags] { 
    drop { }
  }
  grok { 
    # 匹配以~ 开头的内容
    match => { "message" => "(?^~)" }
  }
  #删除 不匹配生成的标签
  mutate {
    remove_field  => ["tags"]
  }
  #如匹配，用KV 分解日志内容
  if[auditType]{
    kv { 
      prefix => "" 
      source => "message" 
      field_split => "~" 
      value_split => ":" 
    }
  }
  #删除 匹配生成的标签
  mutate{ 
    remove_field => ["auditType"]
  } 
}

output{
  #审计日志索引 
  if [operateType]  { 
    elasticsearch { 
      hosts => "10.26.11.23:9200" 
      index => "aduit_log" 
      document_type => "aduit_log" 
    } 
  } 
  #普通日志索引 
  if ![operateType]  { 
    elasticsearch { 
      hosts => "10.26.11.22:9200" 
      index => "normal_log" 
      document_type => "normal_log" 
    } 
  } 
  stdout{ 
    codec => rubydebug ##输出到屏幕上
  }
}
```


## 参考
* [Logstash：解析 JSON 文件并导入到 Elasticsearch 中](https://blog.csdn.net/UbuntuTouch/article/details/114383426)
* [ELK日志logstash解析JSON嵌套](https://github.com/Xlinlin/SpringCloud-Demo/blob/master/SpringCloud-Demo-Doc/kafka%2Belk/ELK%E6%97%A5%E5%BF%97logstash%E8%A7%A3%E6%9E%90JSON%E5%B5%8C%E5%A5%97.md)
* [使用Logstash将Kafka中的数据导入到ElasticSearch](https://niyanchun.com/export-data-from-kafka-to-es-with-logstash.html)
* [Logstash 集成 kafka 收集日志 笔记 (一) 过滤数据](https://jozdoo.github.io/elk/logstash/2016/10/21/logstash-filter.html)
* [Logstash 最佳实践](https://doc.yonyoucloud.com/doc/logstash-best-practice-cn/index.html)
* [日志收集之--将Kafka数据导入elasticsearch](https://www.cnblogs.com/moonandstar08/p/6556899.html)




