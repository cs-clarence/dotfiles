-- Config for luasnip goes like this, instead of a setup function
_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath("cache") .. "/luacache_chunks",
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
  },
}

local impatient_ok, _ = pcall(require, "impatient")
if not impatient_ok then
  vim.notify("Failed to require impatient")
  return
end
