return {
  {
    "mfussenegger/nvim-dap",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local dap_ok, dap = pcall(require, "dap")

      if not dap_ok then
        vim.notify("Failed to require dap")
        return
      end
    end,
  },
}
