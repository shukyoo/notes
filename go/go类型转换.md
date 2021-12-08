## string转int
```
int, err := strconv.Atoi(string)
```

## int转string
```
string := strconv.Itoa(int)
```

## string转int64
```
int64, err := strconv.ParseInt(string, 10, 64)
```

## int64转string
```
string := strconv.FormatInt(int64,10)
```

## interface{}转string
以下是redigo里的代码摘录：
([]unit8 to string?)
```go
func String(reply interface{}, err error) (string, error) {
	if err != nil {
		return "", err
	}
	switch reply := reply.(type) {
	case []byte:
		return string(reply), nil
	case string:
		return reply, nil
	case nil:
		return "", ErrNil
	case Error:
		return "", reply
	}
	return "", fmt.Errorf("redigo: unexpected type for String, got type %T", reply)
}
```

