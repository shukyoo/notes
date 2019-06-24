## 初始
```go
import (
    _ "github.com/go-sql-driver/mysql"
    "github.com/jmoiron/sqlx"
)

db, err := sqlx.Open("mysql", "root:root@tcp(127.0.0.1:3306)/test")
if err != nil {
    log.Fatalln(err)
}

type Person struct {
    UserId   int    `db:"user_id"`
    Username string `db:"username"`
    Sex      string `db:"sex"`
    Email    string `db:"email"`
}
```

## Insert
```go
r, err := db.Exec("insert into person(username, sex, email)values(?, ?, ?)", "stu001", "man", "stu01@qq.com")
if err != nil {
    fmt.Println(err)
}
id, err := r.LastInsertId()
if err != nil {
    fmt.Println(err)
}
```

## Query
```go
var person []Person
db.Select(&person, "select user_id, username, sex, email from person where user_id=?", 1)
```

## Update
```go
_, err := Db.Exec("update person set username=? where user_id=?", "stu0003", 1)
if err != nil {
    fmt.Println(err)
}
```

## Delete
```go
_, err := Db.Exec("delete from person where user_id=?", 1)
if err != nil {
    fmt.Println("exec failed ", err)
}
```
