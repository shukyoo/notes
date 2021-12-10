## ioutil.ReadAll
如果是小数据量的拷贝，使用ioutil.ReadAll无伤大雅；数据量较大时，ReadAll就是性能炸弹了，最好使用io.Copy

## io.Copy
Copy提供更完整的语义，所以针对使用ReadAll()的场景，建议将数据处理流程也考虑进来，将其抽象为一个Writer对象，然后使用Copy完成数据的读取和处理流程。

## json
如果读取出来的数据，是要用json再解码，可以连io.Copy都不用
```go
type Result struct {
    Msg string `json:"msg"`
    Rescode string `json:"rescode"`
}
func parseBody(body io.Reader) {
	var v Result
	err := json.NewDecoder(body).Decode(&v)
	if err != nil {
		return nil, fmt.Errorf("DecodeJsonFailed:%s", err.Error())
	}
}
```
