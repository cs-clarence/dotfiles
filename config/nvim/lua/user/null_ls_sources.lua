local null_ls_ok, null_ls = pcall(require, "null-ls")
local database = require("user.database")
if not null_ls_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local hover = null_ls.builtins.hover

local default_sources = {
  -- JS, TS, Stylesheets, HTML, etc.
  formatting.prettierd,

  -- Python
  formatting.black,
  formatting.isort,

  -- Lua
  formatting.stylua,

  -- Dart
  formatting.dart_format,

  -- Dart
  formatting.dart_format,

  -- Terraform
  formatting.terraform_fmt,

  -- Go
  formatting.gofumpt,
  formatting.goimports,
  formatting.goimports_reviser,
  formatting.golines,

  -- PHP
  formatting.phpcbf,
  formatting.phpcsfixer,
  -- diagnostics.phpstan,
  -- diagnostics.phpcs,
  -- diagnostics.phpmd,

  -- Docker
  diagnostics.hadolint,

  -- Protobuf Linter
  diagnostics.protolint,

  -- C++, C
  formatting.clang_format,

  -- SQL
  formatting.sql_formatter.with({
    extra_args = { "--language", database.config.driver },
  }),

  -- Shell
  formatting.shfmt,

  -- Dictionary
  hover.dictionary,
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
