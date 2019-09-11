## 简介
Future提供了一套高效便捷的非阻塞并行操作管理方案。其基本思想很简单，所谓Future，指的是一类占位符对象，用于指代某些尚未完成的计算的结果。一般来说，由Future指代的计算都是并行执行的，计算完毕后可另行获取相关计算结果。以这种方式组织并行任务，便可以写出高效、异步、非阻塞的并行代码。

默认情况下，future和promise并不采用一般的阻塞操作，而是依赖回调进行非阻塞操作。为了在语法和概念层面更加简明扼要地使用这些回调，Scala还提供了flatMap、foreach和filter等算子，使得我们能够以非阻塞的方式对future进行组合。当然，future仍然支持阻塞操作——必要时，可以阻塞等待future（不过并不鼓励这样做）。

## Future
所谓Future，是一种用于指代某个尚未就绪的值的对象。而这个值，往往是某个计算过程的结果：

若该计算过程尚未完成，我们就说该Future未就位；
若该计算过程正常结束，或中途抛出异常，我们就说该Future已就位。
Future的就位分为两种情况：

当Future带着某个值就位时，我们就说该Future携带计算结果成功就位。
当Future因对应计算过程抛出异常而就绪，我们就说这个Future因该异常而失败。
Future的一个重要属性在于它只能被赋值一次。一旦给定了某个值或某个异常，future对象就变成了不可变对象——无法再被改写。

创建future对象最简单的方法是调用future方法，该future方法启用异步(asynchronous)计算并返回保存有计算结果的futrue，一旦该future对象计算完成，其结果就变的可用。

## Callbacks(回调函数)
现在我们知道如何开始一个异步计算来创建一个新的future值，但是我们没有展示一旦此结果变得可用后如何来使用，以便我们能够用它来做一些有用的事。我们经常对计算结果感兴趣而不仅仅是它的副作用。

在许多future的实现中，一旦future的client对future的结果感兴趣，它不得不阻塞它自己的计算直到future完成——然后才能使用future的值继续它自己的计算。虽然这在Scala的Future API（在后面会展示）中是允许的，但是从性能的角度来看更好的办法是一种完全非阻塞的方法，即在future中注册一个回调，future完成后这个回调称为异步回调。如果当注册回调时future已经完成，则回调可能是异步执行的，或在相同的线程中循序执行。

## 函数组合(Functional Composition)和For解构(For-Comprehensions)
尽管前文所展示的回调机制已经足够把future的结果和后继计算结合起来的，但是有些时候回调机制并不易于使用，且容易造成冗余的代码。

## 投影(Projections)
为了确保for解构(for-comprehensions)能够返回异常，futures也提供了投影(projections)。如果原future对象失败了，失败的投影(projection)会返回一个带有Throwable类型返回值的future对象。如果原Future成功了，失败的投影(projection)会抛出一个NoSuchElementException异常。

## Promises
到目前为止，我们仅考虑了通过异步计算的方式创建future对象来使用future的方法。尽管如此，futures也可以使用promises来创建。

如果说futures是为了一个还没有存在的结果，而当成一种只读占位符的对象类型去创建，那么promise就被认为是一个可写的，可以实现一个future的单一赋值容器。这就是说，promise通过这种success方法可以成功去实现一个带有值的future。相反的，因为一个失败的promise通过failure方法就会实现一个带有异常的future。


## 参考
[Future与Promise](https://www.cnblogs.com/cbscan/articles/4143573.html)
[Go 语言中使用 Future/Promise 编程模式](https://www.jianshu.com/p/819aa9b9af86)
