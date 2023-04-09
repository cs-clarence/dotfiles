return {
  {
    "chentoast/marks.nvim",
    config = function()
      local plugin_ok, plugin = pcall(require, "marks")

      if not plugin_ok then
        vim.notify("Unable to load marks.nvim", vim.log.levels.ERROR)
        return
      end

      plugin.setup()
    end,
  },
}
