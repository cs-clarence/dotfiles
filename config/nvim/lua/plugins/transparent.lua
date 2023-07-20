return {
  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    cond = function()
      return not vim.g.vscode
    end,
    config = function()
      local ok, transparent = pcall(require, "transparent")

      if not ok then
        vim.notify("transparent.nvim not found", vim.log.levels.ERROR)
      end

      transparent.setup({
        groups = { -- table: default groups
          "Normal",
          "NormalNC",
          "Comment",
          "Constant",
          "Special",
          "Identifier",
          "Statement",
          "PreProc",
          "Type",
          "Underlined",
          "Todo",
          "String",
          "Function",
          "Conditional",
          "Repeat",
          "Operator",
          "Structure",
          "LineNr",
          "NonText",
          "SignColumn",
          "CursorLineNr",
          "EndOfBuffer",
        },
        extra_groups = {}, -- table: additional groups that should be cleared
        exclude_groups = {}, -- table: groups you don't want to clear
      })
    end,
  },
}
