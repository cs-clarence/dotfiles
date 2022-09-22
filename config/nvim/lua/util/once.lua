local M = {}

---comment
---@param fn function(...)
---@param message string?
---@return function(...)
function M.do_once(fn, message)
  local ran = false
  return function(...)
    if not ran then
      fn(...)
    elseif message ~= nil then
      print(message)
    end
  end
end

return M
