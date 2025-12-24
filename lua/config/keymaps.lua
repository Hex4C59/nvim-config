-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- 用 jk 代替 ESC 退出插入模式
vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式" })

-- 用 viu 查看当前文件（图片）
vim.keymap.set("n", "<leader>vi", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("silent !viu " .. vim.fn.shellescape(file))
  vim.cmd("redraw!")
end, { desc = "用 viu 查看图片" })

-- 复制文件路径
vim.keymap.set("n", "<leader>cp", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("a", path)
  print("已复制: " .. path)
end, { desc = "复制绝对路径" })
vim.keymap.set("n", "<leader>cr", function()
  local path = vim.fn.expand("%")
  vim.fn.setreg("a", path)
  print("已复制: " .. path)
end, { desc = "复制相对路径" })
