return {
  -- 配置 rust-analyzer LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
              },
              checkOnSave = {
                command = "clippy",
              },
              procMacro = {
                enable = true,
              },
            },
          },
        },
      },
    },
  },
  -- Treesitter 支持
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "rust", "toml" },
    },
  },
}
