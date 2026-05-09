--[[
  快捷键映射
--]]

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 清除搜索高亮
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 快速退出插入模式
vim.keymap.set("i", "jk", "<Esc>", { desc = "退出插入模式" })

local function open_terminal()
  if vim.bo.buftype == "" and vim.bo.modifiable and not vim.bo.readonly and vim.api.nvim_buf_get_name(0) ~= "" then
    vim.cmd("write")
  end
  vim.cmd("botright split")
  vim.cmd("resize 12")
  vim.cmd("terminal")
  vim.b.user_terminal = true
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], {
    buffer = true,
    desc = "退出终端模式",
  })
  vim.cmd("startinsert")
end

local function close_terminal()
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == "terminal" and vim.b[buf].user_terminal then
      vim.api.nvim_win_close(win, true)
      return
    end
  end

  vim.notify("没有由 <leader>t 打开的终端窗口", vim.log.levels.WARN)
end

vim.api.nvim_create_user_command("OpenTerminal", open_terminal, { desc = "打开终端" })
vim.api.nvim_create_user_command("CloseTerminal", close_terminal, { desc = "关闭终端" })

vim.keymap.set("n", "<leader>t", open_terminal, { desc = "打开终端" })
vim.keymap.set("n", "<leader>T", close_terminal, { desc = "关闭终端" })

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
