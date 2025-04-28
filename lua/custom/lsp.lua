return function(event)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
  end

  local function find_file_win(filename)
    local windows = vim.api.nvim_list_wins()
    for _, win in ipairs(windows) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.api.nvim_buf_is_loaded(buf) then
        local name = vim.api.nvim_buf_get_name(buf)
        if name == filename then
          return win
        end
      end
    end
    return nil
  end

  nmap('<enter>', function()
    local cur_win = vim.api.nvim_get_current_win()
    local cur_buf = vim.api.nvim_get_current_buf()
    local cur_file = vim.api.nvim_buf_get_name(cur_buf)
    local params = vim.lsp.util.make_position_params()
    vim.lsp.buf_request(0, 'textDocument/definition', params, function(err, result, ctx)
      if err then
        vim.notify('Erro ao buscar definição: ' .. err.message, vim.log.levels.ERROR)
        return
      end
      if not result or vim.tbl_isempty(result) then
        vim.notify('Nenhuma definição encontrada', vim.log.levels.INFO)
        return
      end
      local def = result[1]
      local uri = def.uri or def.targetUri
      local filename = vim.uri_to_fname(uri)
      if filename == cur_file then
        vim.lsp.util.jump_to_location(def, 'utf-8')
      else
        local cursor = vim.api.nvim_win_get_cursor(cur_win)
        local target_win = nil
        vim.cmd 'wincmd l'
        local win_after_l = vim.api.nvim_get_current_win()
        if win_after_l ~= cur_win then
          target_win = win_after_l
        else
          vim.cmd 'wincmd h'
          local win_after_h = vim.api.nvim_get_current_win()
          vim.cmd 'wincmd h'
          local win_after_h2 = vim.api.nvim_get_current_win()
          if win_after_h ~= cur_win then
            if win_after_h2 == win_after_h then
              target_win = nil
            else
              target_win = win_after_h
            end
          end
        end
        local file_win = find_file_win(filename)
        if not target_win then
          if file_win then
            target_win = file_win
          else
            vim.cmd 'vsplit'
            vim.cmd 'wincmd l'
            target_win = vim.api.nvim_get_current_win()
          end
        else
          local target_buf = vim.api.nvim_win_get_buf(target_win)
          local target_file_name = vim.api.nvim_buf_get_name(target_buf)
          if file_win and file_win ~= target_win and target_file_name ~= filename then
            target_win = file_win
          end
        end
        local result_size = table.getn(result)
        vim.api.nvim_set_current_win(target_win)

        vim.api.nvim_win_set_buf(target_win, cur_buf)
        vim.api.nvim_win_set_cursor(target_win, cursor)
        require('telescope.builtin').lsp_definitions {
          show_line = false,
        }
      end
    end)
  end, 'Close Curr. Buff. and Goto Definition')

  nmap('<leader><enter>', function()
    require('telescope.builtin').lsp_references {
      show_line = false,
    }
  end, 'Close Curr. Buff. and Goto References')
end
