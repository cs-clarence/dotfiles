local nvim_autopairs_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
if not nvim_autopairs_ok then
  vim.notify("Failed to require nvim-autopairs")
  return
end

nvim_autopairs.setup()
