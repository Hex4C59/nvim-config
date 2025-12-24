return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- 使用本地 gcc 编译，避免预编译 tree-sitter CLI 的 glibc 问题
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "bash",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
      },
    },
  },
}
