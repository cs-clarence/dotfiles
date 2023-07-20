return {
  -- Some dependencies for other packages
  {
    "nvim-lua/plenary.nvim",

    cond = function()
      return not vim.g.vscode
    end,
  },
  {
    "nvim-lua/popup.nvim",
    cond = function()
      return not vim.g.vscode
    end,
  },
}
