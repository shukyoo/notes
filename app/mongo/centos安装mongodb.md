## 下载
* https://www.mongodb.com/download-center/community
* 选择相应版本，选择下载tgz压缩包

## 解压安装
1. tar -xf mongodb-linux-x86_64-4.0.6.tgz
2. mv mongodb-linux-x86_64-4.0.6 /usr/local/mongodb

## 配置
1. cd /usr/local/mongodb
2. mkdir -p data/db
3. mkdir logs
4. touch logs/mongodb.log
5. vim mongodb.conf
```
#端口号
port=27017
#db目录
dbpath=/usr/local/mongodb/data/db
#日志目录
logpath=//usr/local/mongodb/logs/mongodb.log
#后台
fork=true
#日志输出
logappend=true
#允许远程IP连接
bind_ip=0.0.0.0
```

## 启动和测试
1. 启动：bin/mongod --config mongodb.conf
2. 连接：bin/mongo
3. 测试
```
> show dbs
> db.createCollection("test")
> db.test.insert({"hello":"world"})
> db.test.find()
```

## 配置开机启动
```
cd /lib/systemd/system

cat >>mongodb.service<<EOF
[Unit]
Description=mongodb
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=forking
ExecStart=/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/mongodb.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/usr/local/mongodb/bin/mongod --shutdown --config /usr/local/mongodb/mongodb.conf
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

# 权限
chmod +x mongodb.service

# 启动 | 停止 | 重启
systemctl (start | stop | restart) mongodb.service

# 开机启动
systemctl enable mongodb.service
```

## 添加环境变量
```
# 直接export
export PATH=$PATH:/usr/local/mongodb/bin

# 永久变更
cat >>/etc/profile<<EOF
export PATH="$PATH:/usr/local/mongodb/bin"
EOF

source /etc/profile

# 修改.bashrc
cat >>/root/.bashrc<<EOF
export PATH="$PATH:/usr/local/mongodb/bin"
EOF
```




