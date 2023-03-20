-- 使用说明
--[[
local ta = strsplit.split("122sd_lsdjfdh_sasasa_rrt", "_");
print("类型:" .. type(ta));
for k, v in ipairs(ta) do
  print("键:" .. k, "值:" .. v);
end
--]]

local _M = {}
function _M.split(str, delim)
  if type(delim) ~= "string" or string.len(delim) <= 0 then
      return
  end
  local start = 1
  local tab = {}
  while true do
      local pos = string.find(str, delim, start, true)
      if not pos then
          break
      end
      table.insert(tab, string.sub(str, start, pos - 1))
      start = pos + string.len(delim)
  end
  table.insert(tab, string.sub(str, start))
  return tab
end
return _M
