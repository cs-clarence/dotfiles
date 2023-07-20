return {
  {
    -- Tagbar
    "preservim/tagbar",
    cond = function()
      return not vim.g.vscode
    end,
  },
}
