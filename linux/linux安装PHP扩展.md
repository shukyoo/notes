## 方法1：
某些已编译好的.so文件直接复制过去就可以使用的


## 方法2：
编译
```
$ cd xxxxxx
$ /path/to/php7/phpize
$ ./configure --with-php-config=/path/to/php7/php-config/
$ make && make install
```
修改配置
* php.ini增加extension=xxxx.so

注意事项
* 在执行第三步./configure的时候，可能会报错，那么需要安装相应的系统扩展，可以把错误信息在网上查询
