return {
  {
    "SmiteshP/nvim-navic",
    config = function()
      local plugin_ok, navic = pcall(require, "nvim-navic")
      if not plugin_ok then
        vim.notify("nvim-navic not found", vim.log.levels.ERROR)
        return
      end

      navic.setup()
    end,
  },
}
