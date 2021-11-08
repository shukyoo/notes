## 查看模板
```
GET /_template/test1
```

## 查看某个索引的mapping
```
GET /test_2020/_mapping
```

## 设置模板
```
PUT /_template/test1
{
    "order" : 0,
    "index_patterns" : [
      "mallslog*"
    ],
    "settings" : {
      "index" : {
        "mapping" : {
          "total_fields" : {
            "limit" : "100"
          },
          "depth" : {
            "limit" : "2"
          }
        }
      }
    },
    "mappings" : {
      "doc" : {
        "dynamic" : "false",
        "properties" : {
          "@timestamp" : {
            "type" : "date"
          },
          "@version" : {
            "index" : "false",
            "type" : "text"
          },
          "app" : {
            "type" : "text"
          },
          "msg" : {
            "type" : "text"
          }
        }
      }
    }
}
```
