return {
  {
    "folke/neoconf.nvim",
    lazy = false,
    priority = 2000,
    config = function()
      local ok, plugin = pcall(require, "neoconf")

      if not ok then
        vim.notify("Failed to load neoconf")
        return
      end

      plugin.setup({})
    end,
  },
}
