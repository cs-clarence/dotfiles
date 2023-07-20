return {
  {
    "utilyre/barbecue.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      local ok, barbecue = pcall(require, "barbecue")

      if not ok then
        vim.notify("barbecue.nvim not installed", vim.log.levels.ERROR)
        return
      end

      barbecue.setup({})
    end,
  },
}
