local M = {}
M.list = {
  -- Packer can manage itself
  "wbthomason/packer.nvim",

  -- Some dependencies for other packages
  "nvim-lua/plenary.nvim",
  "nvim-lua/popup.nvim",

  -- Some fixes for vim to improve performance, qol and whatnot
  "antoinemadec/FixCursorHold.nvim",

  -- Fzf, a fancy fuzzy finder
  "ibhagwan/fzf-lua",

  -- Lualine Plugin, for the status line at the bottom
  "nvim-lualine/lualine.nvim",

  -- For file icons
  "kyazdani42/nvim-web-devicons",

  -- Nvim-Tree, the file manager on the side
  "kyazdani42/nvim-tree.lua",

  -- ToggleTerm
  "akinsho/toggleterm.nvim",

  -- Code Completion
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  "hrsh7th/cmp-nvim-lsp-signature-help",
  "hrsh7th/nvim-cmp",
  "f3fora/cmp-spell",
  "hrsh7th/cmp-calc",
  -- "hrsh7th/cmp-nvim-lua",
  "uga-rosa/cmp-dictionary",

  -- Snippets
  "L3MON4D3/LuaSnip",
  "saadparwaiz1/cmp_luasnip",
  "rafamadriz/friendly-snippets",

  -- LSP
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "jose-elias-alvarez/null-ls.nvim",

  -- Tagbar
  "preservim/tagbar",

  -- Comment
  "numToStr/Comment.nvim",
  "JoosepAlviste/nvim-ts-context-commentstring",

  -- Trouble
  "folke/trouble.nvim",

  -- TreeSitter
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
  "p00f/nvim-ts-rainbow",

  -- Autotags
  "windwp/nvim-ts-autotag",

  -- Autopairs
  "windwp/nvim-autopairs",

  -- Gitsigns
  "lewis6991/gitsigns.nvim",

  -- Bufferline, for displaying buffers (AKA Tabs in other editors like vs code)
  "akinsho/bufferline.nvim",

  -- Impatient, for faster nvim loading, apparently
  "lewis6991/impatient.nvim",

  -- Indent Blacklines, to show indent lines
  "lukas-reineke/indent-blankline.nvim",

  -- Todo Comments, shows UI for TODOs
  "folke/todo-comments.nvim",

  -- Luadev, vim and plugins autocomplete
  "folke/lua-dev.nvim",

  -- WhichKey, shows suggestions for keystrokes
  "folke/which-key.nvim",

  -- Neotest, a test runner
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-go",
  "rouge8/neotest-rust",
  "sidlatau/neotest-dart",
  "vim-test/vim-test",
  "nvim-neotest/neotest-vim-test",

  -- Nvim-Dap, support for debug adapters
  "mfussenegger/nvim-dap",

  -- Json SchemaStore
  "b0o/SchemaStore.nvim",

  -- Better Filetype detection
  "nathom/filetype.nvim",

  -- SQLS support plugin
  "nanotee/sqls.nvim",

  -- Github Copilot
  -- "github/copilot.vim",
  "zbirenbaum/copilot.lua",
  "zbirenbaum/copilot-cmp",
}

return M
