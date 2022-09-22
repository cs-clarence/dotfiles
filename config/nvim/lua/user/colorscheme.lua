local M = {}

-- Which colorscheme to set
local default = "vscode"

-- A list for colorschemes you want to install
local default_colorschemes = {
  "morhetz/gruvbox",
  "folke/tokyonight.nvim",
  "tomasr/molokai",
  "sonph/onehalf",
  "dracula/vim",
  "gosukiwi/vim-atom-dark",
  "joshdick/onedark.vim",
  "arcticicestudio/nord-vim",
  "rakr/vim-one",
  "Mofiqul/vscode.nvim",
}

M.active = default
M.list = default_colorschemes

function M.set_active(colorscheme)
  M.active = colorscheme
end

function M.install(colorschemes)
  for _, v in pairs(colorschemes) do
    table.insert(M.list, v)
  end
end

return M
