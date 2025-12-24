return {
  {
    "folke/snacks.nvim",
    opts = {
      -- 禁用所有文件监视相关功能
      git = { enabled = false },
      gitbrowse = { enabled = false },
      explorer = {
        enabled = true,
        watch = false,
        filter = {
          git_ignore = false,  -- 显示被 gitignore 的文件
        },
      },
      notifier = {
        enabled = true,
        -- 过滤掉 inotify 相关的错误通知
        filter = function(notif)
          return not (notif.msg and notif.msg:match("ENOSPC"))
        end,
      },
    },
    init = function()
      vim.g.snacks_watch = false
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      watch_gitdir = { enable = false },
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = {
        use_libuv_file_watcher = false,
        filtered_items = {
          hide_gitignored = false,  -- 显示被 gitignore 的文件
        },
      },
    },
  },
}
