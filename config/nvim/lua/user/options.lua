local o = vim.opt

-- Options
o.mouse = "a" -- allow mouse interaction for GUI
o.completeopt = { "menu", "menuone", "noselect" }
o.fileencoding = "utf-8"

-- Timing
o.updatetime = 300 -- 300ms, faster autocomplete time
o.timeoutlen = 1000 -- how long should vim wait for a command to complete

-- Tabs/Indents
o.expandtab = true -- convert tabs to spaces
o.tabstop = 2 -- insert 2 spaces for a tab
o.shiftwidth = 2 -- insert 2 spaces for indents
o.smartindent = true

-- Scrolling
o.scrolloff = 10 -- how much offset when scrolling vertically
o.sidescrolloff = 10 -- how much offset when scrolling horizontally

-- Clipboard
o.clipboard:append("unnamedplus") -- allow neovim to access system clipboard

-- UI
o.signcolumn = "yes" -- always show signcolumn near the line number column
o.numberwidth = 4 -- reserver for lines for the line number column
o.showmode = false -- a status line plugin will do this for us so disable it for vim
o.cmdheight = 1 -- add more space for command line to display more text
o.relativenumber = false
o.number = true
o.showtabline = 2 -- always show tabs, 2 means always
o.cursorline = true
o.termguicolors = true
o.pumheight = 10 -- pop up menu height
o.splitbelow = true -- when splitting a buffer vertically, open the new buffer below
o.splitright = true -- when splitting a buffer horizontally, open the new buffer to the right
o.list = true
o.listchars:append("eol:↴")
