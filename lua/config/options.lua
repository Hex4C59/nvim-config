-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 禁用文件监视，避免 ENOSPC inotify watch 限制
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- 禁用自动切换到 git 根目录
vim.g.root_spec = { "cwd" }

-- 禁用 snacks 文件监视
vim.g.snacks_watch = false

-- 禁用大文件检测警告
vim.g.bigfile_size = 1024 * 1024 * 10 -- 10MB

-- 自动保存
vim.opt.autowrite = true
vim.opt.autowriteall = true

-- 禁用系统剪贴板（没有 xclip/xsel）
-- vim.opt.clipboard = ""

-- 使用 OSC 52 实现远程剪贴板同步（Windows Terminal 支持）
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- 失去焦点或离开缓冲区时自动保存
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

-- 图片文件自动用 viu 查看后关闭 buffer
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.bmp" },
  callback = function()
    local file = vim.fn.expand("%:p")
    vim.defer_fn(function()
      vim.cmd("bdelete!")
      vim.fn.system({ "viu", file })
      vim.cmd("redraw!")
    end, 10)
  end,
})

-- 透明背景（需要终端支持亚克力/透明效果）
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local groups = {
      "Normal",
      "NormalNC",
      "NormalFloat",
      "FloatBorder",
      "SignColumn",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "TelescopeNormal",
      "TelescopeBorder",
      "WhichKeyFloat",
      "CursorLine",
      "CursorLineNr",
      "LineNr",
      "Folded",
      "NonText",
      "SpecialKey",
      "VertSplit",
      "EndOfBuffer",
    }
    for _, group in ipairs(groups) do
      vim.cmd("hi " .. group .. " guibg=NONE ctermbg=NONE")
    end
  end,
})

-- 立即应用透明背景（针对当前 colorscheme）
vim.defer_fn(function()
  vim.cmd("doautocmd ColorScheme")
end, 100)
