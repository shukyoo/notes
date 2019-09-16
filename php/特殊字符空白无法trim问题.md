## 摘要
问题的根源，在于UTF-8这种编码里面，存在一个特殊的字符，其编码是“0xC2 0xA0”(194 160)，转换成字符的时候，表现为一个空格，跟一般的半角空格（ASCII 0x20）一样，唯一的不同是它的宽度不会被压缩，因此比较多的被用于网页排版（如首行缩进之类）。而其他的编码方式如GB2312、Unicode之类并没有这样的字符。

## 解决方式
```php
$str = str_replace(chr(194) . chr(160), '', $str);
```

## 参考
[php preg_replace空格无法替换问题](https://www.cnblogs.com/zqifa/p/php-10.html)
[This simple function will remove any non-ASCII character](https://gist.github.com/codler/1500962)

