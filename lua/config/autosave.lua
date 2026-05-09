--[[
  Auto save normal file buffers when editing pauses or focus changes.
--]]

local group = vim.api.nvim_create_augroup("AutoSave", { clear = true })

local function should_save(buf)
  return vim.api.nvim_buf_is_valid(buf)
    and vim.bo[buf].modified
    and vim.bo[buf].modifiable
    and not vim.bo[buf].readonly
    and vim.bo[buf].buftype == ""
    and vim.api.nvim_buf_get_name(buf) ~= ""
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost", "BufLeave" }, {
  group = group,
  callback = function(args)
    if not should_save(args.buf) then
      return
    end

    vim.api.nvim_buf_call(args.buf, function()
      vim.cmd("silent update")
    end)
  end,
  desc = "Auto save modified file buffers",
})
