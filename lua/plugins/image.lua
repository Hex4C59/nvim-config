return {
  -- 图片文件用 viu 查看，不在 nvim 中打开
  {
    "nvim-neo-tree/neo-tree.nvim",
    optional = true,
    opts = {
      filesystem = {
        use_libuv_file_watcher = false,
      },
      -- 图片文件用外部程序打开
      window = {
        mappings = {
          ["<cr>"] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local ext = path:match("%.([^%.]+)$")
            if ext and vim.tbl_contains({ "png", "jpg", "jpeg", "gif", "webp", "bmp" }, ext:lower()) then
              vim.fn.system({ "viu", path })
              return
            end
            require("neo-tree.sources.filesystem.commands").open(state)
          end,
        },
      },
    },
  },
}
