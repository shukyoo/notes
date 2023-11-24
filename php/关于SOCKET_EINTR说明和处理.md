## php里什么是SOCKET_EINTR，是什么原因会引发SOCKET_EINTR，针对这个错误需要怎么处理？
SOCKET_EINTR可以被理解为系统调用中断，是PHP中的一个错误代码。它一般发生在以下两种场景：

1. 当一个阻塞的系统调用（例如：sockets、read()、wait()等）被某个信号打断时，会返回一个错误SOCKET_EINTR。
2. 当一个应用程序在执行一个长时间运行的任务时，操作系统可能会发送一个中断信号给它，通常来自用户的键盘输入，比如按下Ctrl+C。如果程序正在执行一个系统调用的过程中收到这样的信号，在某些情况下，系统调用将被中断而不再进行下去，然后返回一个错误：SOCKET_EINTR。
针对这个错误的处理方案：

处理SOCKET_EINTR的通用策略是重新开始被中断的系统调用，除非你的程序收到一个信号并且已经预设了一个信号处理函数（signal handler）来处理这个信号。    

例如，使用while循环来自动重新启动被interrupt的系统调用，对于一个socket recv调用，代码可以是：
```php
while (true) { 
    $result = socket_recv($socket, $buf, $len, $flags); 
    if ($result === false) { 
        $errorcode = socket_last_error(); 
        if ($errorcode == SOCKET_EINTR) { 
            continue; 
        } else { 
            // 其他错误处理 
        } 
    } 
    break; 
}
```
这种处理方式称为重启系统调用，但要注意的是，并不是所有的系统调用都是可以被安全重启的。目前大多数现代操作系统会隐式地为可中断的系统调用重启，但某些较旧的或特定的系统可能没有这样的行为，需要开发者自己设计信号处理机制。
    
当一个socket请求响应比较慢的情况下会被系统中断，这时候需要处理SOCKET_EINTR继续启动接收，但是可以设置一个超时时间，以下示例：
```php
$prefixBody = "";  
$readLen = 0;  
$timeout = 20;  //超时时间 
 
//先进行一次尝试性读取，如果成功则不需要进行复杂处理 
$readLen = @socket_recv($this->socket, $prefixBody, 17, MSG_WAITALL);  
if($readLen !== false && $readLen === 17){ 
    return; 
} 
 
// 如果尝试性读取失败，再进行复杂的处理 
$prefixBody = "";  // 清空尝试性读取的结果 
$endTime = time() + $timeout;  // 计算最大结束时间 
while(strlen($prefixBody) < 17) {  
    $buffer = "";  
    $readLen = @socket_recv($this->socket, $buffer, 17 - strlen($prefixBody), MSG_WAITALL);  
    if($readLen === false) { 
        if(time() >= $endTime) {  
            throw new Exceptions\PrefixException('Read from socket timeout.');  
        } 
        if(socket_last_error($this->socket) == SOCKET_EINTR) {  
            continue; 
        } else { 
            throw new Exceptions\PrefixException(sprintf("Unable to read prefix from socket: %s", socket_strerror(socket_last_error($this->socket))));  
        }  
    } else if ($readLen > 0) { 
        $prefixBody .= $buffer; 
    }  
} 
 
if(strlen($prefixBody) != 17) { 
    throw new Exceptions\PrefixException("Incomplete message received from socket.");  
}  
```
