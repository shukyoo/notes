## 查看最大连接数
```
show variables like '%max_connections%';
```

## 查看数据库当前状态
```
show status;
```
可以看到Max_used_connections 同时使用的连接数的最大数目   



## PHP是短连接，当并发上来后为什么出现很多slee连接？   

So if you have a lot of sleeping connections, but MySQL is performing well, most likely it is PHP or Apache slowing things down.   

When a database connection is created, a session is also created on the database server simultaneously, but if that connection and session is not closed properly, then the query goes into sleep mode after the wait time gets over.   

> Sleep is the thread waiting for the client to send a new statement to it   

## Why MySQL Sleep Processes take place?
> Connections waiting for a new MYSQL query, better known as the sleep processes, occur if in coding persistent connection to the database is used or if the database connection is not closed properly.
> So, you get connections in the sleep state when a PHP script connects to MySQL, queries are executed and the connection is left open without disconnecting from the server.
> Until the thread dies, any pre-thread buffers will be kept in the memory for 28,800 seconds in MySQL by default.
> So, when many PHP processes stay connected without doing anything on the database, you end up with many processes in the sleep state.

## 可以看到总连接数多大多数都是空闲连接，为什么空闲连接没有释放呢？
* 应用使用长连接模式：对于长连接模式（比如Java应用），应用侧应该配置连接池。连接池的初始连接数设置过高，应用启动后建立多个到RDS实例空闲连接。
* 应用使用短连接模式：对于短连接模式（比如PHP应用），出现大量的空闲连接说明应用没有在查询执行完毕后显式的关闭连接。

## 造成睡眠连接过多的原因？
* 使用了太多持久连接（个人觉得，在高并发系统中，不适合使用持久连接）
* 程序中，没有及时关闭mysql连接
* 数据库查询不够优化，过度耗时

## 解决方法
* 通过DMS或者kill命令来终止当前空闲会话，利用show processlist查看id，然后kill id
* 长连接模式需要启用连接池的复用功能
* 短连接模式需要在代码中修改查询结束后调用关闭连接的方法
* 对于非交互模式连接，在控制台的参数设置里设置wait_timeout参数为较小值
* wait_timeout, 即可设置睡眠连接超时秒数，如果某个连接超时，会被mysql自然终止

## 更根本的方法，还是从以上三点排查之
* 程序中，不使用持久链接，即使用mysql_connect而不是pconnect
* 程序执行完毕，应该显式调用mysql_close
* 只能逐步分析系统的SQL查询，找到查询过慢的SQL,优化之



## MySQL为什么会有一大堆在Sleep的进程？

**那么造成sleep的原因，有三个，下面是mysql手册给出的解释:**
1. 客户端程序在退出之前没有调用mysql_close(). 
2. 客户端sleep的时间在wait_timeout或interactive_timeout规定的秒内没有发出任何请求到服务器. 
3. 客户端程序在结束之前向服务器发送了请求还没得到返回结果就结束掉了. 

**原文请见下面:**
1. The client program did not call mysql_close() before exiting. 
2. The client had been sleeping more than wait_timeout or interactive_timeout seconds without issuing any requests to the server. 
3. The client program ended abruptly in the middle of a data transfer 


## PHP是否需要显性关闭mysql连接
不需要，如下：
> Upon successful connection to the database, an instance of the PDO class is returned to your script. The connection remains active for the lifetime of that PDO object. To close the connection, you need to destroy the object by ensuring that all remaining references to it are deleted--you do this by assigning NULL to the variable that holds the object. If you don't do this explicitly, PHP will automatically close the connection when your script ends.
[Is it necessary to close PDO connections](https://stackoverflow.com/questions/15444748/is-it-necessary-to-close-pdo-connections)

