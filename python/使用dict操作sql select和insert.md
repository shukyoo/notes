## PyMysql
```python
import pymysql
connection = pymysql.connect(db="test")
cursor = connection.cursor(pymysql.cursors.DictCursor)
cursor.execute("SELECT ...")
```

## MySQLdb select
```python
cursor = conn.cursor(MySQLdb.cursors.DictCursor)  ##结果集成为dictionary
cursor.execute(select_sql )  # query

for row in cursor:
    print type(row),row
    name = row["name"]  # 直接使用key获取
    id = row["id"]      # 直接使用key获取
```

## MySQLdb insert
```python
myDict = {'name':'abc','age':16L}
insert_table = 'mytable'
placeholders = ', '.join(['%s']* len(mydict))  ##按照dict长度返回如：%s, %s 的占位符
columns = ', '.join(mydict.keys())    ##按照dict返回列名，如：age, name
insert_sql =  "INSERT INTO %s ( %s ) VALUES ( %s )" % (insert_table, columns, placeholders) #INSERT INTO mytable ( age, name ) VALUES ( %s, %s )

cursor.execute(insert_sql, mobileDict.values())  ##执行SQL,绑定dict对应的参数
```
