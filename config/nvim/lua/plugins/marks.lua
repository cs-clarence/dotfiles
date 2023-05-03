return {
  {
    "chentoast/marks.nvim",
    config = function()
      local plugin_ok, plugin = pcall(require, "marks")

      if not plugin_ok then
        vim.notify("Unable to load marks.nvim", vim.log.levels.ERROR)
        return
      end
      plugin.setup({
        default_mappings = false,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        mappings = {
          -- Set next available lowercase mark at cursor.
          set_next = "m,",
          -- Toggle next available mark at cursor.
          toggle = "m;",
          -- Deletes all marks on current line.
          delete_line = "dm-",
          -- Deletes all marks in current buffer.
          delete_buf = "dm<space>",
          -- Goes to next mark in buffer.
          next = "]m",
          -- Goes to previous mark in buffer.
          prev = "[m",
          -- Previews mark (will wait for user input). press <cr> to just preview the next mark.
          preview = "m:",
          -- Sets a letter mark (will wait for input).
          set = "m",
          -- Delete a letter mark (will wait for input).
          delete = "dm",

          -- Sets a bookmark from group[0-9].
          ["set_bookmark[0-9]"] = "m[0-9]",
          -- Deletes all bookmarks from group[0-9].
          ["delete_bookmark[0-9]"] = "dm[0-9]",
          -- Deletes the bookmark under the cursor.
          delete_bookmark = "dm=",
          -- Moves to the next bookmark having the same type as the
          -- bookmark under the cursor.
          next_bookmark = "}m",
          --Moves to the previous bookmark having the same type as the
          -- bookmark under the cursor.
          prev_bookmark = "{m",
          --Moves to the next bookmark of the same group type. Works by
          --first going according to line number, and then according to buffer
          --number.
          ["next_bookmark[0-9]"] = "",
          -- Moves to the previous bookmark of the same group type. Works by
          -- first going according to line number, and then according to buffer
          -- number.
          ["prev_bookmark[0-9]"] = "",
          -- Prompts the user for a virtual line annotation that is then placed
          -- above the bookmark. Requires neovim 0.6+ and is not mapped by default.
          annotate = "",
        },
      })
    end,
  },
}
