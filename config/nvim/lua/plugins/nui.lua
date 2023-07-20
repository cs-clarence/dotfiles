return {
  {
    "MunifTanjim/nui.nvim",
    cond = function()
      return not vim.g.vscode
    end,
  },
}
