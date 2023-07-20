return {
  {
    "folke/neoconf.nvim",
    cond = function()
      return not vim.g.vscode
    end,
    config = require("util.fn").noop,
  },
}
