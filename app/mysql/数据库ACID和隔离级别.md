## ACID
* 数据库事务特征，即 ACID
* Atomicity 原子性, 事务要么完全执行,要么完全不执行
* Consistency 一致性, 事务完成时,数据必须处于一致的状态.若事务执行途中出错,会回滚到之前的事务没有执行前的状态
* Isolation 隔离性, 同时处理多个事务时,一个事务的执行不能被另一个事务所干扰,事务的内部操作与其他并发事务隔离
* Durability 持久性, 事务提交后,对数据的修改是永久性的.

## 隔离级别
* Read uncommttied（可以读取未提交数据）
* Read committed（可以读取已提交数据）
* Repeatable read（可重复读）
* Serializable（可串行化）

## 参考
* [脏读、幻读与不可重复读](https://juejin.cn/post/6844903665367547918)
* [一文带你理解脏读,幻读,不可重复读与mysql的锁,事务隔离机制](https://zhuanlan.zhihu.com/p/87178693)
* [快速理解脏读、不可重复读、幻读和MVCC](https://cloud.tencent.com/developer/article/1450773)
