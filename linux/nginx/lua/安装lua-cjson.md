# 下载
wget http://www.kyne.com.au/~mark/software/download/lua-cjson-2.1.0.tar.gz

# 修改Makefile
如果LuaJIT安装在/usr/local/luajit目录下，修改Makefile：
```
PREFIX = /usr/local
改为
PREFIX = /usr/local/luajit

LUA_INCLUDE_DIR = $(PREFIX)/include
改为
LUA_INCLUDE_DIR = $(PREFIX)/include/luajit-2.0

# 编译
```
make
make install
```

# 结果
在/usr/local/luajit/lib/lua/5.1目录下生成cjson.so

# 使用
Lua中require搜索路径：
```
package.path = '/usr/local/luajit/mylua/?.lua;'
package.cpath = '/usr/local/luajit/lib/lua/5.1/?.so;'
```

Nginx.conf的Lua中配置require搜索路径：
```
lua_package_path '/usr/local/luajit/mylua/?.lua;'
package.cpath = '/usr/local/luajit/lib/lua/5.1/
lua_package_cpath '/usr/local/luajit/lib/lua/5.1/?.so;'
```

# 示例
```
package.cpath = '/usr/local/luajit/lib/lua/5.1/?.so;'  
  
--json  
local cjson = require "cjson"  
  
local json_data = '{"name":"tom", "age":"10"}'  
  
local unjson = cjson.decode(json_data)  
print(unjson["name"])  
  
local json_data2 = cjson.encode(unjson)  
print(json_data2)  
```
