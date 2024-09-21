return {
    {
        "VidocqH/lsp-lens.nvim",
        cond = function()
            return not vim.g.vscode
        end,
        init = function() end,
        config = function()
            local plugin_ok, plugin = pcall(require, "lsp-lens")

            if not plugin_ok then
                vim.notify("Lsp-lens cannot be loaded")
            end

            local SymbolKind = vim.lsp.protocol.SymbolKind

            plugin.setup({
                enable = true,
                include_declaration = false, -- Reference include declaration
                sections = { -- Enable / Disable specific request, formatter example looks 'Format Requests'
                    definition = false,
                    references = true,
                    implements = true,
                    git_authors = true,
                },
                ignore_filetype = {
                    "prisma",
                },
                -- Target Symbol Kinds to show lens information
                target_symbol_kinds = {
                    SymbolKind.Function,
                    SymbolKind.Method,
                    SymbolKind.Interface,
                },
                -- Symbol Kinds that may have target symbol kinds as children
                wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
            })
        end,
    },
}
