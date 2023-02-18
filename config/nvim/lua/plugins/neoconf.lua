return {
  {
    "folke/neoconf.nvim",
    config = function()
      local ok, plugin = pcall(require, "neoconf")

      if not ok then
        vim.notify("Failed to require neoconf")
        return
      end
      plugin.setup()
    end,
  },
}
