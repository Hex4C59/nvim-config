return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  keys = {
    { "<leader>oc", function() require("opencode").toggle() end, mode = { "n", "t" }, desc = "切换 opencode" },
  },
  config = function()
    local function terminal_opts()
      return {
        split = "right",
        width = math.floor(vim.o.columns * 0.35),
      }
    end

    local function run_from_rightmost(fn)
      local previous_win = vim.api.nvim_get_current_win()
      local current_win = previous_win
      while true do
        vim.cmd("wincmd l")
        local next_win = vim.api.nvim_get_current_win()
        if next_win == current_win then
          break
        end
        current_win = next_win
      end
      fn()
      if vim.api.nvim_win_is_valid(previous_win) then
        vim.api.nvim_set_current_win(previous_win)
      end
    end

    vim.g.opencode_opts = {
      server = {
        start = function()
          run_from_rightmost(function()
            require("opencode.terminal").open("opencode --port", terminal_opts())
          end)
        end,
        stop = function()
          require("opencode.terminal").close()
        end,
        toggle = function()
          run_from_rightmost(function()
            require("opencode.terminal").toggle("opencode --port", terminal_opts())
          end)
        end,
      },
    }
    vim.o.autoread = true

    vim.api.nvim_create_autocmd("TermOpen", {
      pattern = "term://*opencode*",
      callback = function(event)
        vim.keymap.set("t", "jk", [[<C-\><C-n>]], {
          buffer = event.buf,
          desc = "退出 opencode 终端模式",
        })
      end,
    })

    -- 询问 / 选择 / 切换
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "询问 opencode..." })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "执行 opencode 操作..." })
    vim.keymap.set({ "n", "t" }, "<leader>oc", function() require("opencode").toggle() end, { desc = "切换 opencode" })

    -- 操作符映射
    vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end, { desc = "将范围添加到 opencode", expr = true })
    vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "将当前行添加到 opencode", expr = true })

    -- 滚动终端
    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end, { desc = "向上滚动 opencode" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "向下滚动 opencode" })

    -- 恢复默认 <C-a>/<C-x>（递增/递减）
    vim.keymap.set("n", "+", "<C-a>", { desc = "递增光标下的数值", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "递减光标下的数值", noremap = true })
  end,
}
