local copilot_ok, copilot = pcall(require, "copilot")

if not copilot_ok then
  vim.notify("Failed to load copilot")
  return
end

-- needs to be global then copilot reeds it from the global environment
-- copilot_node_command =
--   "/home/rencedm112/.local/share/pnpm/nodejs/16.17.0/bin/node"
copilot.setup({})

local copilot_cmp_ok, copilot_cmp = pcall(require, "copilot_cmp")

if not copilot_cmp_ok then
  vim.notify("Failed to load copilot-cmp")
  return
end

copilot_cmp.setup()
