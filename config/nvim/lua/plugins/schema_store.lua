return {
  {
    -- Json SchemaStore
    "b0o/SchemaStore.nvim",
    cond = function()
      return not vim.g.vscode
    end,
  },
}
