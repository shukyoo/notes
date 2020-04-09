## 修改用户密码
```
Alter user 'test1'@'localhost' identified by '新密码';
```

## 创建用户
```
create user 'test1'@'localhost' identified by '密码';

// 其中localhost指本地才可连接
// 可以将其换成%指任意ip都能连接
// 也可以指定ip连接
```

## 授权
```
grant all privileges on *.* to 'test1'@'localhost' with grant option;

// with gran option表示该用户可给其它用户赋予权限，但不可能超过该用户已有的权限

grant select,insert,update,delete on *.* to 'test1'@'localhost';

// 第一个*表示通配数据库，可指定新建用户只可操作的数据库
// 第二个*表示通配表，可指定新建用户只可操作的数据库下的某个表

flush privileges;
```

## 查看用户授权信息
```
show grants for 'test1'@'localhost';
```

## 查看所有用户
```
SELECT host, user FROM mysql.user;
```

## 撤销权限
```
revoke all privileges on *.* from 'test1'@'localhost';
```

## 删除用户
```
drop user 'test1'@'localhost';
```
