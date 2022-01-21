## Communications link failure
No appropriate protocol (protocol is disabled or cipher suites are inappropriate).    
    
#### 解决方法：
在URL上增加useSSL=false    
如：jdbc:mysql://127.0.0.1:3306/mydb?useSSL=false

