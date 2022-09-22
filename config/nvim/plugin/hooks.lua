local scan_ok, scan = pcall(require, "plenary.scandir")

if not scan_ok then
  vim.notify("Failed to load plenary.scandir")
  return
end

local function basename(str)
  local name = string.gsub(str, "(.*/)(.*)", "%2")
  return name
end

-- Load all plugins in pre directory
local function load_pre_plugins()
  for _, entry in
    pairs(
      scan.scan_dir(
        vim.fn.stdpath("config") .. "/lua/config/pre",
        { depth = 1, add_dir = true }
      )
    )
  do
    require("config.pre." .. string.gsub(basename(entry), ".lua", ""))
  end
end
load_pre_plugins()

-- Load the local config file
local function load_local_config()
  local config_file_names = { ".nvimrc.lua", ".exrc.lua" }
  for _, v in pairs(config_file_names) do
    local ok, run_config =
      pcall(loadfile, vim.fn.getcwd() .. "/" .. v, "bt, {_G = _G}")

    if ok and run_config ~= nil then
      run_config()
      break
    end
  end
end
load_local_config()

-- Load all plugins in post directory
local function load_post_plugins()
  for _, entry in
    pairs(
      scan.scan_dir(
        vim.fn.stdpath("config") .. "/lua/config/post",
        { depth = 1, add_dirs = true }
      )
    )
  do
    require("config.post." .. string.gsub(basename(entry), ".lua", ""))
  end
end
load_post_plugins()
