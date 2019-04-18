## 解决sh文件在windows下编辑过后出现的bad interpreter问题

在执行sh的时候出现以下错误
```
/bin/bash^M: bad interpreter
```

检查是不是在windows下编辑过，变成了dos文件格式
```
# 在vim下使用以下命令：
:set ff?
# 如果是 fileformat=dos表示是dos文件格式
```

文件格式转换
```
# 在vim下执行以下，并保存退出
:set ff=unix
```

### 参考
[CentOS /bin/bash^M: bad interpreter解决方法](https://blog.csdn.net/violet_echo_0908/article/details/52042137)
