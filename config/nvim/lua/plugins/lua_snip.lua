return {
  -- Snippets
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",

  config = function()
    local from_vscode_ok, from_vscode =
      pcall(require, "luasnip.loaders.from_vscode")

    if not from_vscode_ok then
      vim.notify("Failed to load luasnip.loaders.from_vscode")
      return
    end

    from_vscode.lazy_load()
  end,
}
