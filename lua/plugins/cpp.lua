return {
  -- 安装 C++/CUDA 相关工具
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "clang-format", -- C++ formatter
      },
    },
  },
  -- 配置 clangd LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders",
          },
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern(
              "compile_commands.json",
              "compile_flags.txt",
              "CMakeLists.txt",
              ".git"
            )(fname)
          end,
        },
      },
    },
  },
  -- Treesitter 支持
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "c", "cpp", "cuda" },
    },
  },
}
