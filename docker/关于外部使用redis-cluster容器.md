## 关于外部使用redis-cluster容器的问题和解决方法

redis-cluster(grokzen/redis-cluster)，启动后，外部PHP程序连接，无法使用；   
按照网上的解释：
> It looks like when Redis does that "Redirected to slot xxx" behavior, it doesn't proxy the connection through the Redis server, but rather simply passes the IP address of the appropriate server back to the client, which then initiates the connection directly (which is why you can't hit that Docker-internal IP address from the outside). For this to work, you'll probably have to ensure each instance of Redis has either its own external IP address or at least its own external port, and that they're all clustered using that external reference (since any client of the system needs to be able to access them in the same way they access each other).
大概意思是：要么给容器一个外部IP，要么映射到外部端口   

根据[grokzen/redis-cluster的文档说明](https://github.com/Grokzen/docker-redis-cluster)，再结合自己实验，给容器指定一个0.0.0.0的IP，把7000 - 7005映射到本地，然后本地就可以用127.0.0.1:7000 - 7005使用   
结合网上的解释，也意味着指定了本地IP和端口

## 方案总结
* 方法一，给容器分配外部IP，然后使用外部IP连接，如 172.16.1.113:7000 - 7005
* 方法二，给容器指定IP：0.0.0.0映射外部端口，然后使用本地IP+映射端口，如127.0.0.1:7000 - 7005
* 方法三，容器端口绑定到主机端口，本地相应端口代理到内部7000等端口（通过nginx代理）
