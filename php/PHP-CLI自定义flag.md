## 示例
```php
$options = getopt("f:hp:");
var_dump($options);
```

test.php -f aaa -h -p test输出
```
array(3) {
  ["f"]=>
  string(2) "aa"
  
  ["h"]=>
  bool(false)
  
  ["p"]=>
  string(2) "vv"
}
```

## 说明
* 单独的字符（不接受值）
* 后面跟随冒号的字符（此选项需要值）
* 后面跟随两个冒号的字符（此选项的值可选）
* 选项的值是字符串后的第一个参数。它不介意值之前是否有空格。
