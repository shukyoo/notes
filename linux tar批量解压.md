对一堆*.tar.gz文件解压缩时，发现tar xvfz *.tar.gz不管用，一查，原来是tar xvfz *.tar.gz会被shell给拆成tar xvfz a.tar.gz b.tar.gz c.tar.gz，而在a.tar.gz中不存在b.tar.gz,当然会报错。

## 解决方法如下：

### 方法1：
```
ls | grep 'tar.gz' | xargs -n1 tar -xf
```

### 方法2：
```
for i in $(ls *.tar);do tar xvf $i;done
```


方法2是文件遍历不细说了；

方法1是管道传参，这里为什么xargs要加上-n1呢？

n1是指每次只传递一个参数给args命令，有高人写过如下脚本对比，非常能说明问题：
```
echo "1 2 3 4"|xargs -n1
1
2
3
4
echo "1 2 3 4"|xargs -n2
1 2
3 4
```
这样，若加n1参数，则*.tar.gz会拆成每个tar.gz文件后，一个一个传给tar tvfz命令，这样就解决了问题。

