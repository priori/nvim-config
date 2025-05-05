return function(event)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
  end

  nmap('<enter>', function()
    require('telescope.builtin').lsp_definitions {
      show_line = false,
    }
  end, 'Close Curr. Buff. and Goto Definition')

  nmap('<leader><enter>', function()
    require('telescope.builtin').lsp_references {
      show_line = false,
    }
  end, 'Close Curr. Buff. and Goto References')
end
