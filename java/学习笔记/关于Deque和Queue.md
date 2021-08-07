## 什么是Queue
* 队列(queue)是一种常用的数据结构，可以看做是一种特殊的线性表，该结构遵循的先进先出原则，LinkedList实现了Queue接口
* PriorityQueue直接实现了Queue接口的类，但是它并不是真正意义上的队列，而是一个优先队列，保存元素的顺序并不是按照加入的顺序，而是根据元素的大小（实现Comparable接口或提供Comparator类）来决定元素在Queue队列中的顺序；

## 什么是Deque
* Deque的含义是“double ended queue”（通常读为“deck”），即双端队列，它既可以当作栈使用，也可以当作队列使用
* Deque接口继承Queue接口，双端队列就囊括了队列、双端队列、堆栈（Deque接口又定义了Stack的操作方法）这3种数据结构的特性，不同的数据结构应该使用不同的语义化方法
* java.util.Deque的实现子类有java.util.LinkedList和java.util.ArrayDeque.前者是基于链表,后者基于数组实现的双端队列
* PriorityQueue优先队列没有对应的并发类，但是Queue接口有对应的并发实现类：java.util.concurrent.ConcurrentLinkedQueue类。Deque接口有对应的并发实现类：java.util.concurrent.ConcurrentLinkedDeque类

## ArrayDeque
* ArrayDeque底层通过数组实现，为了满足可以同时在数组两端插入或删除元素的需求，该数组还必须是循环的，即循环数组（circular array），也就是说数组的任何一点都可能被看作起点或者终点。ArrayDeque是非线程安全的（not thread-safe），当多个线程同时使用的时候，需要手动同步

## LinkedList
* LinkedList实现了Deque接口,因此其具备双端队列的特性,由于其是链表结构,因此不像ArrayDeque要考虑越界问题和容量问题,那么对应操作就很简单了,另外当需要使用栈和队列是官方推荐的是ArrayDeque

## ArrayDeque和LinkedList的比较
* LinkedList和ArrayDeque的方法声明都是一致的，只不过LinkedList较之于ArrayDeque多实现了List接口，还具有有序集合List的特性。
* 如果只需要Deque接口，从两端进行操作，ArrayDeque效率更高一些，如果同时需要根据索引位置进行操作，或者经常需要在中间进行插入和删除，则应该选LinkedList（这里使用的是List特性）
