return {
  {
    "xiyaowong/transparent.nvim",
    config = function()
      local ok, transparent = pcall(require, "transparent")

      if not ok then
        vim.notify("transparent.nvim not found", vim.log.levels.ERROR)
      end

      transparent.setup({})
    end,
  },
}
