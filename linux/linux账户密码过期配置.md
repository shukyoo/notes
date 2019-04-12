## linux账户密码过期配置

#### 查看当前账户的密码策略
```linux
chage -l test
```

#### 配置文件
```
/etc/login.defs
这个修改后只会对新建用户生效
```

#### 修改某个用户的密码有效期永不过期
```linux
chage -M 99999 test
```
