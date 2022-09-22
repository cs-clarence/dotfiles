-- Create a copy of keymap function
local keymap = vim.keymap.set

local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

-- Set Leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ToggleTerm keymaps
keymap("t", [[<ESC>]], [[<C-\><C-n>]], default_opts)

-- NvimToggleTree keymaps
keymap("n", [[<leader>tt]], [[<cmd>NvimTreeToggle<cr>]], default_opts)

-- Fzf Toggle
keymap("n", [[<leader>ff]], [[<cmd>Fzf files<cr>]], default_opts)
keymap("n", [[<leader>ft]], [[<cmd>Fzf tags<cr>]], default_opts)
keymap("n", [[<leader>fb]], [[<cmd>Fzf buffers<cr>]], default_opts)
keymap("n", [[<leader>fg]], [[<cmd>Fzf grep<cr>]], default_opts)
keymap("n", [[<leader>fr]], [[<cmd>Fzf git_files<cr>]], default_opts)

-- Better (?) window navigation
-- I disabled it because i prefer window comamnds starting with C-W after all
-- keymap("n", [[<C-k>]], [[<C-w>k]], default_opts)
-- keymap("n", [[<C-j>]], [[<C-w>j]], default_opts)
-- keymap("n", [[<C-l>]], [[<C-w>l]], default_opts)
-- keymap("n", [[<C-h>]], [[<C-w>h]], default_opts)

-- Window resize
keymap("n", [[<A-k>]], [[<cmd>resize -1<cr>]], default_opts)
keymap("n", [[<A-j>]], [[<cmd>resize +1<cr>]], default_opts)
keymap("n", [[<A-h>]], [[<cmd>vertical resize -1<cr>]], default_opts)
keymap("n", [[<A-l>]], [[<cmd>vertical resize +1<cr>]], default_opts)

-- Buffer control
keymap("n", [[<S-l>]], [[<cmd>bnext<cr>]], default_opts)
keymap("n", [[<S-h>]], [[<cmd>bprevious<cr>]], default_opts)
keymap("n", "<leader>bd", [[<cmd>bdelete<cr>]], default_opts)

-- Toggle ToggleTerm
keymap("n", [[<leader>tr]], [[<cmd>ToggleTerm<cr>]], default_opts)

-- Tagbar
keymap("n", [[<leader>tb]], [[<cmd>TagbarToggle<cr>]], default_opts)

-- Packer keymaps command
keymap("n", [[<leader>ps]], [[<cmd>PackerSync<cr>]], default_opts)
keymap("n", [[<leader>pu]], [[<cmd>PackerUpdate<cr>]], default_opts)

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
keymap("n", [=[[d]=], vim.diagnostic.goto_prev, default_opts)
keymap("n", [=[]d]=], vim.diagnostic.goto_next, default_opts)

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
