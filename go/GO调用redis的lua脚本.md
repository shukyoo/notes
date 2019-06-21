## GO调用redis的lua脚本
注意redis 3.0以上才支持lua解析
```go
样例：
script := redis.NewScript(`
redis.call("EXPIRE", KEYS[1], ARGV[3])
redis.call("HSET", KEYS[1], ARGV[1], ARGV[2])
return 1
`)

rc := RedisClient.Get()
defer rc.Close()
resp, err := redis.Int(script.Do(rc, app_id, status, int64(-1)))
```
