function win(direction, overwrite)
  local focus_first = direction == 'k' or direction == 'h'
  local horizontal = direction == 'h' or direction == 'l'
  local current_window = vim.api.nvim_get_current_win()
  local cursor_position = vim.api.nvim_win_get_cursor(current_window)
  local current_buffer = vim.api.nvim_get_current_buf()
  if overwrite then
    vim.cmd('wincmd ' .. direction)
  end
  local new_window = vim.api.nvim_get_current_win()
  if current_window == new_window then
    if horizontal then
      vim.cmd 'vsplit'
    else
      vim.cmd 'split'
    end
    if focus_first then
      vim.api.nvim_set_current_win(current_window)
    end
  else
    vim.api.nvim_set_current_buf(current_buffer)
  end
  vim.api.nvim_win_set_cursor(new_window, cursor_position)
end

vim.keymap.set({ 'n', 'v' }, '<leader>wL', function()
  win('l', true)
end, { desc = 'Copy window to Right' })
vim.keymap.set({ 'n', 'v' }, '<leader>wH', function()
  win('h', true)
end, { desc = 'Copy window to Left' })
vim.keymap.set({ 'n', 'v' }, '<leader>wK', function()
  win('k', true)
end, { desc = 'Copy window to Up' })
vim.keymap.set({ 'n', 'v' }, '<leader>wJ', function()
  win('j', true)
end, { desc = 'Copy window to Down' })
vim.keymap.set({ 'n', 'v' }, '<leader>wl', function()
  win('l', false)
end, { desc = 'Split window to Right' })
vim.keymap.set({ 'n', 'v' }, '<leader>wh', function()
  win('h', false)
end, { desc = 'Split window to Left' })
vim.keymap.set({ 'n', 'v' }, '<leader>wk', function()
  win('k', false)
end, { desc = 'Split window to Up' })
vim.keymap.set({ 'n', 'v' }, '<leader>wj', function()
  win('j', false)
end, { desc = 'Split window to Down' })
