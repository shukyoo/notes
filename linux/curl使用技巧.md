## curl 如何测量它花了多少时间？
```
# 创建文件 curl-format.txt
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
    time_appconnect:  %{time_appconnect}\n
   time_pretransfer:  %{time_pretransfer}\n
      time_redirect:  %{time_redirect}\n
 time_starttransfer:  %{time_starttransfer}\n
                    ----------\n
         time_total:  %{time_total}\n
```
再使用命令如下：
```
curl -w "@curl-format.txt" -o /dev/null -s "http://www.baidu.com/"
```


## 参考
* [curl 的用法指南](https://www.ruanyifeng.com/blog/2019/09/curl-reference.html)
