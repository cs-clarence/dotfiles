local M = {}

M.config = { dsn = "", driver = "sql" }

---@param config table
function M.set_config(config)
  M.config.dsn = config.dsn or M.config.dsn
  M.config.driver = config.driver or M.config.driver
end

return M
