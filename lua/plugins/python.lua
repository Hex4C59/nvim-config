return {
  -- 安装 Python LSP
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright", -- Python LSP
        "ruff", -- Python linter/formatter
        "black", -- Python formatter
      },
    },
  },
  -- 配置 LSP
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {
          before_init = function(_, config)
            -- 自动检测 .venv 虚拟环境
            local venv = vim.fn.getcwd() .. "/.venv"
            if vim.fn.isdirectory(venv) == 1 then
              config.settings.python.pythonPath = venv .. "/bin/python"
            end
          end,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {},
      },
    },
  },
}
