return {
  {
    "antoinemadec/FixCursorHold.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      vim.g.cursorhold_updatetime = 100
    end,
  },
}
