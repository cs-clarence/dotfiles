local toggle_term_ok, toggle_term = pcall(require, "toggleterm")
if not toggle_term_ok then
  vim.notify("Failed to require toggleterm")
  return
end

toggle_term.setup({
  -- open_mapping = [[<leader>tr]],
  insert_mappings = true,
  terminal_mappings = true,
  hide_numbers = true,
  direction = "float",
})
