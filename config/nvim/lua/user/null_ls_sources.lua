local null_ls_ok, null_ls = pcall(require, "null-ls")
local database = require("user.database")
if not null_ls_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

local default_sources = {
  formatting.prettierd,

  formatting.black.with({ extra_args = { "--fast" } }),

  formatting.stylua,

  formatting.dart_format,

  -- go stuff
  formatting.gofumpt,
  formatting.goimports,
  formatting.golines,
  -- end go stuff

  formatting.clang_format,

  formatting.rustfmt,
  formatting.sql_formatter.with({
    extra_args = { "--language", database.config.driver },
  }),
  formatting.shfmt,
}

local M = {}

M.sources = default_sources

function M.add_sources(sources)
  for _, v in pairs(sources) do
    table.insert(M.sources, v)
  end
end

function M.replace_sources(sources)
  M.sources = sources
end

return M
