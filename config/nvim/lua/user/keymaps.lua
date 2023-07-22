-- Create a copy of keymap function
local set = vim.keymap.set

local default_opts = { noremap = true, silent = true }
-- local expr_opts = { noremap = true, expr = true, silent = true }

-- Set Leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- NeoToggleTree keymaps
set("n", [[<leader>tt]], [[<cmd>Neotree toggle<cr>]], default_opts)

-- Better (?) window navigation
-- I disabled it because i prefer window commands starting with C-W after all
-- keymap("n", [[<C-k>]], [[<C-w>k]], default_opts)
-- keymap("n", [[<C-j>]], [[<C-w>j]], default_opts)
-- keymap("n", [[<C-l>]], [[<C-w>l]], default_opts)
-- keymap("n", [[<C-h>]], [[<C-w>h]], default_opts)

-- Window resize
set("n", [[<A-k>]], [[<cmd>resize -1<cr>]], default_opts)
set("n", [[<A-j>]], [[<cmd>resize +1<cr>]], default_opts)
set("n", [[<A-h>]], [[<cmd>vertical resize -1<cr>]], default_opts)
set("n", [[<A-l>]], [[<cmd>vertical resize +1<cr>]], default_opts)

-- Tagbar
set("n", [[<leader>tb]], [[<cmd>TagbarToggle<cr>]], default_opts)

-- Trouble
set(
  "n",
  [[<leader>dd]],
  [[<cmd>TroubleToggle document_diagnostics<cr>]],
  default_opts
)

set(
  "n",
  [[<leader>dw]],
  [[<cmd>TroubleToggle workspace_diagnostics<cr>]],
  default_opts
)

set("n", [[<leader>dt]], [[<cmd>TroubleToggle todo<cr>]], default_opts)

-- Diagnostics
set("n", [[<leader>d]], vim.diagnostic.open_float, default_opts)
set("n", [[<leader>df]], vim.diagnostic.open_float, default_opts)
if vim.g.vscode then
  -- Quickfix List
  set("n", [=[<leader>ca]=], function()
    vim.fn.VSCodeNotify("editor.action.quickFix")
  end, default_opts)

  -- Diagnostic Traversal
  set("n", [=[[d]=], function()
    vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
  end, default_opts)

  set("n", [=[]d]=], function()
    vim.fn.VSCodeNotify("editor.action.marker.nextInFiles")
  end, default_opts)

  -- Tab Control
  set("n", [[<S-l>]], function()
    vim.fn.VSCodeNotify("workbench.action.nextEditorInGroup")
  end, default_opts)

  set("n", [[<S-h>]], function()
    vim.fn.VSCodeNotify("workbench.action.previousEditorInGroup")
  end, default_opts)
  set("n", "<leader>bd", function()
    vim.fn.VSCodeNotify("workbench.action.closeActiveEditor")
  end, default_opts)

  -- Rename
  set("n", "<leader>rn", function()
    vim.fn.VSCodeNotify("editor.action.rename")
  end, default_opts)

  -- Comment
  set("v", "gc", function()
    vim.fn.VSCodeNotifyRange(
      "editor.action.commentLine",
      vim.fn.line("v"),
      vim.fn.line("."),
      0
    )
    vim.api.nvim_feedkeys(t([[<ESC>]]), "m", false)
  end, default_opts)
  -- Comment
  set("n", "gcc", function()
    vim.fn.VSCodeCall("editor.action.commentLine")
  end, default_opts)
else
  set("n", [=[[d]=], vim.diagnostic.goto_prev, default_opts)
  set("n", [=[]d]=], vim.diagnostic.goto_next, default_opts)
  -- Buffer control
  set("n", [[<S-l>]], [[<cmd>bnext<cr>]], default_opts)
  set("n", [[<S-h>]], [[<cmd>bprevious<cr>]], default_opts)
  set("n", "<leader>bd", [[<cmd>bdelete<cr>]], default_opts)
end

-- Gitsigns
set("n", [[<leader>cb]], [[<cmd>Gitsigns blame_line<cr>]], default_opts)
set("n", [[<leader>cp]], [[<cmd>Gitsigns preview_hunk<cr>]], default_opts)
set("n", [=[[c]=], [[<cmd>Gitsigns prev_hunk<cr>]], default_opts)
set("n", [=[]c]=], [[<cmd>Gitsigns next_hunk<cr>]], default_opts)

-- Neotest
local neotest_ok, neotest = pcall(require, "neotest")
if neotest_ok then
  -- Test current function
  set("n", [[<leader>rr]], function()
    neotest.run.run()
  end, default_opts)
  -- Run all test in the current file
  set("n", [[<leader>rf]], function()
    neotest.run.run(vim.fn.expand("%"))
  end, default_opts)
  -- Run all tests in the current directory of the current file
  set("n", [[<leader>rf]], function()
    neotest.run.run(vim.fn.expand("%"))
  end, default_opts)
  -- Test the whole CWD
  set("n", [[<leader>rc]], function()
    neotest.run.run(vim.fn.getcwd())
  end, default_opts)
end
