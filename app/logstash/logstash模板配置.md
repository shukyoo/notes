## 主配置
```
input {
    kafka {
        bootstrap_servers => "kafka1:9092,kafka2:9092,kafka3:9092"
        group_id => "test"
        topics => ["test_hello"]
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
        hosts => ["es1:9200","es2:9200","es3:9200"]
        index => "test-%{+YYYYMMdd}"
        template => "/usr/local/logstash/conf/template/test_template.json"
        template_name => "test_template"
        manage_template => true
        template_overwrite => true
        codec => "json"
    }
}
```

## template 固定索引字段，不动态新增
```
{
  "template": "testhello*",
  "index_patterns" : [
    "testhello*"
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
        },
        "lv": {
          "type": "text"
        },
        "message": {
          "type": "text"
        },
        "msg": {
          "type": "text"
        },
        "ext": {
          "type": "text"
        }
      }
    }
  }
}
```
