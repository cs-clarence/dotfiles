local lualine_ok, lualine = pcall(require, "lualine")
if not lualine_ok then
  vim.notify("Failed to require lualine")
  return
end

lualine.setup({})
