-- NOTE: I don't have much use for which-key for now so I have no configuration here
local which_key_ok, whick_key = pcall(require, "which-key")
if not which_key_ok then
  vim.notify("Failed to reqire which-key")
  return
end

whick_key.setup()
