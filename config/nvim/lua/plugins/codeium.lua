return {
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      local codeium_ok, codeium = pcall(require, "codeium")

      if not codeium_ok then
        vim.notify("Codeium is not successfully require")
      end

      codeium.setup({})
    end,
  },
}
