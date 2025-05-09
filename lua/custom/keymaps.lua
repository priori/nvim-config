-- moving cursor
vim.keymap.set({ 'i', 't', 'c' }, '<C-h>', '<Left>')
vim.keymap.set({ 'i', 't', 'c' }, '<C-l>', '<Right>')
vim.keymap.set({ 'i', 't', 'c' }, '<C-j>', '<down>')
vim.keymap.set({ 'i', 't', 'c' }, '<C-k>', '<up>')
vim.keymap.set({ 'i', 't', 'c' }, '<C-S-h>', '<S-Left>')
vim.keymap.set({ 'i', 't', 'c' }, '<C-S-l>', '<S-Right>')

-- deleting
vim.keymap.set({ 'i', 'c', 't' }, '<C-g>', '<BackSpace>')
vim.keymap.set({ 'i', 'c', 't' }, '<C-;>', '<Delete>')

-- moving lines
vim.keymap.set('n', '<C-S-j>', function()
  vim.cmd 'm+1'
end)
vim.keymap.set('n', '<C-S-k>', function()
  vim.cmd 'm-2'
end)
vim.api.nvim_set_keymap('v', '<C-S-j>', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<C-S-k>', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

-- disabling <Esc> in insert mode
vim.keymap.set('i', '<Esc>', '<Nop>')
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('i', '<c-c>', '<Esc>')

-- scrolling
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')

-- dealing with buffers
function quit()
  local buffers = vim.api.nvim_list_bufs()
  local unsaved_buffers = ''
  local terminal_buffers = ''
  for _, buf in ipairs(buffers) do
    if vim.fn.getbufvar(buf, '&modified') == 1 then
      if vim.fn.bufname(buf) == '' then
        unsaved_buffers = unsaved_buffers .. '\n- [No Name]'
      else
        unsaved_buffers = unsaved_buffers .. '\n- ' .. vim.fn.bufname(buf)
      end
    end
    if vim.fn.getbufvar(buf, '&buftype') == 'terminal' then
      terminal_buffers = terminal_buffers .. '\n- ' .. vim.fn.bufname(buf)
    end
  end
  if unsaved_buffers ~= '' then
    vim.notify('Buffer is modified, use :w to save or :bd! to force close!' .. unsaved_buffers, 'warn', {
      title = 'Buffer is modified',
    })
    return
  end
  if terminal_buffers ~= '' then
    vim.notify('Buffer terminal, use exit to close!' .. terminal_buffers, 'warn', {
      title = 'Cannot close terminal buffer',
    })
    return
  end
  vim.cmd ':x'
end
vim.keymap.set('n', '<leader>q', quit, { desc = '[Q]uit' })
vim.keymap.set('n', 'ZZ', quit, { desc = '[Q]uit' })

vim.keymap.set('n', '<leader>bd', function()
  if vim.bo.modified then
    vim.notify('Buffer is modified, use :w to save or :bd! to force close!', 'warn', {
      title = 'Buffer is modified',
    })
    return
  end
  if vim.fn.getbufvar(vim.fn.bufnr '%', '&buftype') == 'terminal' then
    vim.notify('Buffer terminal, use exit to close!', 'warn', {
      title = 'Cannot close terminal buffer',
    })
    return
  end
  vim.cmd 'bd'
end, { desc = '[D]elete [B]uffer' })

vim.keymap.set({ 'n', 'v' }, '<c-s>', function()
  vim.cmd 'w'
end)

vim.keymap.set('n', '<leader>ww', function()
  vim.cmd 'w'
end, { desc = 'Save ([W]rite)' })

vim.keymap.set('n', '<leader>wd', function()
  vim.cmd 'w'
  vim.cmd 'bd'
end, { desc = 'Save ([W]rite) & [D]elete Buffer' })

vim.keymap.set('n', '<leader>wq', function()
  vim.cmd 'w'
  vim.cmd 'q'
end, { desc = 'Save ([W]rite) & [Q]uit' })
