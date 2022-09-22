-- TODO: Setup neotest
local neotest_ok, neotest = pcall(require, "neotest")
if not neotest_ok then
  vim.notify("Failed to require neotest")
  return
end

local adapters = {}

local nt_go_ok, nt_go = pcall(require, "neotest-go")
if nt_go_ok then
  table.insert(adapters, nt_go({}))
end

local nt_rust_ok, nt_rust = pcall(require, "neotest-rust")
if nt_rust_ok then
  table.insert(adapters, nt_rust({}))
end

local nt_dart_ok, nt_dart = pcall(require, "neotest-dart")
if nt_dart_ok then
  table.insert(adapters, nt_dart({}))
end

local nt_vim_test_ok, nt_vim_test = pcall(require, "neotest-vim-test")
if nt_vim_test_ok then
  table.insert(
    adapters,
    nt_vim_test({ ignore_filetypes = { "go", "dart", "rust" } })
  )
end

neotest.setup({
  adapters = adapters,
})
