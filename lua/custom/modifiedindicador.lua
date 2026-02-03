local indicators = {}

local function close_indicator(win)
  local entry = indicators[win]
  if not entry then
    return
  end

  if entry.float and vim.api.nvim_win_is_valid(entry.float) then
    vim.api.nvim_win_close(entry.float, true)
  end

  if entry.buf and vim.api.nvim_buf_is_valid(entry.buf) then
    pcall(vim.api.nvim_buf_delete, entry.buf, { force = true })
  end

  indicators[win] = nil
end

local function show_indicator(win, text, hl, duration)
  close_indicator(win) -- re-create to keep position in sync with window size

  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { text })

  local width = vim.fn.strdisplaywidth(text)
  local float = vim.api.nvim_open_win(buf, false, {
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
  })

  vim.api.nvim_win_set_option(float, 'winhl', 'Normal:' .. hl)

  indicators[win] = {
    float = float,
    buf = buf,
    text = text,
  }

  if duration then
    vim.defer_fn(function()
      close_indicator(win)
    end, duration)
  end
end

local function should_ignore(buf)
  return vim.bo[buf].buftype ~= '' or not vim.api.nvim_buf_is_loaded(buf)
end

local function update_window(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end

  local buf = vim.api.nvim_win_get_buf(win)
  if should_ignore(buf) then
    close_indicator(win)
    return
  end

  if vim.bo[buf].modified then
    show_indicator(win, ' ● Modified! ', 'WarningMsg')
    return
  end

  -- Keep "Saved" message alive until its timer closes it
  local current = indicators[win]
  if current and current.text == ' Saved ✓ ' then
    return
  end

  close_indicator(win)
end

local function update_windows_for_buf(buf)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf then
      update_window(win)
    end
  end
end

-- Atualiza de forma reativa sempre que o estado "modified" mudar
vim.api.nvim_create_autocmd('BufModifiedSet', {
  callback = function(args)
    update_windows_for_buf(args.buf)
  end,
})

-- Garante atualização ao entrar/trocar de janela ou redimensionar
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'WinEnter', 'WinResized' }, {
  callback = function(args)
    local win = args.win or vim.api.nvim_get_current_win()
    vim.defer_fn(function()
      update_window(win)
    end, 5)
  end,
})

-- Indicador de "Saved" após salvar
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args)
    local buf = args.buf
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) and vim.api.nvim_win_get_buf(win) == buf and not should_ignore(buf) then
        show_indicator(win, ' Saved ✓ ', 'DiffAdded', 1800)
      end
    end

    -- Depois de exibir o "Saved", revalida o estado para remover se necessário
    vim.defer_fn(function()
      update_windows_for_buf(buf)
    end, 1850)
  end,
})

-- Limpa indicadores quando a janela fecha
vim.api.nvim_create_autocmd('WinClosed', {
  callback = function(args)
    local win = tonumber(args.match)
    close_indicator(win)
  end,
})
