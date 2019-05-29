## PHP-CLI超时测试问题
之前想通过sleep(5)的形式来测试脚本超时，但是发现max-execution-time和set_time_limit都没有效果；   

## 在serverfault上找到答案

In your test script you used sleep(5) to test long running execution time but that is not a valid test.

The docs for max-execution-time say this:

> The maximum execution time is not affected by system calls, stream operations etc.

and the docs for set_time_limit() say this:

> Any time spent on activity that happens outside the execution of the script such as system calls using system(), stream operations, database queries, etc. is not included when determining the maximum time that the script has been running. This is not true on Windows where the measured time is real.

If you avoid the sleep system call, set_time_limit(5); should work fine in CLI scripts. Here's a test script that should exit after 5s:

```php
<?php
set_time_limit(5);

$start = time();
$last = 0;

for ($i=0;$i>=0;$i++) {
    if ($i%10000==0) {
        $took = time()-$start;
        if ($took!=$last) {
            echo "taken {$took} s so far...\n";
            $last=$took;
        }
    }
}
```
```shell
php timeout_test.php 
taken 1 s so far...
taken 2 s so far...
taken 3 s so far...
taken 4 s so far...
taken 5 s so far...
PHP Fatal error:  Maximum execution time of 5 seconds exceeded in /home/tom/MailChap/timeout_test.php on line 8
PHP Stack trace:
PHP   1. {main}() /home/tom/MailChap/timeout_test.php:0
```

#### 参考
[How do you set max execution time of PHP's CLI component?](https://serverfault.com/questions/283397/how-do-you-set-max-execution-time-of-phps-cli-component)

