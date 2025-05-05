local ns = vim.api.nvim_create_namespace 'modified_indicator_ns'
local win_indicators = {}

local function show_indicator(win, text, hl, duration)
  if win_indicators[win] and vim.api.nvim_win_is_valid(win_indicators[win].win) then
    vim.api.nvim_win_close(win_indicators[win].win, true)
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
    win = float_win,
    buf = buf,
    text = text,
    hl = hl,
  }

  if duration then
    vim.defer_fn(function()
      if vim.api.nvim_win_is_valid(float_win) then
        vim.api.nvim_win_close(float_win, true)
        win_indicators[win] = nil
      end
    end, duration)
  end
end

local function update_indicator_for_win(win)
  if not vim.api.nvim_win_is_valid(win) then
    return
  end
  local buf = vim.api.nvim_win_get_buf(win)

  if vim.bo[buf].modified and vim.bo[buf].buftype == '' then
    show_indicator(win, ' ● Modified!', 'WarningMsg')
  else
    local current = win_indicators[win]
    if current and current.text ~= ' Saved ✓' then
      if vim.api.nvim_win_is_valid(current.win) then
        vim.api.nvim_win_close(current.win, true)
      end
      win_indicators[win] = nil
    end
  end
end

local function update_all_windows()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    update_indicator_for_win(win)
  end
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter', 'TextChanged', 'TextChangedI', 'WinEnter', 'WinResized' }, {
  callback = function()
    vim.defer_fn(update_all_windows, 10)
  end,
})

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function(args)
    local saved_buf = args.buf
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_is_valid(win) then
        local win_buf = vim.api.nvim_win_get_buf(win)
        if win_buf == saved_buf and vim.bo[win_buf].buftype == '' then
          show_indicator(win, ' Saved ✓', 'DiffAdded', 2000)
        end
      end
    end
  end,
})
