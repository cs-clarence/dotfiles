return {
  {
    "hood/popui.nvim",
    config = function()
      vim.ui.select = require("popui.ui-overrider")
      vim.ui.input = require("popui.input-overrider")
      local set = vim.keymap.set
      set(
        "n",
        ",d",
        require("popui.diagnostics-navigator"),
        { noremap = true, silent = true }
      )
      set(
        "n",
        ",m",
        require("popui.marks-manager"),
        { noremap = true, silent = true }
      )
      set(
        "n",
        ",r",
        require("popui.references-navigator"),
        { noremap = true, silent = true }
      )
    end,
  },
}
