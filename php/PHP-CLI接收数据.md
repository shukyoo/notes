## 普通参数
一般通过$argv就可以接收后缀参数

## 大数据 | 管道输入
通过php://stdin来获取输入数据
* 可以是用户输入
* 可以是管道输入
```php
// test.php
while (false !== ($line = fgets(STDIN))) {
    echo $line;
}
```
```shell
echo "hello" | php test.php
```

## 参考
[Processing data with PHP using STDIN and Piping](http://www.gregfreeman.io/2013/processing-data-with-php-using-stdin-and-piping/)
