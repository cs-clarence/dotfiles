return {
    {
        "stevearc/oil.nvim",
        cond = function()
            return not vim.g.vscode
        end,
        config = function()
            local oil_ok, oil = pcall(require, "oil")

            if not oil_ok then
                vim.notify("Failed to load oil")
                return
            end
            oil.setup({})
        end,
    },
}
