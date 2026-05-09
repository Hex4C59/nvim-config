return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})

      local ok_cmp, cmp = pcall(require, "cmp")
      if not ok_cmp then
        return
      end

      local ok_autopairs, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
      if not ok_autopairs then
        return
      end

      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}
