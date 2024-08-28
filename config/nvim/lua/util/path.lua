local M = {}

function M.to_module_path(file_path)
    -- Use gsub to replace one or more consecutive slashes with a single dot
    local result = file_path:gsub("/+", ".")
    return result:gsub("%.lua", "", 1)
end

return M
