local once = require("util.once")
local database = require("user.database")

local M = {}

---@type function
M.config = once.do_once(function(opts)
  if opts == nil then
    vim.notify(
      "custom.database.config: first parameter should be a table and can't be nil"
    )
    return
  end

  if opts.driver == nil then
    vim.notify(
      "custom.database.config: first parameter should have a field 'driver' which must be a string"
    )
    return
  end

  if opts.dsn == nil then
    vim.notify(
      "custom.database.config: first parameter should have a field 'dsn' which must be a string"
    )
    return
  end
  database.set_config(opts)
end, "custom.database: 'config' can only be called once")

return M
