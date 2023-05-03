return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("telescope").load_extension("file_browser")

      local default_opts = require("defaults").keymap.opts
      local set = vim.keymap.set

      -- set("n", "<space>fb", ":Telescope file_browser<cr>", default_opts)
      set(
        "n",
        "<space>fb",
        ":Telescope file_browser path=%:p:h select_buffer=true<cr>",
        default_opts
      )
    end,
  },
}
