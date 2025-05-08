local in_cmdline = false

vim.api.nvim_create_autocmd('CmdlineEnter', {
  callback = function()
    in_cmdline = true
  end,
})

local win_indicators = {}

local function show_indicator(win, text, hl, duration)
  if win_indicators[win] and vim.api.nvim_win_is_valid(win_indicators[win].float_win) then
    vim.api.nvim_win_close(win_indicators[win].float_win, true)
  end

  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

  local width = vim.fn.strdisplaywidth(text)
  local opts = {
    relative = 'win',
    win = win,
    anchor = 'NE',
    width = width,
    height = 1,
    row = 0,
    col = vim.api.nvim_win_get_width(win),
    focusable = false,
    style = 'minimal',
    noautocmd = true,
  }

  local float_win = vim.api.nvim_open_win(buf, false, opts)
  vim.api.nvim_win_set_option(float_win, 'winhl', 'Normal:' .. hl)

  win_indicators[win] = {
    float_win = float_win,
    buf = buf,
    text = text,
    hl = hl,
  }

  if duration then
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
      end
      win_indicators[win] = nil
    end, duration)
  end
end

local function update_indicator_for_win(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local buf = vim.api.nvim_win_get_buf(win)
  if vim.bo[buf].buftype ~= '' then
    return
  end

  if vim.bo[buf].modified then
    show_indicator(win, ' ● Modified!', 'WarningMsg')
  else
    local current = win_indicators[win]
    if current and current.text ~= ' Saved ✓' then
      if vim.api.nvim_win_is_valid(current.float_win) then
        vim.api.nvim_win_close(current.float_win, true)
      end
      win_indicators[win] = nil
    end
  end
end

local function update_all_windows()
  if in_cmdline then
    return
  end

  local active_wins = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    active_wins[win] = true
    update_indicator_for_win(win)
  end

  for win, data in pairs(win_indicators) do
    if not active_wins[win] then
      if data.float_win and vim.api.nvim_win_is_valid(data.float_win) then
        vim.api.nvim_win_close(data.float_win, true)
      end
      win_indicators[win] = nil
    end
  end
end

vim.api.nvim_create_autocmd('CmdlineLeave', {
  callback = function()
    in_cmdline = false
    vim.defer_fn(update_all_windows, 10)
  end,
})

-- Autocomandos para atualizar indicador ao modificar, entrar, redimensionar etc.
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'TextChanged', 'TextChangedI', 'WinEnter', 'WinResized' }, {
  callback = function()
    vim.defer_fn(update_all_windows, 10)
  end,
})

-- Indicador de "Saved ✓"
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args)
    local buf = args.buf
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
        if vim.bo[buf].buftype == '' then
          show_indicator(win, ' Saved ✓', 'DiffAdded', 2000)
        end
      end
    end
  end,
})

-- Autocmd extra para limpar quando janela for fechada
vim.api.nvim_create_autocmd('WinClosed', {
  callback = function(args)
    local win_id = tonumber(args.match)
    local entry = win_indicators[win_id]
    if entry and entry.float_win and vim.api.nvim_win_is_valid(entry.float_win) then
      vim.api.nvim_win_close(entry.float_win, true)
    end
    win_indicators[win_id] = nil
  end,
})

