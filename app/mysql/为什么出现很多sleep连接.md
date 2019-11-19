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
以前我一直认为，当php的页面执行结束时，会自动释放掉一切。相信很多人都跟我想的一样。但事实证明并不是这样。比如session就不会随着页面执行完毕而释放。 
php的垃圾回收机制，其实只针对于php本身。对于mysql，php没权利去自动去释放它的东西。如果你在页面执行完毕前不调用mysql_close()，那么mysql那边是不会关闭这个连接的。如果你是用的是pconnect方式，即使你在页面执行完毕前调用mysql_close()，也无法另mysql关闭这个连接。 
也许在负载低的情况下，你感受不到有何不妥。
下面我就来解释这两天我观察出的现象: 
在php中使用pconnect方式建立连接，然后到mysql客户端下执行show processlist；如果你的负载到一定程度的话，你可以看到很多sleep的进程，这些进程就是人们常说的死连接，它们会一直保持sleep，直到my.cnf里面设置的wait_timeout这个参数值的时间到了，mysql才会自己杀死它。在杀死它的时候，mysql还会在error-log里面记录一条Aborted connection xxx to db: 'xxx' user: 'xxx' host: 'xxx'的日志，用google翻译一下，会得到一个相当强悍的解释"胎死腹中的连接"! 

**那么造成sleep的原因，有三个，下面是mysql手册给出的解释:**
1. 客户端程序在退出之前没有调用mysql_close(). 
2. 客户端sleep的时间在wait_timeout或interactive_timeout规定的秒内没有发出任何请求到服务器. 
3. 客户端程序在结束之前向服务器发送了请求还没得到返回结果就结束掉了. 

**原文请见下面:**
1. The client program did not call mysql_close() before exiting. 
2. The client had been sleeping more than wait_timeout or interactive_timeout seconds without issuing any requests to the server. 
3. The client program ended abruptly in the middle of a data transfer 

如果你的sleep进程数在同一时间内过多，再加上其他状态的连接，总数超过了max_connection的值，那mysql除了root用户外，就无法再继续处理任何请求无法与任何请求建立连接或者直接down了。   
   
所以，这个问题在大负载的情况下还是相当严重的。如果发现你的mysql有很多死连接存在，首先要先检查你的程序是否使用的是pconnect的方式，其次，检查在页面执行完毕前是否及时调用了mysql_close()， 还有一个办法，你可以在my.cnf里面加上wait_timeout和interactive_timeout，把他们的值设的小一些，默认情况下wait_timeout的值是8小时的时间，你可以改成1个小时，或半个小时。这样mysql会更快的杀死死连接。防止连接总数超过max_connection的值。或者把max_connection的值设置的更大，不过这样显然不妥，连接的数量越多，对你服务器的压力越大。实际上那些连接都是冗余的，把它们尽快杀死才是上策。   
   
以前总是说，在使用php连接mysql的时候，尽量不要使用pconnect的方式，看完我上面所说的那些，应该可以明白为什么了吧，因为我们使用php大多数情况下都是做web开发，web开发是面向多用户，那么用户的数量与mysql连接数是成正比的。使用pconnect的方式，即使你的调用mysql_close()也是无法释放数据库连接的，那么mysql中的死连接的数量就会越来越多了。    
   
我认为，只有当你的应用属于那种点对点方式，或者你能保证连接数量很少的情况，才有必要去采用pconnect的方式，因为连接数量少，那么让它一直处于连接状态，避免了重复打开关闭的过程。这样可能会比传统方式更好一些。    
   
至于何时该去调用mysql_close()，最正确的做法是如果下面不再执行mysql的操作了，在你上一次执行完mysql操作后，立刻就调用mysql_close()。这才是最正确的做法，并不是总要把mysql_close()写在页面最后一行就可以了。   

