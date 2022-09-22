local comment_ok, comment = pcall(require, "Comment")

if not comment_ok then
  vim.notify("Failed to require cmp")
  return
end

comment.setup({})
