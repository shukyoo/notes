## 不解压直接grep tar.gz文件
```shell
zcat xxx.tar.gz | grep -a 'xxx'
```

## find + grep
```shell
find /xxx -name "xxx" -exec grep "xxxx" {} \;
```

## grep
```shell
grep -rH --include "xxx*" "aaaa*" path
or
--exclude
```

## grep查找多个关键词
```
grep 'opened\|closed' /var/log/secure
```

## grep查找中划线开头的
```
grep -- '-aaa'
```
