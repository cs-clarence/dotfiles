return {
  {
    "nvim-tree/nvim-web-devicons",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local nvim_web_devicons_ok, nvim_web_devicons =
        pcall(require, "nvim-web-devicons")
      if not nvim_web_devicons_ok then
        vim.notify("Failed to require nvim-web-devicons")
        return
      end

      nvim_web_devicons.setup()
    end,
  },
}
