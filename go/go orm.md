## gorm
* [GORM docs](https://gorm.io/docs/)
* [GORM 中文文档](http://gorm.book.jasperxu.com/)

### gorm json字段处理
```go
type TestValue struct {
  Myid int
  Str string
}

func (t TestValue) Value() (driver.Value, error) {
	b, err := json.Marshal(t)
	return string(b), err
}

func (t *TestValue) Scan(input interface{}) error {
	return json.Unmarshal(input.([]byte), t)
}

type MyModel struct {
  Id int
  TestValue TestValue `sql:"type:json" json:"object,omitempty"`
}
```
参考：
* [If you want to support JSON column for mysql](https://github.com/jinzhu/gorm/issues/1935)
* [是否支持MySQL 5.7以上的 json type column的使用](https://github.com/jinzhu/gorm/issues/1879)

