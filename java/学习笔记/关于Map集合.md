## 什么是Map
* Map用于保存具有映射关系的数据，Map集合里保存着两组值，一组用于保存Map的ley，另一组保存着Map的value，key不能重复且没有顺序
* Map基于hash算法快速查询，O(1)复杂度
* Map与Collection在集合框架中属并列存在，Collection是单列集合, Map 是双列集合
* 对于Map的遍历，建议使用entrySet迭代器方式，在进行大量级数据时，效率会高很多

## 遍历Map的方式
* 第一种方式:使用keySet，将Map转成Set集合（keySet()），通过Set的迭代器取出Set集合中的每一个元素（Iterator）就是Map集合中的所有的键，再通过get方法获取键对应的值
* 第二种方式: 通过values 获取所有值,不能获取到key对象
* 第三种方式: Map.Entry，通过Map中的entrySet()方法获取存放Map.Entry<K,V>对象的Set集合，面向对象的思想将map集合中的键和值映射关系打包为一个对象，就是Map.Entry，将该对象存入Set集合，Map.Entry是一个对象，那么该对象具备的getKey，getValue获得键和值

## HashMap
* 平时开发中最常用的map，底层实现为数组+链表，它根据键key的HashCode值存储数据，可以使用get(key)来获取键对应的值，是线程不安全的。HashMap允许可以存入null键，null值。在数据量小的时候，HashMap是以链表的模式存储数据；当数据量变大后，为了进行快速查找，会将这个链表变为红黑树来进行保存，使用key的哈希值来进行查找。

## ConcurrentHashMap
* ConcurrentHashMap也是线程安全的，但性能比HashTable好很多，HashTable是锁整个Map对象，而ConcurrentHashMap是锁Map的部分结构
* ConcurrentHashMap采用了分段锁技术，没有同Hashtable一样锁住全部数据，而是锁定线程访问的那一段数据。对个线程在访问不同段数据时就不会存在等待。
* ConcurrentHashMap的主干是Segment数组。每个Segment就相当于一个小的HashTable，知道不修改访问同一个Segment上的数据就不会存在并发问题

## LinkedHashMap
* 和HashSet中的LinkedHashSet一样，HashMap也有一个LinkedHashMap子类，使用双向链表来维护键值对的次序，迭代顺序和插入顺序保持一致

## TreeMap
* 正如Set接口派生出SortedSet子接口，Sorted接口有一个TreeSet实现类一样，Map接口也派生出一个SortedMap子接口，SortedMap接口也有一个TreeMap实现类
* TreeMap就是一个红黑树数据结构，每个键值对作为红黑树的一个节点。存储键值对时根据key对节点进行排序。可以保证所有键值对处于有序状态。和TreeSet一样，TreeMap也有自然排序和定制排序两种排序方式。
* 排序实现：方式一：元素自身具备比较性，方式二：容器具备比较性

## WeakHashMap
WeakHashMap与HashMap的用法基本相似，区别在于HashMap的key保留了对实际对象的强引用，这意味着只要该对象不销毁，该HashMap的所有key所引用的对象就不会被垃圾回收，HashMap也不会自动删除这些key所对应的键值对，但WeakHashMap的key只保留了对实际对象的弱引用，这意味着如果WeakHashMap对象的key所引用的对象没有被其他强引用变量所引用，则这些key所引用的对象可能被垃圾回收，WeakHashMap也可能自动删除这些key对应的键值对。

## IdentityHashMap
这个类的实现机制与HashMap基本相似，但它在处理两个key相等时比较独特：在IdentityHashMap中，当且仅当两个key严格相等(key1==key2)时，IdentityHashMap才认为两个key相等，对于普通的HashMap而言，只要key1和key2通过equals方法比较返回true，且它们的hashcode相等即可。

## 参考
* [HashMap和HashTable](https://github.com/shukyoo/notes/blob/master/java/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/Hashtable%E5%92%8CHashMap.md)

