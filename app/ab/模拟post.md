网上查到的资料表述如下：
```
ab -c 50  -n 50 -p postdata.json  -T application/json  http://xxxxxx
```
默认是plain/text

在windows下实际测试发现加了 -T application/json 反而没效果，把-T这段去掉就可以，不知道原因
```
ab.exe -c10 -n10 -p post.txt 'http://xxxxxxx'
```

post.txt
```
{"id":1,"method":"create","params":{"info":{"ord......
```
