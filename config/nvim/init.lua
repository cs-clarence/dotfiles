-- Initialize the plugins first
require("plugin_manager").init()

-- Run other vim specific options
require("user.options")
require("user.keymaps")
require("user.autocmd")
