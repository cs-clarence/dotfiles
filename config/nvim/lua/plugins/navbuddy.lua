return {
  {
    "SmiteshP/nvim-navbuddy",
    config = function()
      local plugin_ok, plugin = pcall(require, "nvim-navbuddy")

      if not plugin_ok then
        vim.notify("Failed to load nvim-navbuddy")
        return
      end

      plugin.setup()
    end,
  },
}
