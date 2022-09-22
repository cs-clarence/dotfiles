local indent_blankline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indent_blankline_ok then
  vim.notify("Failed to require indent_blankline")
  return
end

indent_blankline.setup({
  show_end_of_line = true,
})
