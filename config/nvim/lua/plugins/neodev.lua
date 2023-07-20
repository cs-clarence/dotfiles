return {
  {
    "folke/neodev.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local neodev_ok, neodev = pcall(require, "neodev")

      if not neodev_ok then
        vim.notify("Failed to load neodev")
        return
      end

      neodev.setup({})
    end,
  },
}
