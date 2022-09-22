-- Set custom filetypes
local config = {
  overrides = {
    -- Set for file extensions
    extensions = {
      gotmpl = "gotmpl",
      tf = "terraform",
      graphqls = "graphql",
      postcss = "css",
    },
    -- Set for specific filenames
    literal = {},
    -- Set the filetype of any full filename matching the regex
    complex = {},
    -- These are same as above but gets the values from return of the functions
    function_extensions = {},
    function_literal = {},
    function_complex = {
      [".+.go[%w-_]+$"] = function()
        local filename = vim.fn.expand("%")
        local pattern = ".+.go([%w-_]+)"
        local _, _, filetype = string.find(filename, pattern)
        vim.bo.filetype = "gotmpl"
      end,
    },

    -- Set for hashbang/shebang on type of the file
    shebang = {},
  },
}

-- vim.cmd([[
--   autocmd BufNewFile,BufRead *.go* if search('{{.\+}}', 'nw') | setlocal filetype=gotmpl | endif
-- ]])

return config
