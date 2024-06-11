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
            -- reference: https://github.com/stevearc/oil.nvim?tab=readme-ov-file#options
            oil.setup({
                default_file_explorer = false,

                keymaps = {
                    ["g?"] = "actions.show_help",
                    ["<CR>"] = "actions.select",
                    ["<C-s>"] = {
                        "actions.select_split",
                        opts = { vertical = true },
                    },
                    ["<C-h>"] = {
                        "actions.select_split",
                        opts = { horizontal = true },
                    },
                    ["<C-t>"] = {
                        "actions.select_split",
                        opts = { tab = true },
                    },
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-l>"] = "actions.refresh",
                    ["-"] = "actions.parent",
                    ["_"] = "actions.open_cwd",
                    ["`"] = "actions.cd",
                    ["~"] = { "actions.cd", opts = { scope = "tab" } },
                    ["gs"] = "actions.change_sort",
                    ["gx"] = "actions.open_external",
                    ["g."] = "actions.toggle_hidden",
                    ["g\\"] = "actions.toggle_trash",
                },
                -- Set to false to disable all of the above keymaps
                use_default_keymaps = true,
            })
        end,
    },
}
