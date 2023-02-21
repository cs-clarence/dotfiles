return {
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 1000,
    config = function()
      -- Neoconf runs first
      do
        local ok, plugin = pcall(require, "neoconf")

        if not ok then
          vim.notify("Failed to require neoconf")
          return
        end
        plugin.setup()
      end

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
      end

      -- for some reason, pcall with require and mason fails
      local mason_ok, mason = pcall(require, "mason")

      if not mason_ok then
        vim.notify("Failed to load mason")
        return
      end

      local mason_lsp_config_ok, mason_lsp_config =
        pcall(require, "mason-lspconfig")
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

      vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        })

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "rounded",
        })

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
            if type(custom_opts.config) == "table" then
              local_opts =
                vim.tbl_deep_extend("force", opts, custom_opts.config)
            end

            if type(custom_opts.setup) == "function" then
              custom_opts.setup()
            end
          end

          lc[server_name].setup(local_opts)
        end,
      })
    end,
  },
}
