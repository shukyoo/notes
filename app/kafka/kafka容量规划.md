## kafka容量规划

* 消息保留时间：默认7天
* 容量预估：100万msg * 2Replic * 10k/msg * 7days / 1000 / 1000
* Replication数量：
  ** 1 无冗余，不建议
  ** 2 3台broker，2个冗余，down掉一台剩余2台情况下，仍保证消息不丢失，replica少，速度快
  ** 3以上 broker数量建议要3以上，这样才可保证冗余分布有效性，replica越多性能越差 
* Partition数量：
  ** partition > consumer，partition最好是consumer整数倍，partition越多，性能越好，可用性越差（1个partition针对1个并发）
  ** partition < consumer, 一个group下的consumer可能会闲置
  ** 一般情况：8? 16?

* 网络带宽决定Broker数量

> 我们的物联网系统一天每小时都要处理1Tb的数据，我们选择1Gb/b带宽，那么需要选择多少机器呢？
>
> 假设网络带宽kafka专用，且分配给kafka服务器70%带宽，那么单台Borker带宽就是710Mb/s，但是万一出现突发流量问题，很容易把网卡打满，因此在降低1/3,也即240Mb/s。因为1小时处理1TTB数据，每秒需要处理292MB,1MB=8Mb，也就是2336Mb数据，那么一小时处理1TB数据至少需要2336/240=10台Broker数据。冗余设计，最终可以定为20台机器。   


