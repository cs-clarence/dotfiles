local M = {}

-- Which colorscheme to set
local default = "dracula"

M.active = default

function M.set_active(colorscheme)
  M.active = colorscheme
end

function M.install(colorschemes)
  for _, v in pairs(colorschemes) do
    table.insert(M.list, v)
  end
end

return M
