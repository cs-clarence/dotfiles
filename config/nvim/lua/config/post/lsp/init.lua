local lsp_config_ok, lc = pcall(require, "lspconfig")
if not lsp_config_ok then
  vim.notify("Failed to require lspconfig")
  return
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Setup Handlers
local capabilities_ok, capabilities = pcall(require, "lsp.capabilities")
if not capabilities_ok then
  vim.notify("Failed to load capabilities")
  return
end --

-- Setup Handlers
local on_attach_ok, on_attach = pcall(require, "lsp.on_attach")
if not on_attach_ok then
  vim.notify("Failed to load on_attach")
  return
end --
-- for some reason, pcall with require and mason fails
local mason_ok, mason = pcall(require, "mason")

if not mason_ok then
  vim.notify("Failed to load mason")
  return
end

local mason_lsp_config_ok, mason_lsp_config = pcall(require, "mason-lspconfig")
if not mason_lsp_config_ok then
  vim.notify("Failed to load mason-lspconfig")
  return
end

local has_language_servers, language_servers =
  pcall(require, "user.language_servers")
if not has_language_servers then
  language_servers = {}
end

local opts = {
  lsp_flags = lsp_flags,
  capabilities = capabilities,
  on_attach = on_attach,
}

do
  -- Setup LSPs not supported by mason
  lc.dartls.setup(opts)
end

mason.setup()

mason_lsp_config.setup({
  ensure_installed = language_servers,
})

mason_lsp_config.setup_handlers({
  -- This is a default handler that will be called for each installed server (also for new servers that are installed during a session)
  function(server_name)
    local local_opts = vim.tbl_deep_extend("force", {}, opts)
    local has_custom_opts, custom_opts =
      pcall(require, "user.language_servers.options." .. server_name)
    if has_custom_opts then
      local_opts = vim.tbl_deep_extend("force", opts, custom_opts)
    end
    lc[server_name].setup(local_opts)
  end,
  ["sumneko_lua"] = function(server_name)
    local lua_dev_ok, lua_dev = pcall(require, "lua-dev")

    local local_opts = {}

    if lua_dev_ok then
      local lua_dev_opts = lua_dev.setup({
        library = {
          vimruntime = true, -- runtime path
          types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
          plugins = true, -- installed opt or start plugins in packpath
          -- you can also specify the list of plugins to make available as a workspace library
          -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
        },
        runtime_path = false, -- enable this to get completion in require strings. Slow!
        -- pass any additional options that will be merged in the final lsp config
        lspconfig = opts,
      })
      local_opts = vim.tbl_deep_extend("force", local_opts, lua_dev_opts)
    end

    lc[server_name].setup(local_opts)
  end,
  ["sqls"] = function(server_name)
    local sqls_ok, sqls = pcall(require, "sqls")

    if not sqls_ok then
      vim.notify("Failed to require sqls")
      return
    end
    local has_custom_opts, custom_opts =
      pcall(require, "user.language_servers.options." .. server_name)
    if not has_custom_opts then
      custom_opts = {}
    end

    custom_opts.on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      sqls.on_attach(client, bufnr)
    end

    local local_opts = vim.tbl_deep_extend("force", opts, custom_opts)

    lc[server_name].setup(local_opts)
  end,
})
