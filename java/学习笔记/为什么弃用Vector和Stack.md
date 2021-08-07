## Vector

#### 什么是Vector
* Vector类实现了动态数组的功能，它和ArrayList相近;
* 由于Vector从jdk1.0就有了，而那时候还没有系统的集合框架，所以Vector是一个古老的集合，提供了一些方法名很长的方法，jdk1.2后java提供了系统的集合框架就将vector改为实现List接口，导致里面有一些重复的方法，比如add和addElement

#### Vector和ArrayList的区别
* 它支持线程同步，是线程安全的，而ArrayList是线程不安全的，也因此它比ArrayList要慢，但是大多数情况下不使用Vector，因为线程安全需要更大的系统开销；
* ArrayList在内存不够时默认是扩展50% + 1个，Vector是默认扩展1倍；

#### 为什么弃用Vector
* jdk1.5新增了很多多线程情况下使用的集合类.位于java.util.concurrent.应该使用java.util.concurrent.CopyOnWriteArrayList或者Collections.synchronizedList
* Vector中对每一个独立操作都实现了同步，这通常不是我们想要的做法（对单一操作实现同步通常不是线程安全的，比如想遍历一个Vector实例。你仍然需要申明一个锁来防止其他线程在同一时刻修改这个Vector实例，即使你不需要同步，Vector也是有锁的资源开销的），事实上 Vector将“可变数组”的集合实现与“同步每一个方法”结合起来的做法是另一个糟糕的设计；

#### synchronizedList和CopyOnWriteArrayList区别
* synchronizedList获取数据和增加数据都是使用同步锁，CopyOnWriteArrayList增加数据时可重入锁，获取数据无锁。
* CopyOnWriteArrayList的写操作由于复制数组的原因所以性能较差，而synchronizedList读操作因为是采用了synchronized关键字的方式，其读操作性能并不如CopyOnWriteArrayList



## Stack
## 什么是Stack
Stack继承自Vector，Stack类表示后进先出（LIFO）的对象堆栈；

#### 为什么弃用Stack
* Deque 接口及其实现提供了 LIFO 堆栈操作的更完整和更一致的 set，应该优先使用此 set；
* 如果要使用Stack做类似的业务，那么非线程的可以选择linkedList，多线程可以选择java.util.concurrent.ConcurrentLinkedDeque或者java.util.concurrent.ConcurrentLinkedQueue

#### 关于Deque和Queue
* 参考：[关于Deque和Queue](https://github.com/shukyoo/notes/blob/master/java/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/%E5%85%B3%E4%BA%8EDeque%E5%92%8CQueue.md)
