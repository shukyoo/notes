# 一对多的三种设计方案

## One-to-Few（一对有限数量的多）
如订单和商品，这种情况下采用嵌入式模式（embedding）


## One-to-Many（一对千量级的多，可预见）
如产品和配件，这种情况下适合采用child reference（在Product中添加引用数组）


## One-to-Squillions（一对无数）
如系统日志，一直在产生，这种情况下适合采用parent reference（在每条record中，添加一个反向引用，指向Host）


# 设计指南
* 优先考虑内嵌，除非有什么迫不得已的原因。
* 需要单独访问一个对象，那这个对象就不适合被内嵌到其他对象中。
* 数组不应该无限制增长。如果many端有数百个文档对象就不要去内嵌他们可以采用引用ObjectID的方案；如果有数千个文档对象，那么就不要内嵌ObjectID的数组。该采取哪些方案取决于数组的大小。
* 不要害怕应用层级别的join：如果索引建的正确并且通过投影条件（第二章提及）限制返回的结果，那么应用层级别的join并不会比关系数据库中join开销大多少。
* 在进行反范式设计时请先确认读写比。一个几乎不更改只是读取的字段才适合冗余到其他对象中。
* 在mongodb中如何对你的数据建模，取决于你的应用程序如何去访问它们。数据的结构要去适应你的程序的读写场景。


# 参考
* [MongoDB一对多模式的三种设计方案](https://blog.csdn.net/Justinjiang1314/article/details/80771449)
* [6 Rules of Thumb for MongoDB Schema](https://www.mongodb.com/blog/post/6-rules-of-thumb-for-mongodb-schema-design-part-3)
