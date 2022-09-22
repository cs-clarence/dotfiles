-- Format before buffer gets written to a file
vim.cmd([[
	autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
]])
