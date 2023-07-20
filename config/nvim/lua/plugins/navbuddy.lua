return {
  {
    "SmiteshP/nvim-navbuddy",
    cond = function()
      return not vim.g.vscode
    end,
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
