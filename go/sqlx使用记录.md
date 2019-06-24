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
db.Select(&person, "select user_id, username, sex, email from person")

// 取一行
jason = Person{}
err = db.Get(&jason, "SELECT * FROM person WHERE first_name=$1", "Jason")

// Loop through rows using only one struct
place := Place{}
rows, err := db.Queryx("SELECT * FROM place")
for rows.Next() {
    err := rows.StructScan(&place)
    if err != nil {
        log.Fatalln(err)
    } 
    fmt.Printf("%#v\n", place)
}

// map
rows, err = db.NamedQuery(`SELECT * FROM person WHERE first_name=:fn`, map[string]interface{}{"fn": "Bin"})

// struct
rows, err = db.NamedQuery(`SELECT * FROM person WHERE first_name=:first_name`, jason)
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

## 事务
```go
tx := db.MustBegin()
tx.MustExec("INSERT INTO person (first_name, last_name, email) VALUES ($1, $2, $3)", "Jason", "Moiron", "jmoiron@jmoiron.net")
tx.NamedExec("INSERT INTO person (first_name, last_name, email) VALUES (:first_name, :last_name, :email)", &Person{"Jane", "Citizen", "jane.citzen@example.com"})
tx.Commit()
```

