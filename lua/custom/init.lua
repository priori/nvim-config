local function is_empty_unmodified(buf)
  return vim.api.nvim_buf_is_loaded(buf)
    and vim.api.nvim_buf_get_name(buf) == ''
    and vim.api.nvim_buf_get_option(buf, 'buflisted')
    and vim.api.nvim_buf_get_option(buf, 'buftype') == ''
    and vim.api.nvim_buf_get_option(buf, 'filetype') == ''
    and not vim.api.nvim_buf_get_option(buf, 'modified')
    and vim.api.nvim_buf_line_count(buf) == 1
end

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = '*',
  callback = function()
    local buffers = vim.api.nvim_list_bufs()
    local current = vim.api.nvim_get_current_buf()
    for _, buffer in ipairs(buffers) do
      if is_empty_unmodified(buffer) and buffer ~= current then
        vim.api.nvim_buf_delete(buffer, {})
      end
    end
  end,
})

vim.api.nvim_create_autocmd('VimLeave', {
  callback = function()
    if vim.fn.filewritable(vim.fn.getcwd() .. '/.session.vim') == 1 then
      vim.cmd('mksession! ' .. vim.fn.getcwd() .. '/.session.vim')
    end
  end,
})

local function show_initial_telescope()
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      local cwd = vim.loop.cwd()
      local git = vim.loop.fs_stat(cwd .. '/.git')
      if vim.fn.argv(0) == '' and git then
        require('telescope.builtin').find_files()
      end
    end,
  })
end

if vim.fn.argv(0) == '' then
  if vim.fn.filereadable(vim.fn.getcwd() .. '/.session.vim') == 1 then
    vim.cmd 'source .session.vim'
    local buffs = vim.api.nvim_list_bufs()
    local normal_buffs_count = 0
    for _, buf in ipairs(buffs) do
      if vim.api.nvim_buf_get_name(buf) ~= '' then
        normal_buffs_count = normal_buffs_count + 1
      end
    end
    if normal_buffs_count == 0 then
      show_initial_telescope()
    end
  else
    buffs = vim.api.nvim_list_bufs()
    show_initial_telescope()
  end
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
