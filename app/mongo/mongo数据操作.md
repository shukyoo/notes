#### 连接
```
mongo host:port/database -u user -p password
```

#### 创建库
```
// 如果库不存在，会创建，但是需要添加了数据后才会看到
use test
```

#### 创建collection
```
// 方法一，可选参数参考以下链接
db.createCollection("hello")

// 方法二，直接插入数据，不存在的集合会自动创建
db.mycollection.insert({"name":"tom"})
```
参考：[MongoDB 创建集合](https://www.runoob.com/mongodb/mongodb-create-collection.html)

#### 创建索引
```
db.collection.createIndex(keys, options)
// 示例如下，1为升序，-1为降序
db.col.createIndex({"title":1})
```
参考：[MongoDB 索引](https://www.runoob.com/mongodb/mongodb-indexing.html)

#### 查看索引
```
db.hello.getIndexes()
```

#### 删除索引
```
db.hello.dropIndex({"xxxxxx":1})

db.col.dropIndex("索引名称")

// 删除所有索引
db.col.dropIndexes()
```


# 查询
#### 简单查询
```
db.hello.find()  // 查询所有
db.hello.find().pretty()  // 优化显示
db.hello.find({"name":"tom"}) // 简单条件
```
