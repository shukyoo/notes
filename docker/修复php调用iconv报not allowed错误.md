## 修复php调用iconv报not allowed错误
```
iconv('UTF-8', 'GBK//IGNORE', '2019-08-06测试');

//iconv(): Wrong charset, conversion from `GBK' to `UTF-8//IGNORE' is not allowed
```

## 修正
如果使用了alpine系统，libiconv的版本会很低，需要更新一下 libiconv的版本
以下是dockerfile指令
```
RUN apk add --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ gnu-libiconv
ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
```

## 参考
https://github.com/aliyun/aliyun-oss-php-sdk/issues/97
https://github.com/docker-library/php/issues/240
