1. 引入lua-resty-limit-traffic-master 库
```
wget https://github.com/openresty/lua-resty-limit-traffic/archive/master.zip
unzip master.zip
# 把里面的lua目录提取出来放置到自己的lib库
mv lib/resty /usr/local/nginx/lua/lib
```

2. 初始化脚本limit_init.lua
```
local limit_table = ngx.shared.my_limit_store;
local strsplit = require("strsplit");
file = io.open("/path/to/limit.txt", "r");
if nil == file then
    ngx.log(ngx.INFO, "文件读取失败，将采用默认值进行赋值");
    local suc, err = limit_table:set("default", "15-15");
else
    for line in file:lines() do
        local splitTable = strsplit.split(line, "-");
        local sysFlag = splitTable[1];
        local limitRate = splitTable[2];
        local bursts = splitTable[3];
        local tableVal = string.format("%s-%s", limitRate, bursts);
        ngx.log(ngx.INFO, "sysFlag = ", sysFlag, "限流阀值：流速-桶容量：", tableVal);
        limit_table:set(sysFlag, tableVal);
    end
    file:close();
end
```

3. 重置策略脚本limit_reset.lua
```
local strsplit = require("strsplit");
local ngxshare = require("resty.ngxshare");
-- get request param
local args, err = ngx.req.get_uri_args();
local limitvalue = args["limitvalue"];
ngx.say("-----------limitvalue-----------", limitvalue);
local limitParam = strsplit.split(limitvalue, "-");
local sysFlag = limitParam[1];
ngx.say(ngxshare.shared_dic_get(ngx.shared.my_limit_store, sysFlag));
local rateBurst = string.format("%s-%s", limitParam[2], limitParam[3]);
ngx.say("-------------rateBurst:", rateBurst);
ngxshare.shared_dic_set(ngx.shared.my_limit_store, sysFlag, rateBurst, 0);
ngx.say("---------------", ngxshare.shared_dic_get(ngx.shared.my_limit_store, sysFlag));
```

4. 限流处理limit.lua
```
-- 获取请求参数
local strsplit = require("strsplit");
ngx.req.read_body();
local args, err = ngx.req.get_uri_args();
local sysFlag = args["sys"];
local limit_table = ngx.shared.my_limit_store;
local limitRate = limit_table:get(sysFlag);
if not limitRate then
    ngx.log(ngx.INFO, "sysFlag can not found so set defalut value");
    limitRate = limit_table:get("default");
end
-- 获取到的值进行拆分并限流
local limitValue = strsplit.split(limitRate, "-");
local rate = tonumber(limitValue[1]);
local burst = tonumber(limitValue[2]);
local limit_req = require "resty.limit.req";
ngx.say("rate====", rate, "---burst=====", burst);
-- 根据配置项创建一个限流的table。
local lim, err = limit_req.new("my_limit_req_store", rate, burst);
if not lim then
    ngx.log(ngx.ERR, "failed to instantiate a resty.limit.req object: ", err);
    return ngx.exit(500);
end
-- 根据渠道标识进行限流
local delay, err = lim:incoming(sysFlag, true);
if not delay then
    if err == "rejected" then
        ngx.say("rejected access service..............");
        ngx.log(ngx.INFO, "rejected access service..............", err);
        return ngx.exit(503);
    end
    ngx.log(ngx.INFO, "failed to limit req: ", err);
    return ngx.exit(500);
end
ngx.log(ngx.INFO, "access received..............");
ngx.say("access received..............");
```

5. 限流配置文件limit.txt
```
test-10-200  # 其中test为请求渠道标识，10 为流速， 200为桶容量
test1-1-1
```

6. nginx配置
```
http {
    lua_package_path "/usr/local/nginx/lua/lib/?.lua;;";
    lua_code_cache on;
    lua_shared_dict my_limit_store 5m;
    lua_shared_dict my_limit_req_store 10m;
    init_by_lua_file "/usr/local/nginx/lua/limit_init.lua";

# server块内配置
    server {
        listen       80;
        server_name  localhost;

        location /lua {
            content_by_lua_file /usr/local/nginx/lua/limit.lua;
        }
```

7. 测试
```
curl 'http://localhost/lua?sys=test'
```
