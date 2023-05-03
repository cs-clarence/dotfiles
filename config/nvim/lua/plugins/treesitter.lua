return {

  -- TreeSitter itself
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- TreeSitter Rainbow Brackets
      "p00f/nvim-ts-rainbow",

      -- TextObject
      "nvim-treesitter/nvim-treesitter-textobjects",

      -- Autotags
      "windwp/nvim-ts-autotag",
    },
    config = function()
      local nvim_treesitter_configs_ok, nvim_treesitter_configs =
        pcall(require, "nvim-treesitter.configs")
      if not nvim_treesitter_configs_ok then
        vim.notify("Failed to require nvim-treesitter.configs")
        return
      end

      nvim_treesitter_configs.setup({
        auto_install = true, -- auto install parsers when entering a buffer
        sync_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        indent = {
          enable = true,
          disable = {},
        },
        auto_pairs = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        context_commentstring = {
          enable_autocmd = false, -- Not sure what this is for
          enable = true,
        },

        textobjects = {
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = "@parameter.inner",
            },
            swap_previous = {
              ["<leader>A"] = "@parameter.inner",
            },
          },
          lsp_interop = {
            enable = true,
            border = "none",
            floating_preview_opts = {},
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
          select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              -- You can optionally set descriptions to the mappings (used in the desc parameter of
              -- nvim_buf_set_keymap) which plugins like which-key display
              ["ic"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region",
              },
              -- You can also use captures from other query groups like `locals.scm`
              ["as"] = {
                query = "@scope",
                query_group = "locals",
                desc = "Select language scope",
              },
            },
            -- You can choose the select mode (default is charwise 'v')
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * method: eg 'v' or 'o'
            -- and should return the mode ('v', 'V', or '<c-v>') or a table
            -- mapping query_strings to modes.
            selection_modes = {
              ["@parameter.outer"] = "v", -- charwise
              ["@function.outer"] = "V", -- linewise
              ["@class.outer"] = "<c-v>", -- blockwise
            },
            -- If you set this to `true` (default is `false`) then any textobject is
            -- extended to include preceding or succeeding whitespace. Succeeding
            -- whitespace has priority in order to act similarly to eg the built-in
            -- `ap`.
            --
            -- Can also be a function which gets passed a table with the keys
            -- * query_string: eg '@function.inner'
            -- * selection_mode: eg 'v'
            -- and should return true of false
            include_surrounding_whitespace = true,
          },
        },
      })

      -- local ok, nvim_treesitter_parsers =
      --   pcall(require, "nvim-treesitter.parsers")
      -- if not ok then
      --   vim.notify("Failed to require nvim-treesitter.parsers")
      --   return
      -- end

      -- local parser_configs = nvim_treesitter_parsers.get_parser_configs()
      -- parser_configs.gotmpl = {
      --   install_info = {
      --     url = "https://github.com/ngalaiko/tree-sitter-go-template",
      --     files = { "src/parser.c" },
      --   },
      --   filetype = "gotmpl",
      --   used_by = { "gohtmltmpl", "gotexttmpl", "gotmpl", "yaml" },
      -- }

      -- Setup commands
      vim.cmd([[:TSUpdate]])
    end,
  },
}
