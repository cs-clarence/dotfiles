return {
  {
    "SmiteshP/nvim-navic",
    cond = function()
      return not vim.g.vscode
    end,
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
