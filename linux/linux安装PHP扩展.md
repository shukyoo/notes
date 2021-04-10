## 方法1：
某些已编译好的.so文件直接复制过去就可以使用的


## 方法2：
编译
```
$ cd xxxxxx （扩展目录）
$ /path/to/php/bin/phpize  （对应phpize实际路径）
$ ./configure --with-php-config=/path/to/php/bin/php-config  (对应php-config实际路径) （这一步可能报错，需要安装依赖）
$ make && make install
```
修改配置
* php.ini增加extension=xxxx.so

注意事项
* 在执行第三步./configure的时候，可能会报错，那么需要安装相应的系统扩展，可以把错误信息在网上查询
