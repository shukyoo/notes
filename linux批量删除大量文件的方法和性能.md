首先建立50万个文件
```shell
test  for i in $(seq 1 500000)
for> do
for> echo test >>$i.txt
for> done
```

## 方法1：使用rm
```shell
rm -f *
```
3.63s user 0.29s system 98% cpu 3.985 total
由于文件数量过多，rm不起作用。


## 方法2：使用find
```shell
find ./ -type f -exec rm {} \;
```
49.86s user 1032.13s system 41% cpu 43:19.17 total
大概43分钟。


## 方法3：find with delete
```shell
find ./ -type f -delete
```
0.43s user 11.21s system 2% cpu 9:13.38 total
用时9分钟。


## 方法4：rsync
首先建立空文件夹blanktest
```shell
rsync -a --delete blanktest/ test/
```
0.59s user 7.86s system 51% cpu 16.418 total
16s，很好很强大。


## 方法5：Python
```python
import os
import time
stime=time.time()
for pathname,dirnames,filenames in os.walk('/home/username/test'):
     for filename in filenames:
         file=os.path.join(pathname,filename)
         os.remove(file)
 ftime=time.time()
 print ftime-stime

 ~  python test.py
```
494.272291183
大概用时8分钟。


## 方法6：Perl
```shell
perl -e 'for(<*>){((stat)[9]<(unlink))}'
```
1.28s user 7.23s system 50% cpu 16.784 total
