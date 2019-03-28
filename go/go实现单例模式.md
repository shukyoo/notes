## go实现单例模式

```go
type singleton struct{}
var ins *singleton
var once sync.Once
func GetIns() *singleton {
    once.Do(func(){
        ins = &singleton{}
    })
    return ins
}
```
