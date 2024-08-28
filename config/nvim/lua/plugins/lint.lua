return {
    {
        "mfussenegger/nvim-lint",
        cond = function()
            return not vim.g.vscode
        end,
        config = function()
            local plugin_ok, lint = pcall(require, "lint")

            if not plugin_ok then
                vim.notify(lint, vim.log.levels.ERROR)
            end

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    -- try_lint without arguments runs the linters defined in `linters_by_ft`
                    -- for the current filetype
                    lint.try_lint()

                    -- You can call `try_lint` with a linter name or a list of names to always
                    -- run specific linters, independent of the `linters_by_ft` configuration
                    -- lint.try_lint("cspell")
                end,
            })
        end,
    },
}
