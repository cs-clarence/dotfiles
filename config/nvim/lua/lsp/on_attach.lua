local keymap = vim.keymap.set

local function lsp_set_keymaps(bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local buf_opts = { noremap = true, silent = true, buffer = bufnr }
  keymap("n", "gD", vim.lsp.buf.declaration, buf_opts)
  keymap("n", "gd", vim.lsp.buf.definition, buf_opts)
  keymap("n", "K", vim.lsp.buf.hover, buf_opts)
  keymap("n", "gi", vim.lsp.buf.implementation, buf_opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, buf_opts)
  keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, buf_opts)
  keymap("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, buf_opts)
  keymap("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, buf_opts)
  keymap("n", "<leader>D", vim.lsp.buf.type_definition, buf_opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)
  keymap("n", "gr", vim.lsp.buf.references, buf_opts)
  keymap("n", "<leader>f", vim.lsp.buf.formatting, buf_opts)
end

-- TODO: This is an old approach that is available in neovim 0.7, update according once vim 0.8 is available
-- LSPs to allow formatting capability
local allowed_lsps = { svelte = true }
local function lsp_set_formatting(client)
  if client.name ~= "null-ls" and not allowed_lsps[client.name] then
    client.resolved_capabilities.document_formatting = false -- 0.7 and earlier
    client.resolved_capabilities.documentFormattingProvider = false -- 0.8 and later
  end
end

local function on_attach(client, bufnr)
  lsp_set_keymaps(bufnr)
  lsp_set_formatting(client)
end

return on_attach
