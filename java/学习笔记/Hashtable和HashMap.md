## HashMap
* Hashmap是一个数组和链表的结合体（在数据结构称“链表散列“）
* hashmap中put元素的时候，先根据key的hash值得到这个元素在数组中的位置（即下标），然后把这个元素放到对应的位置中。如果这个元素所在的位子上已经存放有其他元素了，那么在同一个位子上的元素将以链表的形式存放，新加入的放在链头，最先加入的放在链尾。


## HashMap和HashTable的区别
* HashTable继承Dictionary类，而hashMap继承了AbstractMap类，但是二者都实现了map接口
* HashMap不是线程安全的，而Hashtable是线程安全的，它每个方法中都加入了Synchronize，这使得它比HashMap慢
* HashMap允许一个空键和空值，但是Hashtable不允许空键或值
* Java5引入了ConcurrentHashMap，它是Hashtable的一个替代方案，并提供比Java中的Hashtable更好的可伸缩性
* HashMap中的迭代器是一个快速迭代器，而Hashtable的枚举器不是，并且如果任何其他线程通过添加或删除元素，而非通过Iterator自身的remove()修改映射，则抛出ConcurrentModificationException。但是，这不是一个有保证的行为，并将尽最大努力由JVM完成。这也是Java中的Enumeration和Iterator之间的一个重要区别
* HashMap底层是一个Entry数组，当发生hash冲突的时候，hashmap是采用链表的方式来解决的，在对应的数组位置存放链表的头结点。对链表而言，新加入的节点会从头结点加入。在hashmap做put操作的时候可能会造成数据丢失。现在假如A线程和B线程同时对同一个数组位置调用addEntry，两个线程会同时得到现在的头结点，然后A写入新的头结点之后，B也写入新的头结点，那B的写入操作就会覆盖A的写入操作造成A的写入操作丢失
* HashTable在不指定容量的情况下的默认容量为11，而HashMap为16，Hashtable不要求底层数组的容量一定要为2的整数次幂，而HashMap则要求一定为2的整数次幂
* 计算hash值的方法不同，HashMap先需要根据元素的KEY计算出一个hash值，然后再用这个hash值来计算得到最终的位置，Hashtable直接使用对象的hashCode。hashCode是JDK根据对象的地址或者字符串或者数字算出来的int类型的数值。然后再使用除留余数发来获得最终的位置。 



## HashMap底层实现原理
* HashMap的底层主要是基于数组和链表来实现的，它之所以有相当快的查询速度主要是因为它是通过计算散列码来决定存储的位置。
* HashMap中主要是通过key的hashCode来计算hash值的，只要hashCode相同，计算出来的hash值就一样，有可能不同的对象所算出来的hash值是相同的，这就出现了hash冲突，HashMap底层是通过链表来解决hash冲突的。

## HashMap和红黑树
* JDK1.8最重要的就是引入了红黑树的设计(当冲突的链表长度超过8个的时候)，为什么要这样设计呢？好处就是避免在最极端的情况下冲突链表变得很长很长，在查询的时候，效率会非常慢，红黑树查询时间复杂度O(logn)，链表查询时间复杂度O(n)
* 根据泊松分布，在负载因子0.75（HashMap默认）的情况下，单个hash槽内元素个数为8的概率小于百万分之一，将7作为一个分水岭，等于7时不做转换，大于等于8才转红黑树


## 参考
* [HashMap和HashTable区别](https://www.cnblogs.com/aeolian/p/8468632.html)
* [hashMap和hashTable的区别以及HashMap的底层原理](https://blog.csdn.net/prefect_start/article/details/101263985)
* [HashMap底层实现原理（上）](https://zhuanlan.zhihu.com/p/28501879)
* [HashMap底层实现原理（下）](https://zhuanlan.zhihu.com/p/28587782)
* [java.util.HashMap底层实现原理](https://www.jianshu.com/p/e44c0c1dcc38)
