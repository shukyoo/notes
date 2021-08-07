## Array和List
* Array（数组）是基于索引(index)的数据结构，它使用索引在数组中搜索和读取数据是很快的
* List是一个有序的集合，可以包含重复的元素，提供了按索引访问的方式，它继承Collection，有两个重要的实现类：ArrayList和LinkedList

## ArrayList和LinkedList区别
* ArrayList是基于数组实现的，LinkedList是基于双链表实现的。另外LinkedList类不仅是List接口的实现类，可以根据索引来随机访问集合中的元素，除此之外，LinkedList还实现了Deque接口，因此LinkedList可以作为双向队列 ，栈和List集合使用
* 因为Array是基于索引(index)的数据结构，它使用索引在数组中搜索和读取数据是很快的，可以直接返回数组中index位置的元素，因此在随机访问集合元素上有较好的性能。Array获取数据的时间复杂度是O(1)，但是要插入、删除数据却是开销很大的，因为这需要移动数组中插入位置之后的的所有元素，还需要更新索引，最坏的情况时间复杂度是O(n)。
* LinkedList的随机访问集合元素时性能较差，因为需要在双向列表中找到要index的位置再返回；但在插入和删除操作是更快的，因为LinkedList不需要改变数组的大小，也不需要在数组装满的时候要将所有的数据重新装入一个新的数组，时间复杂度仅为O(1)
* LinkedList需要更多的内存，因为ArrayList的每个索引的位置是实际的数据，而LinkedList中的每个节点中存储的是实际的数据和前后节点的位置

## 使用场景
* 如果应用程序对数据有较多的随机访问，ArrayList对象要优于LinkedList对象
* 如果应用程序有更多的插入或者删除操作，较少的随机访问，LinkedList对象要优于ArrayList对象
* List靠近末尾的地方插入，那么ArrayList只需要移动较少的数据，而LinkedList则需要一直查找到列表尾部，反而耗费较多时间，这时ArrayList就比LinkedList要快


## 关于Deque和Queue
* 参考：[关于Deque和Queue](https://github.com/shukyoo/notes/blob/master/java/%E5%AD%A6%E4%B9%A0%E7%AC%94%E8%AE%B0/%E5%85%B3%E4%BA%8EDeque%E5%92%8CQueue.md)
