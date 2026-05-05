--[[
  快捷键映射
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 清除搜索高亮
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 快速退出插入模式
vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式" })

vim.api.nvim_create_user_command("Qacheck", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local name = vim.api.nvim_buf_get_name(buf)
      local modified = vim.bo[buf].modified
      local buftype = vim.bo[buf].buftype
      local job = vim.b[buf].terminal_job_id
      if modified or buftype == "terminal" or job then
        print(string.format("buf=%d modified=%s buftype=%s job=%s name=%s", buf, modified, buftype, job or "", name))
      end
    end
  end
end, { desc = "显示会阻止 :qa 的缓冲区" })

-- 窗口导航
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "跳到左侧窗口" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "跳到下方窗口" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "跳到上方窗口" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "跳到右侧窗口" })

-- 调整窗口大小
vim.keymap.set("n", "<C-Left>", "<C-w><", { desc = "减小窗口宽度" })
vim.keymap.set("n", "<C-Right>", "<C-w>>", { desc = "增大窗口宽度" })
vim.keymap.set("n", "<C-Up>", "<C-w>+", { desc = "增大窗口高度" })
vim.keymap.set("n", "<C-Down>", "<C-w>-", { desc = "减小窗口高度" })

-- 移动行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "下移当前行" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "上移当前行" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "下移选中内容" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "上移选中内容" })

-- 更顺手的缩进
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- 诊断快捷键
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "跳到上一个诊断" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "跳到下一个诊断" })
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { desc = "打开诊断浮窗" })
vim.keymap.set("n", "<leader>q", function()
  vim.diagnostic.setloclist()
  vim.cmd.lopen()
end, { desc = "打开诊断列表" })
