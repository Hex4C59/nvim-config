return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "切换文件浏览器" },
      { "<leader>E", "<cmd>Neotree reveal dir=.<CR>", desc = "以当前目录打开文件浏览器" },
      {
        "<leader>u",
        function()
          vim.cmd("cd ..")
          vim.cmd("Neotree reveal dir=.")
        end,
        desc = "切到上级目录并刷新文件浏览器",
      },
      { "<leader>ge", "<cmd>Neotree float git_status<CR>", desc = "Git 状态" },
    },
    opts = {
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_default",
      },
      window = {
        width = 35,
        mappings = {
          ["<space>"] = "none",
          ["<leader>E"] = "set_root",
          ["<leader>u"] = "navigate_up",
        },
      },
    },
  },
}
