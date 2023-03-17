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
