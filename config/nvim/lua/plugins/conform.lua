-- require("conform").setup({
--   -- Map of filetype to formatters
--   formatters_by_ft = {
--     lua = { "stylua" },
--     -- Conform will run multiple formatters sequentially
--     go = { "goimports", "gofmt" },
--     -- Use a sub-list to run only the first available formatter
--     javascript = { { "prettierd", "prettier" } },
--     -- You can use a function here to determine the formatters dynamically
--     python = function(bufnr)
--       if require("conform").get_formatter_info("ruff_format", bufnr).available then
--         return { "ruff_format" }
--       else
--         return { "isort", "black" }
--       end
--     end,
--     -- Use the "*" filetype to run formatters on all filetypes.
--     ["*"] = { "codespell" },
--     -- Use the "_" filetype to run formatters on filetypes that don't
--     -- have other formatters configured.
--     ["_"] = { "trim_whitespace" },
--   },
--   -- If this is set, Conform will run the formatter on save.
--   -- It will pass the table to conform.format().
--   -- This can also be a function that returns the table.
--   format_on_save = {
--     -- I recommend these options. See :help conform.format for details.
--     lsp_fallback = true,
--     timeout_ms = 500,
--   },
--   -- If this is set, Conform will run the formatter asynchronously after save.
--   -- It will pass the table to conform.format().
--   -- This can also be a function that returns the table.
--   format_after_save = {
--     lsp_fallback = true,
--   },
--   -- Set the log level. Use `:ConformInfo` to see the location of the log file.
--   log_level = vim.log.levels.ERROR,
--   -- Conform will notify you when a formatter errors
--   notify_on_error = true,
--   -- Custom formatters and overrides for built-in formatters
--   formatters = {
--     my_formatter = {
--       -- This can be a string or a function that returns a string.
--       -- When defining a new formatter, this is the only field that is required
--       command = "my_cmd",
--       -- A list of strings, or a function that returns a list of strings
--       -- Return a single string instead of a list to run the command in a shell
--       args = { "--stdin-from-filename", "$FILENAME" },
--       -- If the formatter supports range formatting, create the range arguments here
--       range_args = function(self, ctx)
--         return { "--line-start", ctx.range.start[1], "--line-end", ctx.range["end"][1] }
--       end,
--       -- Send file contents to stdin, read new contents from stdout (default true)
--       -- When false, will create a temp file (will appear in "$FILENAME" args). The temp
--       -- file is assumed to be modified in-place by the format command.
--       stdin = true,
--       -- A function that calculates the directory to run the command in
--       cwd = require("conform.util").root_file({ ".editorconfig", "package.json" }),
--       -- When cwd is not found, don't run the formatter (default false)
--       require_cwd = true,
--       -- When stdin=false, use this template to generate the temporary file that gets formatted
--       tmpfile_format = ".conform.$RANDOM.$FILENAME",
--       -- When returns false, the formatter will not be used
--       condition = function(self, ctx)
--         return vim.fs.basename(ctx.filename) ~= "README.md"
--       end,
--       -- Exit codes that indicate success (default { 0 })
--       exit_codes = { 0, 1 },
--       -- Environment variables. This can also be a function that returns a table.
--       env = {
--         VAR = "value",
--       },
--       -- Set to false to disable merging the config with the base definition
--       inherit = true,
--       -- When inherit = true, add these additional arguments to the beginning of the command.
--       -- When inherit = true, add these additional arguments to the command.
--       -- This can also be a function, like args
--       prepend_args = { "--use-tabs" },
--       -- When inherit = true, add these additional arguments to the end of the command.
--       -- This can also be a function, like args
--       append_args = { "--trailing-comma" },
--     },
--     -- These can also be a function that returns the formatter
--     other_formatter = function(bufnr)
--       return {
--         command = "my_cmd",
--       }
--     end,
--   },
-- })
--
local function file_path_to_module_path(path)
    -- Use gsub to replace one or more consecutive slashes with a single dot
    local result = path:gsub("/+", ".")
    return result:gsub("%.lua", "", 1)
end

local function retrieve_user_formatters(folder_path_lua)
    local lua_path = vim.fn.stdpath("config") .. "/lua/"
    local lua_rel_path = folder_path_lua or "user/formatters"
    local formatters_path = lua_path .. lua_rel_path

    local is_dir = vim.fn.isdirectory(formatters_path)
    if is_dir == 0 then
        error("Invalid directory " .. formatters_path)
    end

    local files = vim.fn.glob(formatters_path .. "/*.lua", false, true)
    local user_formatter_configs = {}
    for _, p in ipairs(files) do
        local mod_file = p:gsub(lua_path, "")
        local module = file_path_to_module_path(mod_file)
        local is_ok, config = pcall(require, module)

        if not is_ok then
            error("Failed to require " .. module)
        end

        table.insert(user_formatter_configs, {
            path = p,
            config = config,
        })
    end

    local formatters_by_ft = {}
    local formatters = {}

    for _, value in ipairs(user_formatter_configs) do
        local function throw_error(reason)
            local msg = "Failed to process formatter configuration: "
                + value.path
            if reason then
                msg = msg .. "\nReason: " .. reason
            end
            error(msg)
        end

        local formatter_list = {}

        for key, config_or_name in pairs(value.config.formatters) do
            if type(key) == "string" and type(config_or_name) == "table" then
                formatters[key] = config_or_name
                table.insert(formatter_list, key)
            else
                if
                    type(key) == "number"
                    and type(config_or_name) == "string"
                then
                    table.insert(formatter_list, config_or_name)
                else
                    throw_error("Invalid formatters configuration")
                end
            end

            -- TODO: check if table is empty

            for _, ft in ipairs(value.config.filetypes) do
                formatters_by_ft[ft] = formatter_list
            end
        end
    end
    return { formatters_by_ft = formatters_by_ft, formatters = formatters }
end

return {
    {
        "stevearc/conform.nvim",
        cond = function()
            return not vim.g.vscode
        end,
        config = function()
            local is_ok, plugin = pcall(require, "conform")

            if not is_ok then
                vim.notify("Failed to require conform", vim.log.levels.ERROR)
                return
            end

            local configs_ok, configs = pcall(retrieve_user_formatters)

            if not configs_ok then
                vim.notify(configs, vim.log.levels.ERROR)
                return
            end

            plugin.setup({
                formatters_by_ft = configs.formatters_by_ft,
                -- This can also be a function that returns the table.
                format_on_save = {
                    -- I recommend these options. See :help conform.format for details.
                    lsp_fallback = true,
                    timeout_ms = 500,
                },
                -- Set the log level. Use `:ConformInfo` to see the location of the log file.
                log_level = vim.log.levels.ERROR,
                -- Conform will notify you when a formatter errors
                notify_on_error = true,
                -- If this is set, Conform will run the formatter asynchronously after save.
                -- It will pass the table to conform.format().
                -- This can also be a function that returns the table.
                -- format_after_save = {
                --     lsp_fallback = true,
                -- },
                formatters = configs.formatters,
            })
        end,
    },
}
