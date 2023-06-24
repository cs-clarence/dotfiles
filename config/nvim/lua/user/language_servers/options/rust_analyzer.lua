return {
  setup = function()
    vim.g.rust_recommended_style = false
  end,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        autoreload = true,
        buildScripts = {
          enable = true,
        },
      },
      inlayHints = {
        reborrowHints = {
          enable = "always",
        },
        lifetimeElisionHints = {
          enable = "always",
          useParameterNames = true,
        },
      },
    },
  },
}
