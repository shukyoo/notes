## 部署
* 数据流：Kafka->logstash->elasticsearch->kibana
* logstash配置语法
```
input {
  ...#读取数据，logstash已提供非常多的插件，可以从file、redis、syslog等读取数据
}
 
filter{
  ...#想要从不规则的日志中提取关注的数据，就需要在这里处理。常用的有grok、mutate等
}
 
output{
  ...#输出数据，将上面处理后的数据输出到file、elasticsearch等
}
```
示例
```
input {
    kafka {
        zk_connect => "c1:2181,c2:2181,c3:2181"
        group_id => "elasticconsumer"   ---随意取
        topic_id => "xxxlog"  ---与flume中的Channel保持一致
        reset_beginning => false
        consumer_threads => 5 
        decorate_events => true
        codec => "json"
        }
    }
output {
    elasticsearch {
        hosts => ["c4:9200","c5:9200"]
        index => "traceid"--与Kafka中json字段无任何关联关系，注意：index必须小写
        index => "log-%{+YYYY-MM-dd}"
        workers => 5
        codec => "json"
          }
     }
```


## 参考
* [日志收集之--将Kafka数据导入elasticsearch](https://www.cnblogs.com/moonandstar08/p/6556899.html)
