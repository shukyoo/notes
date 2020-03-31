# 一对多的三种设计方案

## One-to-Few（一对有限数量的多）
如订单和商品，这种情况下采用嵌入式模式（embedding）


## One-to-Many（一对千量级的多，可预见）
如产品和配件，这种情况下适合采用child reference（在Product中添加引用数组）


## One-to-Squillions（一对无数）
如系统日志，一直在产生，这种情况下适合采用parent reference（在每条record中，添加一个反向引用，指向Host）



# 参考
* [MongoDB一对多模式的三种设计方案](https://blog.csdn.net/Justinjiang1314/article/details/80771449)
