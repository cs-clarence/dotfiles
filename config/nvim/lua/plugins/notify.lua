return {
  {
    "rcarriga/nvim-notify",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local ok, notify = pcall(require, "notify")
      if not ok then
        vim.notify("Failed to require notify")
        return
      end
      notify.setup({ render = "compact" })

      -- local vim_notify = vim.notify

      vim.notify = function(msg, level, opts)
        -- Hide "No information available" messages
        if msg == "No information available" then
          return
        end

        notify(msg, level)
      end
    end,
  },
}
