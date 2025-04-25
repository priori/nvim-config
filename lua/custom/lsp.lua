return function(event)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
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
          -- Se não mudou, tenta a janela à esquerda
          vim.cmd 'wincmd h'
          local win_after_h = vim.api.nvim_get_current_win()
          if win_after_h ~= cur_win then
            target_win = win_after_h
          end
        end
        if target_win then
          vim.api.nvim_win_set_buf(target_win, cur_buf)
          vim.api.nvim_win_set_cursor(target_win, cursor)
        else
          vim.cmd 'vsplit'
          target_win = vim.api.nvim_get_current_win()
        end
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

  local prev = nil

  local deleteAndGoToRefs = function()
    if not vim.bo.modified then
      prev = vim.api.nvim_get_current_buf()
    end
    require('telescope.builtin').lsp_references {
      show_line = false,
    }
  end

  local deleteAndGoToDef = function()
    if not vim.bo.modified then
      prev = vim.api.nvim_get_current_buf()
    end
    require('telescope.builtin').lsp_definitions {
      show_line = false,
    }
  end

  nmap('<s-enter>', deleteAndGoToDef, 'Close Curr. B. and Goto Definition')

  nmap('<leader><s-enter>', deleteAndGoToRefs, 'Close Curr. B. and Goto References')

  vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    callback = function()
      local windows = vim.api.nvim_list_wins()
      for _, win in ipairs(windows) do
        local buf = vim.api.nvim_win_get_buf(win)
        if buf == prev then
          return
        end
      end
      if
        prev ~= nil
        and vim.api.nvim_buf_is_loaded(prev)
        and vim.api.nvim_buf_get_name(prev) ~= ''
        and vim.api.nvim_buf_get_option(prev, 'buflisted')
        and vim.api.nvim_buf_get_option(prev, 'filetype') ~= ''
        and not vim.api.nvim_buf_get_option(prev, 'modified')
      then
        local prevRelativeName = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(prev), ':~:.')
        vim.notify(prevRelativeName, 'message', {
          title = 'Closed ✓',
        })
        vim.cmd('bd ' .. prev)
      end
      prev = nil
    end,
  })
end
