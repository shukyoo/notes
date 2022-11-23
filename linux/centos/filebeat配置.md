## filebeat.yml配置
```
#=========================== globle config  ===================================
path.home: /usr/local/filebeat
path.data: ${path.home}/bin/data
path.logs: ${path.home}/logs
path.config: /etc/filebeat
#=========================== Filebeat prospectors =============================
filebeat.config.prospectors:
  enabled: true
  path: ${path.config}/config/*.yml
max_procs: 1
clean_inactive: 168h
scan_frequency: 5s
spool_size: 256
  #exclude_lines: ['^DBG']
  #include_lines: ['^ERR', '^WARN']
  #exclude_files: ['.gz$']
  #fields:
  #  level: debug
  #  review: 1

#============================= Filebeat modules ===============================

filebeat.config.modules:
  # Glob pattern for configuration loading
  path: ${path.config}/modules.d/*.yml

  # Set to true to enable config reloading
  reload.enabled: false

  # Period on which files under path should be checked for changes
  #reload.period: 10s

#===========================    output     ============================================
output.kafka:
  hosts: ["my1.kafka:9092","my2.kafka:9092","my3.kafka:9092"]
  topic: '%{[fields][log_topics]}'
  key: '%{[fields]}'
  partition.round_robin:
      reachable_only: false
  codec.format:
      string: '%{[message]}'
  required_acks: 1
  compression: gzip
  max_message_bytes: 1000000
#----------------------------- Logstash output --------------------------------
#output.logstash:
#  # The Logstash hosts
#  hosts: ["10.97.200.230:5045"]
```

## 具体业务配置
```
# config/my.conf
- type: log
  enabled: true
  paths:
    - /var/logs/biz.log
  tail_files: true
  fields:
    hostname: ${IP0}
    log_topics: bizlog
    log_type: log

- type: log
  enabled: true
  paths:
    - /var/logs/trace.log
  tail_files: true
  fields:
    hostname: ${IP0}
    log_topics: tracelog
    log_type: log
```
