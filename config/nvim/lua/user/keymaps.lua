-- Create a copy of keymap function
local keymap = vim.keymap.set

local default_opts = { noremap = true, silent = true }
-- local expr_opts = { noremap = true, expr = true, silent = true }

-- Set Leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- NeoToggleTree keymaps
keymap("n", [[<leader>tt]], [[<cmd>Neotree toggle<cr>]], default_opts)

-- Better (?) window navigation
-- I disabled it because i prefer window commands starting with C-W after all
-- keymap("n", [[<C-k>]], [[<C-w>k]], default_opts)
-- keymap("n", [[<C-j>]], [[<C-w>j]], default_opts)
-- keymap("n", [[<C-l>]], [[<C-w>l]], default_opts)
-- keymap("n", [[<C-h>]], [[<C-w>h]], default_opts)

-- Window resize
keymap("n", [[<A-k>]], [[<cmd>resize -1<cr>]], default_opts)
keymap("n", [[<A-j>]], [[<cmd>resize +1<cr>]], default_opts)
keymap("n", [[<A-h>]], [[<cmd>vertical resize -1<cr>]], default_opts)
keymap("n", [[<A-l>]], [[<cmd>vertical resize +1<cr>]], default_opts)

-- Tagbar
keymap("n", [[<leader>tb]], [[<cmd>TagbarToggle<cr>]], default_opts)

-- Trouble
keymap(
    "n",
    [[<leader>dd]],
    [[<cmd>TroubleToggle document_diagnostics<cr>]],
    default_opts
)

keymap(
    "n",
    [[<leader>dw]],
    [[<cmd>TroubleToggle workspace_diagnostics<cr>]],
    default_opts
)

keymap("n", [[<leader>dt]], [[<cmd>TroubleToggle todo<cr>]], default_opts)

-- Diagnostics
keymap("n", [[<leader>d]], vim.diagnostic.open_float, default_opts)
keymap("n", [[<leader>df]], vim.diagnostic.open_float, default_opts)
if vim.g.vscode then
    -- Quickfix List
    keymap("n", [=[<leader>ca]=], function()
        vim.fn.VSCodeNotify("editor.action.quickFix")
    end, default_opts)

    -- Diagnostic Traversal
    keymap("n", [=[[d]=], function()
        vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
    end, default_opts)

    keymap("n", [=[]d]=], function()
        vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
    end, default_opts)

    -- Tab Control
    keymap("n", [[<C-l>]], function()
        vim.fn.VSCodeNotify("workbench.action.nextEditorInGroup")
    end, default_opts)

    keymap("n", [[<C-h>]], function()
        vim.fn.VSCodeNotify("workbench.action.previousEditorInGroup")
    end, default_opts)
    keymap("n", "<leader>bd", function()
        vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
    end, default_opts)

    -- Rename
    keymap("n", "<leader>rn", function()
        vim.fn.VSCodeNotify("editor.action.rename")
    end, default_opts)

    -- Comment
    keymap("v", "gc", function()
        vim.fn.VSCodeNotifyRange(
            "editor.action.commentLine",
            vim.fn.line("v"),
            vim.fn.line("."),
            0
        )
        vim.api.nvim_feedkeys(t([[<ESC>]]), "m", false)
    end, default_opts)
    -- Comment
    keymap("n", "gcc", function()
        vim.fn.VSCodeCall("editor.action.commentLine")
    end, default_opts)
else
    keymap("n", [=[[d]=], vim.diagnostic.goto_prev, default_opts)
    keymap("n", [=[]d]=], vim.diagnostic.goto_next, default_opts)
    -- Buffer control
    keymap("n", [[<C-l>]], [[<cmd>bnext<cr>]], default_opts)
    keymap("n", [[<C-h>]], [[<cmd>bprevious<cr>]], default_opts)
    keymap("n", "<leader>bd", [[<cmd>bdelete<cr>]], default_opts)
end

-- Gitsigns
keymap("n", [[<leader>cb]], [[<cmd>Gitsigns blame_line<cr>]], default_opts)
keymap("n", [[<leader>cp]], [[<cmd>Gitsigns preview_hunk<cr>]], default_opts)
keymap("n", [=[[c]=], [[<cmd>Gitsigns prev_hunk<cr>]], default_opts)
keymap("n", [=[]c]=], [[<cmd>Gitsigns next_hunk<cr>]], default_opts)

-- Neotest
local neotest_ok, neotest = pcall(require, "neotest")
if neotest_ok then
    -- Test current function
    keymap("n", [[<leader>rr]], function()
        neotest.run.run()
    end, default_opts)
    -- Run all test in the current file
    keymap("n", [[<leader>rf]], function()
        neotest.run.run(vim.fn.expand("%"))
    end, default_opts)
    -- Run all tests in the current directory of the current file
    keymap("n", [[<leader>rf]], function()
        neotest.run.run(vim.fn.expand("%"))
    end, default_opts)
    -- Test the whole CWD
    keymap("n", [[<leader>rc]], function()
        neotest.run.run(vim.fn.getcwd())
    end, default_opts)
end
