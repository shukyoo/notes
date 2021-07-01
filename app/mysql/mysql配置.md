## 最大连接数
#### 查看最大连接数
```
show variables like '%max_connections%';
```

#### 查看当前状态连接数量
```
show global status like 'Max_used_connections';
```

#### 设置最大连接数
当前进程下用命令全局设置（重启失效）
```
set GLOBAL max_connections=512;
```
设置到配置文件中[mysqld]
```
max_connections=512
```
