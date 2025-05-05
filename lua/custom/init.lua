-- local function is_empty_unmodified(buf)
--   return vim.api.nvim_buf_is_loaded(buf)
--     and vim.api.nvim_buf_get_name(buf) == ''
--     and vim.api.nvim_buf_get_option(buf, 'buflisted')
--     and vim.api.nvim_buf_get_option(buf, 'buftype') == ''
--     and vim.api.nvim_buf_get_option(buf, 'filetype') == ''
--     and not vim.api.nvim_buf_get_option(buf, 'modified')
--     and vim.api.nvim_buf_line_count(buf) == 1
-- end

local function no_buffs()
  local buffers = vim.api.nvim_list_bufs()
  local normal_buffs_count = 0
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_get_name(buf) ~= '' then
      normal_buffs_count = normal_buffs_count + 1
    end
  end
  return normal_buffs_count == 0
end

local function no_float_wins()
  local windows = vim.api.nvim_list_wins()
  for _, win in ipairs(windows) do
    if vim.api.nvim_win_get_config(win).relative ~= '' then
      return false
    end
  end
  return true
end

if vim.fn.argv(0) == '' and no_buffs() and no_float_wins() then
  vim.api.nvim_create_autocmd('VimEnter', {
    pattern = '*',
    callback = function()
      if no_buffs() and no_float_wins() then
        require('telescope.builtin').find_files()
      end
    end,
  })
end

-- record macro indicators
local register = nil
vim.api.nvim_create_autocmd('RecordingEnter', {
  pattern = '*',
  callback = function()
    register = vim.fn.reg_recording()
    print('Recording macro at ' .. register)
  end,
})

vim.api.nvim_create_autocmd('RecordingLeave', {
  pattern = '*',
  callback = function()
    if register then
      print('Macro recorded at ' .. register)
    else
      print 'Macro recorded.'
    end
  end,
})

require 'custom.modifiedindicador'
