local null_ls_ok, null_ls = pcall(require, "null-ls")
if not null_ls_ok then
  return
end

local sources_ok, sources = pcall(require, "user.null_ls_sources")
if not sources_ok then
  sources = {}
end

-- TODO: right now this function needs to be global to be callable inside autocmd, find a solution without needing to make it global
null_ls.setup({
  debug = false,
  sources = sources.sources,
})
