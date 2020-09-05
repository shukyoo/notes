这篇文章阐述了如何从curl_multi句柄获取数据。不久前，我将这段代码片段贴到了一个更大的示例代码中：
```php
  $active = NULL;
  do {
    $ret = curl_multi_exec($multi, $active);
  } while ($ret == CURLM_CALL_MULTI_PERFORM);

  while ($active && $ret == CURLM_OK) {
    if (curl_multi_select($multi) != -1) {
      do {
         $mrc = curl_multi_exec($multi, $active);
      } while ($mrc == CURLM_CALL_MULTI_PERFORM);
    }
  }
```
我之前没有真的去查过文档试图理解过它。所以这段代码让我感到困惑。现在我来解释下它都做了什么。
首先，这里有两个外层的循环。第一个负责清除curl缓存。第二个负责等待更多的数据，并且获取到这些数据。这就是一个典型的阻塞I/O例子。我们阻塞住剩下程序的执行直到网络I/O的结束。尽管这不是处理网络I/O最合适的方法，但对于单进程、同步的PHP，这实际上是我们仅有的选择。

让我们先来看下第一层循环：

```php
 $active = NULL;
 do {
   $ret = curl_multi_exec($multi, $active);
 } while ($ret == CURLM_CALL_MULTI_PERFORM);
```
curl_multi_exec尝试从multi句柄中获取写数据。$multi是之前调用curl_multi_init()方法产生的句柄，$active和$ret都是整型的值。
curl_multi_exec()把$active设为正在处理的句柄个数。换句话说，如果你正在用这个句柄请求5个URL，那么curl_multi_exec将返回5当它正在处理所有的5个URL（应该是指curl_multi_exec设$active为5），然后当每个请求结束时，这个数字将会逐渐减少直到0。

$ret是如下值的一种：

CURLM_CALL_MULTI_PERFORM(-1)：这意味着你需要再次调用curl_multi_exec()，因为仍有数据可供处理。
CURLM_OK(0)：如文档中所说：“都好了”。这意味着可能有更多的数据，但还没有到呢。
错误码中的一个：CURLM_BAD_HANDLE，CURLM_OUT_OF_MEMORY，CURLM_INTERNAL_ERROR，CURLM_BAD_SOCKET。所有这些表明我们需要停止处理。
所以当我们正在执行第一层循环，唯一需要我们继续迭代的情况就是CURLM_CALL_MULTI_PERFORM。

现在，对于一些相当小的情况，第一层循环就是你所需要的。然而通常的情况是，第一层循环会返回CURL_OK来表明还会有更多的数据，但是这些数据还没有在网络上传输过来呢。

我们需要wait。

这时候我们就需要第二层循环：

```php
 while ($active && $ret == CURLM_OK) {
   if (curl_multi_select($multi) != -1) {
     do {
        $mrc = curl_multi_exec($multi, $active);
     } while ($mrc == CURLM_CALL_MULTI_PERFORM);
   }
 }
```
这层循环是说...

  (while): 只要有活跃的连接，一切还看着都OK…
    (if) 如果网络socket还有些数据…
      (do/while) 只要系统告诉我们要一直去获取数据，我们就处理吧
所以第二层循环负责检查套接字直到一切就绪。
PHP手册对这些东西的细节有稍微的介绍，但是libcurl C的文档更加的完整。

## 参考：
[[译]php和curl_multi_exec](https://www.jianshu.com/p/7bb6891556fd)
