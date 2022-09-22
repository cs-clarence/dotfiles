local nvim_web_devicons_ok, nvim_web_devicons =
  pcall(require, "nvim-web-devicons")
if not nvim_web_devicons_ok then
  vim.notify("Failed to require nvim-web-devicons")
  return
end

nvim_web_devicons.setup()
