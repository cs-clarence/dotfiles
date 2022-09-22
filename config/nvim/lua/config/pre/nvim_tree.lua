local nvim_tree_ok, nvim_tree = pcall(require, "nvim-tree")

if not nvim_tree_ok then
  vim.notify("Failed to require nvim-tree")
  return
end

local nvimTreeConfigOk, nvimTreeConfig = pcall(require, "nvim-tree.config")
if not nvimTreeConfigOk then
  vim.notify("Failed to require nvim-tree.config")
  return
end

local tree_cb = nvimTreeConfig.nvim_tree_callback

nvim_tree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  sort_by = "case_sensitive",
  reload_on_bufenter = true,
  auto_reload_on_write = true,
  open_on_setup_file = false,
  open_on_setup = false,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    width = 30,
    side = "left",
    mappings = {
      custom_only = false,
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "v", cb = tree_cb("vsplit") },
      },
    },
    number = false,
    relativenumber = false,
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = false, -- show .gitinogore'd in the tree
    timeout = 500,
  },
  renderer = {
    group_empty = false,
    highlight_opened_files = "all", -- "all" | "name" | "none" | "icon"
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" },
    exclude = {},
  },
})
