local M = {}
local initialized = false
function M.init()
  vim.g.mapleader = " "
  if initialized then
    error("init() should be only called once")
  end

  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Autocommand that reloads neovim whenever you save the plugins.lua file, doesn't work properly
  -- vim.cmd([[
  -- augroup packer_user_config
  --   autocmd!
  --   autocmd BufWritePost plugins.lua source <afile> | PackerSync
  -- augroup end
  -- ]])

  local lazy_ok, lazy = pcall(require, "lazy")
  if not lazy_ok then
    vim.notify("Couldn't require lazy")
    return
  end

  lazy.setup("plugins")
end

return M
