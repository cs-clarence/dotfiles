return {
  {
    "mfussenegger/nvim-lint",
    cond = function()
      return not vim.g.vscode
    end,
        setup = function() end
  },
}
