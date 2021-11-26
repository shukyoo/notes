## go测试技巧
* 显示test里的Print
```
go test -v .
```

* 测试单个文件
```
go test -v hello_test.go

# 如果出现方法未定义，则需要把其它文件包含上
go test -v hello.go hello_test.go
```

* 测试指定方法
```
go test -v --run TestA
go test -v -test.run="TestA"

# 以下是匹配模式
go test -v --run TestA*
```

* 去掉cache
```
go test -v --count=1 .
```

* 测试覆盖率
```
go test -v -coverprofile=a.out -test.run="TestA*" # 把测试结果保存在 a.out

go tool cover -html=./a.out  # 通过浏览器打开, 可以看到覆盖经过的函数
```

