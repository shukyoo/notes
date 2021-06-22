#### NIO流程图示
![NIO](https://github.com/shukyoo/notes/blob/master/java/img/13449209-300fd48a7251c327.webp)

并不是nio模式下服务响应的整体时间就会缩短，而是会提升CPU的利用率，因为CPU不再会阻塞等待（不可中断状态减少），这样CPU就能有更多的资源来处理其他的请求任务，相同单位时间内能处理更多的任务，所以nio模式带来的好处是：    

* 提升QPS（用更少的线程资源实现更高的并发能力）
* 降低CPU负荷,提高利用率

#### NIO原理
![NIO原理](https://github.com/shukyoo/notes/blob/master/java/img/2020-10-09_16-17-08.png)

#### NIO in Java
![标准IO和NIO对比](https://github.com/shukyoo/notes/blob/master/java/img/2020-10-09_21-27-33.png)



## 参考
* [一文带你彻底了解Java异步编程](https://ifeve.com/%e4%b8%80%e6%96%87%e5%b8%a6%e4%bd%a0%e5%bd%bb%e5%ba%95%e4%ba%86%e8%a7%a3java%e5%bc%82%e6%ad%a5%e7%bc%96%e7%a8%8b/)
