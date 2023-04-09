return {
  {
    "rcarriga/nvim-notify",
    config = function()
      local ok, notify = pcall(require, "notify")
      if not ok then
        vim.notify("Failed to require notify")
        return
      end
      vim.notify = notify
    end,
  },
}
