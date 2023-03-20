-- 使用说明
--[[
-- 设置参数
ngxshare.shared_dic_set(ngx.shared.my_limit_store, 'limit_store', 1, 0);
-- 获取参数
ngx.say(ngxshare.shared_dic_get(ngx.shared.my_limit_store, 'limit_store'));
--]]

local _M = {}
function _M.shared_dic_get(dic, key)
  local value = dic:get(key);
  return value;
end

function _M.shared_dic_set(dic, key, value, exptime)
  if not exptime then
      exptime = 0;
  end
  local succ, err = dic:set(key, value, exptime);
  return succ;
end

return _M
