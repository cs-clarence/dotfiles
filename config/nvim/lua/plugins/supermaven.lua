return {
    {
        "supermaven-inc/supermaven-nvim",
        cond = function()
            return not vim.g.vscode
        end,
        init = function() end,
        config = function()
            local plugin_ok, plugin = pcall(require, "supermaven-nvim")

            if not plugin_ok then
                vim.notify("Supermaven cannot be loaded")
            end

            plugin.setup({})
            local api_ok, api = pcall(require, "supermaven-nvim.api")

            if not api_ok then
                vim.notify("Supermaven API cannot be loaded")
            end

            api.use_free_version()
        end,
    },
}
