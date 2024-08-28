local M = {}

local path = require("util.path")

function M.load_from_path(folder_path)
    if not folder_path then
        error("folder_path_lua is not specified")
    end

    local lua_path = vim.fn.stdpath("config") .. "/lua/"
    local lua_rel_path = folder_path
    local formatters_path = lua_path .. lua_rel_path

    local is_dir = vim.fn.isdirectory(formatters_path)
    if is_dir == 0 then
        error("Invalid directory " .. formatters_path)
    end

    local files = vim.fn.glob(formatters_path .. "/*.lua", false, true)
    local loaded = {}
    for _, p in ipairs(files) do
        local mod_file = p:gsub(lua_path, "")
        local module = path.to_module_path(mod_file)
        local is_ok, content = pcall(require, module)

        if not is_ok then
            error("Failed to require " .. module)
        end

        table.insert(loaded, {
            path = p,
            module = module,
            content = content,
        })
    end

    return loaded
end

return M
