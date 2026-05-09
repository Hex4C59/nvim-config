return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")

      local luacheck = vim.fn.stdpath("data") .. "/mason/packages/luacheck/bin/luacheck"
      if vim.fn.executable(luacheck) == 1 then
        lint.linters.luacheck.cmd = luacheck
      end

      lint.linters_by_ft = {
        go = { "golangcilint" },
        lua = { "luacheck" },
      }

      local group = vim.api.nvim_create_augroup("UserLint", { clear = true })
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = group,
        callback = function()
          lint.try_lint()
        end,
        desc = "Run configured linters",
      })
    end,
  },
}
