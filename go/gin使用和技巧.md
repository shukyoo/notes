## 获取参数
```go
// 获取get
userName := c.Query("user_name")

// 获取post
userName := c.PostForm("user_name")

// 获取path
router.GET("/v1/user/:userName/orders", user.GetOrders)
userName := c.Param("userName")
```

## 获取Header（header case-insensitive）
``` go
// 获取header的string值，如aaaaa
token := c.Request.Header.Get("token")

// 如果map形式获取，则获取到的是一个数组，如[aaaaa]
token := c.Request.Header["token"]
```

## gin监听多个端口
```go
func main() {
    go serveEx("8080")
    go serveIn("8090")
    // 阻塞
    select{}
}

// 端口1
func serveEx(port string) {
    router := gin.Default()
    router.GET("/version", getVersion)
    router.Run(":"+port)
}

// 端口2
func serveIn(port string) {
    router := gin.Default()
    router.GET("/version", getVersion)
    router.Run(":"+port)
}
```

## 使用graceful restart组件
``` go
func main() {
    router := gin.Default()
    router.GET("/version", getVersion)
    zerodown.ListenAndServe(":8080", router)
}
```

