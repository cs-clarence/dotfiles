return {
    {
        cond = function()
            return not vim.g.vscode and false
        end,
        "Exafunction/codeium.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },

        config = function()
            local codeium_ok, codeium = pcall(require, "codeium")

            if not codeium_ok then
                vim.notify("Codeium is not successfully required")
            end

            codeium.setup({})
        end,
    },
}
