return {
  "morhetz/gruvbox",
  "tomasr/molokai",
  "sonph/onehalf",
  "dracula/vim",
  "gosukiwi/vim-atom-dark",
  "joshdick/onedark.vim",
  "arcticicestudio/nord-vim",
  "rakr/vim-one",
  "Mofiqul/vscode.nvim",
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 2000,
    init = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}
