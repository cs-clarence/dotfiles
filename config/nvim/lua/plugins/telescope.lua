return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local plugin_ok, plugin = pcall(require, "telescope")
      if not plugin_ok then
        vim.notify("Failed to require telescope")
        return
      end

      plugin.setup({})

      local builtins_ok, builtins = pcall(require, "telescope.builtin")
      if not builtins_ok then
        vim.notify("Failed to require telescope.builtin")
        return
      end

      local default_opts = require("defaults").keymap.opts

      -- Keymaps
      local keymap = vim.keymap.set

      keymap("n", [[<leader>ff]], builtins.find_files, default_opts)
      keymap("n", [[<leader>fg]], builtins.live_grep, default_opts)
      keymap("n", [[<leader>fb]], builtins.buffers, default_opts)
      keymap("n", [[<leader>fh]], builtins.help_tags, default_opts)
    end,
  },
}
