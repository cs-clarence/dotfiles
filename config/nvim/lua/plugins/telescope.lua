return {
  {

    "nvim-telescope/telescope.nvim",
    config = function()
      local plugin_ok, plugin = pcall(require, "telescope")
      if not plugin_ok then
        vim.notify("Failed to require telescope")
        return
      end

      local fb_actions_ok, fb_actions =
        pcall(require, "telescope._extensions.file_browser.actions")

      if not fb_actions_ok then
        vim.notify(
          "Failed to require telescope._extensions.file_browser.actions"
        )
        return
      end

      plugin.setup({
        extensions = {
          file_browser = {
            -- theme = "ivy",
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
            mappings = {
              ["i"] = {
                ["<A-c>"] = fb_actions.create,
                ["<S-CR>"] = fb_actions.create_from_prompt,
                ["<A-r>"] = fb_actions.rename,
                ["<A-m>"] = fb_actions.move,
                ["<A-y>"] = fb_actions.copy,
                ["<A-d>"] = fb_actions.remove,
                ["<C-o>"] = fb_actions.open,
                ["<C-g>"] = fb_actions.goto_parent_dir,
                ["<C-e>"] = fb_actions.goto_home_dir,
                ["<C-w>"] = fb_actions.goto_cwd,
                ["<C-t>"] = fb_actions.change_cwd,
                ["<C-f>"] = fb_actions.toggle_browser,
                ["<C-h>"] = fb_actions.toggle_hidden,
                ["<C-s>"] = fb_actions.toggle_all,
                ["<bs>"] = fb_actions.backspace,
              },
              ["n"] = {
                ["c"] = fb_actions.create,
                ["r"] = fb_actions.rename,
                ["m"] = fb_actions.move,
                ["y"] = fb_actions.copy,
                ["d"] = fb_actions.remove,
                ["o"] = fb_actions.open,
                ["g"] = fb_actions.goto_parent_dir,
                ["e"] = fb_actions.goto_home_dir,
                ["w"] = fb_actions.goto_cwd,
                ["t"] = fb_actions.change_cwd,
                ["f"] = fb_actions.toggle_browser,
                ["h"] = fb_actions.toggle_hidden,
                ["s"] = fb_actions.toggle_all,
              },
            },
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
      keymap("n", [[<leader>fd]], builtins.buffers, default_opts)
      keymap("n", [[<leader>fh]], builtins.help_tags, default_opts)
    end,
  },
}
