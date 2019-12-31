## 问题
exec.Command执行命令的时候，如果存在问题会返回err，打印信息显示 如 “exit status 255”，无详细错误信息；

## 解决
```go
cmd := exec.Command("grep", host, "test")
var out bytes.Buffer
var stderr bytes.Buffer
cmd.Stdout = &out
cmd.Stderr = &stderr
err := cmd.Run()
if err != nil {
    log.Error(err.Error(), stderr.String())
} else {
   	log.Info(out.String())
}
```
输出
```
exit status 2 grep: test: No such file or directory
```

## 参考
[How to debug “exit status 1” error when running exec.Command in Golang](https://stackoverflow.com/questions/18159704/how-to-debug-exit-status-1-error-when-running-exec-command-in-golang)
