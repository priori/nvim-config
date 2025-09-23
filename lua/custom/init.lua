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

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.autoindent = true
