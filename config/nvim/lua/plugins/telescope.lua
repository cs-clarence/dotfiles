return {
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      local plugin_ok, plugin = pcall(require, "telescope")
      if not plugin_ok then
        vim.notify("Failed to require telescope")
        return
      end

      plugin.setup({
        extensions = {
          file_browser = {
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            auto_depth = true,
            depth = 1,

            -- Launch folder browser from path rather than cwd
            cwd_to_path = true,

            -- Use fd when available
            use_fd = true,

            -- Don't show gitignored files in the browser
            -- respect_gitignore = true,

            -- Show hidden files
            hidden = true,
          },
        },
      })

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
