return {
  {
    "Saecki/crates.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local ok, crates = pcall(require, "crates")

      if not ok then
        vim.notify("Failed to require crates")
        return
      end

      crates.setup()
    end,
  },
}
