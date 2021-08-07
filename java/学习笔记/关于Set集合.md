## 什么是Set
* Set集合类似于一个罐子，程序可以依次把多个对象“丢进”Set集合，而Set集合通常不能记住元素的添加顺序，Set集合不允许包含相同的元素
* 由于Set集合中并没有角标的概念，所以并没有像List一样提供get方法。当获取HashSet中某个元素时，只能通过遍历集合的方式进行equals()比较来实现
* Set接口因为是无序的，所以没有提供像List一样的set方法来修改元素，查找，添加、删除是没问题的

## HashSet
* HashSet是Set接口的典型实现，底层是用了HashMap，大多数时候使用Set集合时就是使用这个实现类。HashSet按Hash算法来存储集合中的元素，因此具有很好的存取和查找性能。底层数据结构是哈希表（一个元素为链表的数组，综合了数组与链表的优点）
* 新增元素相当于HashMap的key，value默认为一个固定的Object，相当于一个阉割版的HashMap

#### HashSet具备以下特点
* 不允许出现重复因素；
* 允许插入Null值；
* 元素无序（添加顺序和遍历顺序不一致）；
* 线程不安全，若2个线程同时操作HashSet，必须通过代码实现同步；

## TreeSet
* TreeSet是红黑树结构，每一个元素都是树中的一个节点，插入的元素都会进行排序
* TreeSet具有排序功能，分为自然排序(123456)和自定义排序两类，默认是自然排序，按照任意顺序将元素插入到集合中，等到遍历时TreeSet会按照一定顺序输出--倒序或者升序

#### TreeSet特点
* 对插入的元素进行排序，是一个有序的集合（主要与HashSet的区别）;
* 底层使用红黑树结构，而不是哈希表结构；
* 允许插入Null值；
* 不允许插入重复元素；
* 线程不安全；

## LinkedHashSet
* HashSet还有一个子类LinkedList、LinkedHashSet集合也是根据元素的hashCode值来决定元素的存储位置，但它同时使用链表维护元素的次序，这样使得元素看起来是以插入的顺序保存的，也就是说当遍历集合LinkedHashSet集合里的元素时，集合将会按元素的添加顺序来访问集合里的元素。输出集合里的元素时，元素顺序总是与添加顺序一致。但是LinkedHashSet依然是HashSet，因此它不允许集合重复。


## HashMap和Hashtable
* 参考：[HashTable和HashMap](https://github.com/shukyoo/notes/blob/master/java/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/Hashtable%E5%92%8CHashMap.md)
