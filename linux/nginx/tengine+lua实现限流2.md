## init_worker
```lua
---
--- 读取配置文件conf.txt并通过strsplit函数分割
--- 配置文件格式：appid uri rate burst
--- 创建resty.limit.req对象并存进table
---
local DICT_NAME = "limit_req_store"
local strsplit = require("strsplit")
local limit_req = require("resty.limit.req")
local path = "/usr/local/nginx/lua/"
local limit_reqs = {}
local version = ""

-- 通过key获取缓存的限流对象
function get_limit_req(key)
    return limit_reqs[key]
end

-- 定义一个方法用于设置缓存的限流对象
local function set_limit_req(key, rate, burst)
    local limit = limit_reqs[key]
    if not limit then
        limit = limit_req.new(DICT_NAME, rate, burst)
        limit_reqs[key] = limit
    else
        limit:set_rate(rate)
        limit:set_burst(burst)
    end
end

-- 定义一个方法用于加载配置文件，并初始化限流对象
local function load_conf()
    local file = io.open(path .. "conf.txt", "r")
    -- 如果文件不存在，直接返回
    if not file then
        return false
    end

    -- keys用于提取缓存中的key，以便后面删除缓存中不存在的key
    local keys = {}
    for line in file:lines() do
        local splitTable = strsplit.split(line, " ");
        -- 第一个参数为appid，第二个参数为uri，第三个参数为rate，第四个参数为burst
        -- 第二个参数可能为all，当为all时，表示默认限流策略
        -- 其中第1个+第2个参数为key, 第3个为rate, 第4个为burst
        local key = splitTable[1] ..":".. splitTable[2];
        local rate = tonumber(splitTable[3]);
        local burst = tonumber(splitTable[4]);
        local note = string.format("%s:%s-%s-%s", ngx.worker.pid(), key, rate, burst);
        ngx.log(ngx.INFO, "limit = ", note);
        set_limit_req(key, rate, burst);
        keys[key] = true;
    end
    file:close();

    -- 把keys中不存在的key从缓存中删除
    for key, _ in pairs(limit_reqs) do
        if not keys[key] then
            limit_reqs[key] = nil;
        end
    end
    return true
end


-- 初始化判断版本号和加载配置文件
-- 这里的path表示配置文件的路径
local function init()
    -- 从version.txt里读取版本号，然后跟sign比较，如果不一样，就重新加载配置文件
    -- version.txt只有一行，整个一行为版本号
    local file = io.open(path .. "version.txt", "r")
    if not file then
        -- 文件不存在，直接返回，也不需要记录日志，只表示不限流
        return
    end

    -- 如果版本号一样则直接返回
    local line = file:read("*line")
    file:close();
    if line == version then
        return
    end

    -- 最后加载配置
    local res = load_conf(path);
    -- 更新版本号
    if line and res then
        version = line;
    end
end


-- 定义定时器，在 worker 进程启动时初始化限流对象
-- 如果是lua-module新版本则可以使用ngx.timer.every
local function init_handler()
    if premature then
        return
    end
    init()
    local ok, err = ngx.timer.at(60, init_handler)  -- 60s 后再次执行初始化
    if not ok then
        ngx.log(ngx.ERR, "failed to create init_handler timer: ", err)
    end
end


local function init_worker()
    local ok, err = ngx.timer.at(3, init_handler)
    if not ok then
        ngx.log(ngx.ERR, "failed to create init_worker timer: ", err)
    end
end

-- 在 init_worker_by_lua 阶段注册定时器
init_worker()
```


## access
```lua
---
--- 请求进入，限流处理
---

local appid = ngx.var.appid
local uri = ngx.var.uri
local key = appid .. ":" .. uri

-- 获取限流对象
local limit_req = get_limit_req(key)

-- 如果限流对象存在，就进行限流
-- 如果不存在则看是否有默认限流策略
if not limit_req then
    limit_req = get_limit_req(appid .. ":all")
end

if limit_req then
    local delay, err = limit_req:incoming(key, true)
    if not delay then
        if err == "rejected" then
            ngx.exit(503)
        end
        ngx.log(ngx.ERR, "limit_req: failed to limit req: ", err)
    end
end
```
