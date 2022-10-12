local ok, refactoring = pcall(require, "refactoring")

if not ok then
  vim.notify("Failed to load refactoring")
  return
end

refactoring.setup({
  prompt_func_return_type = {
    go = false,
    java = false,

    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  prompt_func_param_type = {
    go = false,
    java = false,

    cpp = false,
    c = false,
    h = false,
    hpp = false,
    cxx = false,
  },
  printf_statements = {},
  print_var_statements = {},
})

local keymap = vim.keymap.set
-- prompt for a refactor to apply when the remap is triggered
keymap("v", "<leader>rr", function()
  refactoring.select_refactor()
end, { noremap = true, silent = true, expr = false })
