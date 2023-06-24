return {
  setup = function()
    vim.g.rust_recommended_style = false
  end,
  config = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          autoreload = true,
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          ignored = {
            ["async_trait"] = "async_trait",
            ["tonic"] = "async_trait",
            ["tonic::codegen"] = "async_trait",
            ["axum"] = "async_trait",
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
  },
}
