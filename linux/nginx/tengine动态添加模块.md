# 添加lua_module
1. 先安装luajit-devel
```
sudo yum install -y luajit-devel
```
2. 添加环境变量
```
export LUAJIT_LIB=/usr/lib64
export LUAJIT_INC=/usr/include/luajit-2.0
```
3. 使用dso_tool编译模块
```
./sbin/dso_tool --add-module=/path/tengine/modules/ngx_http_lua_module
```
4. 配置文件加载模块
```
dso {
    load ngx_http_lua_module.so;
}
```
5. 测试
```
# 先添加一个lua脚本
vim lua/hello.lua
ngx.say("Hello World")

# 再配置
    server {
        listen       80;
        server_name  localhost;

        location /lua {
            access_by_lua_file '/usr/local/nginx/lua/hello.lua';
        }
    }
    
# 用curl请求
curl 'http://localhost/lua'
Hello World
```
